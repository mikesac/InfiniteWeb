package org.infinite.web.admin;

import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.infinite.db.dao.DaoManager;
import org.infinite.db.dto.Area;
import org.infinite.db.dto.TomcatRoles;
import org.infinite.util.GenericUtil;
import org.infinite.util.ImageUtil;
import org.infinite.web.utils.PagesCst;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MapManager {

	@Autowired
	private	PagesCst pages;

	@Autowired
	private DaoManager daoManager;

	public void setPages(PagesCst pages) {this.pages = pages;}
	public PagesCst getPages() {return pages;}

	public void setDaoManager(DaoManager dao) {this.daoManager = dao;}
	public DaoManager getDaoManager() { return daoManager; }

	@RequestMapping(value="/admin/map/maps.html", method = RequestMethod.GET)
	public ModelAndView initMap(HttpServletRequest request, HttpServletResponse resp, ModelMap model)
	{
		String userName = request.getUserPrincipal().getName();		
		TomcatRoles role = getDaoManager().getUserRole(userName);		
		if(role==null || !role.getRole().equalsIgnoreCase("manager")){
			return new ModelAndView( getPages().getRedirect(request,getPages().getPAGE_ROOT(),"You cannot access this area!") );
		}

		model.addAttribute(getPages().getCONTEXT_PAGES(), getPages());
		model.addAttribute("base", request.getContextPath());

		return new ModelAndView( getPages().getADMIN_MAP(),model );
	}


	@RequestMapping(value="/admin/map/maps.html", method = RequestMethod.POST)
	public ModelAndView saveMap(
			HttpServletRequest request, HttpServletResponse resp, ModelMap model,
			@RequestParam(value="area_name",required=true) String areaName,
			@RequestParam(value="area_desc",required=true) String areaDesc,
			@RequestParam(value="area_world",required=true) int areaWorld,
			@RequestParam(value="area_x",required=true) int areaX,
			@RequestParam(value="area_y",required=true) int areaY,
			@RequestParam(value="area_path",required=true) String path
	)
	{

		try {

			model.addAttribute(getPages().getCONTEXT_PAGES(),getPages());
			
			if(areaName==null || areaName.length()==0)
				throw new Exception("Invalid NAME");

			if(areaDesc==null || areaDesc.length()==0)
				throw new Exception("Invalid DESCRIPTION");

			if(areaX<0)
				throw new Exception("Invalid X");

			if(areaY<0)
				throw new Exception("Invalid Y");

			if(path==null || path.length()==0)
				throw new Exception("Error computing path, please re-upload image");



			String destPath = getPages().getAbsoluteIMG_MAP_PATH();
			String patchPath = destPath;
			File dir = new File(patchPath +"/"+ areaName);
			if(dir.exists())
				throw new Exception("An Area with this name already exist, please rename it");

			dir.mkdir();

			for (int i = 0; i < areaY; i++) {
				for (int j = 0; j < areaX; j++) {

					String src = getPages().getAbsoluteIMG_MAP_PATH_TMP() + "crop_" + i + j + ".jpg";
					String dst = patchPath +"/"+ areaName+"/"+areaName+"_" + i + j + ".jpg";
					File f = new File(src);
					if(!f.exists()){
						throw new Exception("Error accessing file, please re-upload image");
					}
					f.renameTo( new File(dst) );					
				}
			}

			Area area = new Area(areaName,areaDesc,areaWorld,areaX,areaY);
			try{
				getDaoManager().create(area);
			}
			catch (Exception e) {
				throw new Exception("Could not save Area "+areaName + " please contact admin");
			}

			model.addAttribute(PagesCst.CONTEXT_ERROR,"Area Created");

		} catch (Exception e) {
			
			List<List<String>> tiles = new ArrayList<List<String>>();

			for (int i = 0; i < areaY; i++) {
				List<String> xtiles = new ArrayList<String>();
				for (int j = 0; j < areaX; j++) {
					xtiles.add( getPages().getIMG_MAP_PATH_TMP()+"crop_" + i + j + getPages().getIMG_MAP_EXT() );
				}
				tiles.add(xtiles);
			}

			model.addAttribute("tiles", tiles);
			model.addAttribute("nx", areaX);
			model.addAttribute("ny", areaY);
			model.addAttribute("path", path);
			
			model.addAttribute(getPages().getCONTEXT_ERROR(),e.getMessage());
			GenericUtil.err("MapSave Exception", e);
			return new ModelAndView(getPages().getADMIN_MAPPREVIEW(),model);
		}

		return new ModelAndView(getPages().getADMIN_MAP(),model);

	}


	@RequestMapping(value="/admin/map/mapPreview.html", method = RequestMethod.GET)
	public ModelAndView showMap(HttpServletRequest req, HttpServletResponse resp, ModelMap model)
	{
		//		model.addAttribute("tiles", tiles);
		//		model.addAttribute("nx", nx);
		//		model.addAttribute("ny", ny);
		//		model.addAttribute("path", szPath);

		model.addAttribute(getPages().getCONTEXT_PAGES(),getPages());

		return new ModelAndView( getPages().getADMIN_MAPPREVIEW(),model );

	}


	@RequestMapping(value="/admin/map/mapPreview.html", method = RequestMethod.POST)
	public ModelAndView previewMap(HttpServletRequest req, HttpServletResponse resp, ModelMap model)
	{

		// Create a new file upload handler
		ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());

		// Parse the request
		try {
			List<FileItem> items = upload.parseRequest(req);

			InputStream is = null;

			Iterator iter = items.iterator();			
			String szFileName = "error.jpg";

			int nx = 1,ny = 1;

			while (iter.hasNext()) {
				FileItem item = (FileItem) iter.next();

				if (item.isFormField()) {
					String name = item.getFieldName();
					if(name.equalsIgnoreCase("x"))
						nx = GenericUtil.toInt(item.getString(), 1);
					else
						ny = GenericUtil.toInt(item.getString(), 1);
				}
				else{
					is = item.getInputStream();
					szFileName = item.getName();
				}
			}

			String szPath ="";
			if(is!=null && is.available()>0){

				szPath = getPages().getAbsoluteIMG_MAP_PATH_TMP();
				ImageUtil.prepareMapStripes(is,nx,ny,szPath);
			}


			List<List<String>> tiles = new ArrayList<List<String>>();

			for (int i = 0; i < ny; i++) {
				List<String> xtiles = new ArrayList<String>();
				for (int j = 0; j < nx; j++) {
					xtiles.add( getPages().getIMG_MAP_PATH_TMP()+"crop_" + i + j + getPages().getIMG_MAP_EXT() );
				}
				tiles.add(xtiles);
			}

			model.addAttribute("tiles", tiles);
			model.addAttribute("nx", nx);
			model.addAttribute("ny", ny);
			model.addAttribute("path", szPath);

			model.addAttribute(getPages().getCONTEXT_PAGES(),getPages());



		} catch (FileUploadException e) {

			e.printStackTrace();
		}
		catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView( getPages().getADMIN_MAPPREVIEW(),model );

	}

}
