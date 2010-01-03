package org.infinite.web.admin;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.dao.DaoManager;
import org.infinite.db.dto.Npc;
import org.infinite.db.dto.TomcatRoles;
import org.infinite.util.GenericUtil;
import org.infinite.util.ImageUtil;
import org.infinite.web.utils.ControllerUtils;
import org.infinite.web.utils.PagesCst;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class NpcManager {

	@Autowired
	private	PagesCst pages;

	@Autowired
	private DaoManager daoManager;

	public void setPages(PagesCst pages) {this.pages = pages;}
	public PagesCst getPages() {return pages;}

	public void setDaoManager(DaoManager dao) {this.daoManager = dao;}
	public DaoManager getDaoManager() { return daoManager; }

	@RequestMapping(value="/admin/npc/npc.html",method = RequestMethod.GET)
	public ModelAndView initItems(HttpServletRequest request, HttpServletResponse resp, ModelMap model)
	{
		String userName = request.getUserPrincipal().getName();		
		TomcatRoles role = getDaoManager().getUserRole(userName);		
		if(role==null || !role.getRole().equalsIgnoreCase("manager")){
			return new ModelAndView( getPages().getRedirect(request,getPages().getPAGE_ROOT(),"You cannot access this area!") );
		}

		model = getPages().initController(model, request);		
		model = prepareModel(request, model);

		return new ModelAndView( getPages().getADMIN_NPC(),model );
	}



	@RequestMapping(value="/admin/npc/npc.json",method = RequestMethod.GET)
	public ModelAndView getJson(
			HttpServletRequest request, HttpServletResponse resp, ModelMap model,
			@RequestParam(value="id",required=true) int id,
			@RequestParam(value="f",required=false) Integer type
	)
	{
		if(id<0){
			ArrayList<Npc> list = null;
			if(type==0){
				list = getDaoManager().getNPCList();
				model.addAttribute("imgpath", getPages().getIMG_NPC_PATH());
				model.addAttribute("imgext", getPages().getIMG_NPC_EXT());
			}
			else{
				list = getDaoManager().getMonsterList();
				model.addAttribute("imgpath", getPages().getIMG_MONST_PATH());
				model.addAttribute("imgext", getPages().getIMG_MONST_EXT());
			}
			model.addAttribute("npcs", list);

			model.addAttribute("grid", true);
			model.addAttribute("pages", getPages());
		}
		else{
			Npc n = getDaoManager().getNpcById(id);
			model.addAttribute("n",n);
			model.addAttribute("grid", false);
		}

		return new ModelAndView( getPages().getADMIN_NPC_JSON(),model );
	}



	@RequestMapping(value="/admin/npc/npc.html",method = RequestMethod.POST)
	public ModelAndView saveItem(HttpServletRequest request, HttpServletResponse resp, ModelMap model,
			@RequestParam(value="act",required=true) int act,
			@RequestParam(value="data",required=true) String data)
	{

		String msg = "";
		try{
			JSONParser parser=new JSONParser();

			JSONObject obj =(JSONObject)parser.parse(data);

			int id = GenericUtil.toInt( (String) obj.get("n_id"), -1);
			Npc npc;
			switch (act) {
			case 0: //save
				npc= new Npc();
				npc = (Npc) ControllerUtils.populateObject(npc,obj,"n_");
				getDaoManager().create(npc);
				msg = "New Npc ["+npc.getName()+"] Created";
				break;
			case 1:	//edit					
				npc = getDaoManager().getNpcById(id);
				npc = (Npc) ControllerUtils.populateObject(npc,obj,"n_");
				getDaoManager().update(npc);
				msg = "Npc ["+npc.getName()+"] Updated";
				break;				
			case 2:	//delete
				npc = getDaoManager().getNpcById(id);
				getDaoManager().delete( npc );
				msg = "Npc Deleted";
				break;

			default:
				break;
			}


		} catch (Exception e) 
		{
			model.addAttribute(getPages().getCONTEXT_ERROR(),e.getMessage());
		}

		model.addAttribute(getPages().getCONTEXT_ERROR(),msg);

		model = prepareModel(request, model);

		return new ModelAndView( getPages().getADMIN_NPC(),model );
	}



	@RequestMapping(value="/admin/npc/npc.json",method = RequestMethod.POST)
	public ModelAndView uploadImage(HttpServletRequest request, HttpServletResponse resp, ModelMap model,
			@RequestParam(value="m",required=true) int mode)
	{
		try{
			switch (mode) {
			case 0: //upload NPC image
				ControllerUtils.doubleUploadAndResizeImage(request,
						getPages().getAbsoluteIMG_NPC_PATH_BIG(),getPages().getAbsoluteIMG_NPC_PATH(),
						null,
						getPages().getIMG_NPC_EXT().substring(1),
						400,-1,
						100,100);
				break;
			case 1: //upload Monster image
				ControllerUtils.doubleUploadAndResizeImage(request,
						getPages().getAbsoluteIMG_MONST_PATH_BIG(),getPages().getAbsoluteIMG_MONST_PATH(),
						null,
						getPages().getIMG_MONST_EXT().substring(1),
						400,-1,
						100,-1);
				break;

			default:
				break;
			}

		}
		catch (Exception e) {
			return new ModelAndView( getPages().getRedirect(request,getPages().getADMIN_NPC(),e.getMessage()) );
		}

		return new ModelAndView( getPages().getRedirect(request,getPages().getADMIN_NPC(),"File succesfully uploaded!") );
	}



	private ModelMap prepareModel(HttpServletRequest request, ModelMap model) 
	{

		ArrayList<String> l = ControllerUtils.getFileList(getPages().getAbsoluteIMG_NPC_PATH());
		model.addAttribute("images_npc", l);

		l = ControllerUtils.getFileList(getPages().getAbsoluteIMG_MONST_PATH());
		model.addAttribute("images_monst", l);

		l = ControllerUtils.getFileList(getPages().getDATA_NPC_PATH());
		model.addAttribute("dialogs_npc", l);

		l = ControllerUtils.getFileList(getPages().getDATA_MONST_PATH());
		model.addAttribute("dialogs_monst", l);

		ArrayList<Npc> nlist = getDaoManager().getNPCList();
		model.addAttribute("npcs", nlist);

		model.addAttribute(getPages().getCONTEXT_PAGES(), getPages());
		model.addAttribute("base", request.getContextPath());

		return model;
	}


	@RequestMapping(value="/admin/npc/npcCROP.json",method = RequestMethod.POST)
	public ModelAndView cropImage(HttpServletRequest request, HttpServletResponse resp, ModelMap model
			,@RequestParam(value="crop_name",required=true) String name
			,@RequestParam(value="crop_type",required=true) String type
			,@RequestParam(value="crop_x1",required=true) int x1
			,@RequestParam(value="crop_y1",required=true) int y1
			,@RequestParam(value="crop_x2",required=true) int x2
			,@RequestParam(value="crop_y2",required=true) int y2)
	{

		String pathIn = "";
		String pathOut = "";
		String format = "";
		if(type.equalsIgnoreCase("true")){
			pathIn 	= getPages().getAbsoluteIMG_MONST_PATH_BIG()+ name + getPages().getIMG_MONST_EXT();
			pathOut = getPages().getAbsoluteIMG_MONST_PATH() 	+ name + getPages().getIMG_MONST_EXT();
			format = getPages().getIMG_MONST_EXT().substring(1);

		}
		else{
			pathIn 	= getPages().getAbsoluteIMG_NPC_PATH_BIG()  + name + getPages().getIMG_NPC_EXT();
			pathOut = getPages().getAbsoluteIMG_NPC_PATH() 		+ name + getPages().getIMG_NPC_EXT();
			format = getPages().getIMG_NPC_EXT().substring(1);
		}

		try {
			BufferedInputStream bis = new BufferedInputStream( new FileInputStream(pathIn) );

			BufferedImage img =  ImageUtil.getImagefromStream(bis);
			img = ImageUtil.cropImage(img, x1, y1, Math.abs(x2-x1), Math.abs(y2-y1));
			img = ImageUtil.scaleImage(img, 100, 100);

			ControllerUtils.saveImageToFile(img, pathOut, format);

		} catch (Exception e) {
			return new ModelAndView( getPages().getRedirect(request,getPages().getADMIN_NPC(),e.getMessage()) );
		}

		model = prepareModel(request, model);

		return new ModelAndView( getPages().getRedirect(request,getPages().getADMIN_NPC(),"New Image ["+name+"] Saved.") );
	}


}
