package org.infinite.web.admin;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.dao.DaoManager;
import org.infinite.db.dto.TomcatRoles;
import org.infinite.web.utils.PagesCst;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DialogManager {

	@Autowired
	private	PagesCst pages;

	@Autowired
	private DaoManager daoManager;

	public void setPages(PagesCst pages) {this.pages = pages;}
	public PagesCst getPages() {return pages;}

	public void setDaoManager(DaoManager dao) {this.daoManager = dao;}
	public DaoManager getDaoManager() { return daoManager; }

	@RequestMapping(value="/admin/dialog/dialog.html",method = RequestMethod.GET)
	public ModelAndView initDIalog(HttpServletRequest request, HttpServletResponse resp, ModelMap model)
	{
		String userName = request.getUserPrincipal().getName();		
		TomcatRoles role = getDaoManager().getUserRole(userName);		
		if(role==null || !role.getRole().equalsIgnoreCase("manager")){
			return new ModelAndView( getPages().getRedirect(request,getPages().getPAGE_ROOT(),"You cannot access this area!") );
		}

		model = getPages().initController(model, request);
		
		File dialogFolder = new File( getPages().getDATA_NPC_PATH());

		if(dialogFolder.exists() && dialogFolder.isDirectory()){
			ArrayList<String> dialogs = new ArrayList<String>();
			String[] list = dialogFolder.list();
			for (int i = 0; i < list.length; i++) {
				if(list[i].endsWith(getPages().getDATA_NPC_EXT())){
					dialogs.add(list[i]);
				}
			}

			model.addAttribute("dialogs", dialogs);
		}


		model.addAttribute(getPages().getCONTEXT_PAGES(), getPages());
		model.addAttribute("base", request.getContextPath());

		return new ModelAndView( getPages().getADMIN_DIALOG(),model );
	}



	@RequestMapping(value="/admin/dialog/dialog.json",method = RequestMethod.GET)
	public ModelAndView getJsonDialog(
			HttpServletRequest request, HttpServletResponse resp, ModelMap model,
			@RequestParam(value="name",required=true) String filename
	)
	{
		try {
			File f = new File(getPages().getDATA_NPC_PATH() + filename);

			if(f.exists() && f.isFile())
			{
				BufferedInputStream bis = new BufferedInputStream(new FileInputStream(f));
				byte[] b = new byte[bis.available()];
				bis.read(b);
				model.addAttribute("response",new String(b) );
			}
			else{
				throw new Exception("Error accessing file ["+filename+"]!");
			}
		}
		catch (Exception e) {
			return new ModelAndView( getPages().getRedirect(request,getPages().getADMIN_DIALOG(),e.getMessage()) );
		}
		return new ModelAndView( getPages().getADMIN_DIALOG_JSON(),model );
	}



	@RequestMapping(value="/admin/dialog/dialog.json",method = RequestMethod.POST)
	public ModelAndView saveJsonDialog(
			HttpServletRequest request, HttpServletResponse resp, ModelMap model,
			@RequestParam(value="filename",required=true) String filename,
			@RequestParam(value="data",required=true) String data
	)
	{
		try {

			if(! filename.toLowerCase().endsWith(getPages().getDATA_NPC_EXT())){
				filename = filename.replaceAll(".", "_") + getPages().getDATA_NPC_EXT();
			}

			File f = new File(getPages().getDATA_NPC_PATH() + filename);
			BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(f));
			bos.write( data.getBytes() );
			bos.flush();
			bos.close();
			model.addAttribute("response","ok" );

		}
		catch (Exception e) {
			return new ModelAndView( getPages().getRedirect(request,getPages().getADMIN_DIALOG(),e.getMessage()) );
		}
		return new ModelAndView( getPages().getADMIN_DIALOG_JSON(),model );
	}

}
