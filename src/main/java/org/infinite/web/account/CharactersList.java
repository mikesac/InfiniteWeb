package org.infinite.web.account;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.infinite.db.dao.DaoManager;
import org.infinite.db.dto.AreaItem;
import org.infinite.db.dto.Player;
import org.infinite.db.dto.TomcatUsers;
import org.infinite.util.ImageUtil;
import org.infinite.web.utils.PagesCst;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/player/character.html")
public class CharactersList {

	@Autowired
	private DaoManager daoManager;

	@Autowired
	private	PagesCst pages;
	
	public void setPages(PagesCst pages) {this.pages = pages;}
	public PagesCst getPages() {return pages;}
	
	public void setDaoManager(DaoManager dao) {this.daoManager = dao;}
	public DaoManager getDaoManager() { return daoManager; }


	@RequestMapping(method = RequestMethod.GET)
	public  String getList(HttpServletRequest request, HttpServletResponse response,  ModelMap model) 
	{
		List<Player> l = getDaoManager().getCharacterListing( request.getUserPrincipal().getName() );
		request.getSession().setAttribute("user", request.getUserPrincipal().getName() );
		model.addAttribute("characterList",l);
		model.addAttribute(getPages().getCONTEXT_PAGES(), getPages());
		
		return getPages().getPAGE_CHARACTER();
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public  String createNewChar(HttpServletRequest request, HttpServletResponse response,  ModelMap model) 
	{
		String err= "New character created";

		// Create a new file upload handler
		ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());

		// Parse the request
		try {
			List<?> items = upload.parseRequest(request);

			String charName = "";
			String charPic = "pg_void.png";
			InputStream is = null;
			String szFileName = "";
			String szUser = request.getRemoteUser();

			Iterator<?> iter = items.iterator();			
			while (iter.hasNext()) {
				FileItem item = (FileItem) iter.next();

				if (item.isFormField()) {
					charName = item.getString().trim();
				} else {
					is = item.getInputStream();
					szFileName = item.getName();
				}
			}
			
			//TODO validate username
			if(charName==null || charName.length()==0){
				throw new Exception("Please insert a valid name for your character!");
			}
			
			
			if(is!=null && is.available()>0){
				charPic = charName+"_"+szUser;
			
				String szPath = getPages().getAbsoluteIMG_PC_PATH();
				szFileName = szFileName.substring( szFileName.lastIndexOf(".") );
				charPic += szFileName;
				szFileName = szPath +"/"+ charPic;

				BufferedImage img = ImageUtil.getImagefromStream(is);
				img = ImageUtil.scaleImage(img, 100, 100);
				ByteArrayOutputStream baos = ImageUtil.setImageToStream(img, "jpg");
				
				
				File f = new File(szFileName);
				f.createNewFile();
				FileOutputStream fos = new FileOutputStream(f);
				baos.writeTo(fos);
				
				fos.flush();
				baos.flush();
				fos.close();
				baos.close();
				is.close();
			}

			TomcatUsers tu = getDaoManager().getTomcatUsers(szUser);
			AreaItem ai = getDaoManager().getStartingAreaItem();

			charName = charName.replaceAll(" ", "");			
			Player p = new Player(
					tu,  //user
					ai,  //Area
					charName,
					charPic,
					5,5,5,5, //str,int,dex,cha
					20,5,10,5, //base
					20,5,10,5, //curr
					(long)0, //stats mod
					1,1,(short)0, //level, px, assign
					0,//status
					0.0f, //gold
					1,"Fists,1d1","" //nattack, attack,battle
					);
			getDaoManager().create(p);

			

		} catch (FileUploadException e) {
			err = e.getMessage();
			e.printStackTrace();
		}
		catch (Exception e) {
			err = e.getMessage();
			e.printStackTrace();
		}
		

		model.addAttribute(getPages().getCONTEXT_ERROR(), err);
		
		return getPages().getPAGE_CHARACTER();
	}


}