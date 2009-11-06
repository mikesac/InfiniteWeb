package org.infinite.web;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.dao.DaoManager;
import org.infinite.db.dto.AreaItem;
import org.infinite.db.dto.Npc;
import org.infinite.engines.dialog.DialogEngine;
import org.infinite.engines.dialog.dto.Dialog;
import org.infinite.objects.Character;
import org.infinite.util.GenericUtil;
import org.infinite.web.utils.PagesCst;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/player/npcdialog.html")
public class DialogController {

	@Autowired
	private DaoManager daoManager;

	@Autowired
	private	PagesCst pages;

	@Autowired
	private DialogEngine dialogEngine;

	public void setPages(PagesCst pages) {this.pages = pages;}
	public PagesCst getPages() {return pages;}

	public void setDaoManager(DaoManager dao) {this.daoManager = dao;}
	public DaoManager getDaoManager() { return daoManager; }


	public void setDialogEngine(DialogEngine dialogEngine) {this.dialogEngine = dialogEngine;}
	public DialogEngine getDialogEngine() {return dialogEngine;}

	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView initDialog(HttpServletRequest req, HttpServletResponse response,  ModelMap model){

		Character c = null;
		Object[] out = getPages().initController(c, model, req);
		if(out[0] instanceof Character){
			c = (Character) out[0];
			model = (ModelMap)out[1];
		}
		else{
			return (ModelAndView)out[0];
		}


		ArrayList<Dialog> dialogs;
		Npc npc = null;
		
		try {
			AreaItem a =  c.getAreaItem();

			int NpcId = GenericUtil.toInt( a.getNpcs(),-1);

			if(NpcId==-1){
				throw new Exception("Cannot find NPC id:"+a.getNpcs() );
			}

			npc = getDaoManager().getNpcById(NpcId);

			//TODO remove servlet context usage
			try {
				dialogs = getDialogEngine().getDialogData( req.getSession().getServletContext().getResourceAsStream("/data/npc/"+ npc.getDialog() + ".properties") );
			} catch (IOException e) {
				throw new Exception("No dialogs file found! "+e.getMessage() );
			} 
		} catch (Exception e) {
			return new ModelAndView( getPages().getRedirect(req,getPages().getPAGE_MAP(), e.getMessage()) );
		}

		model.addAttribute("dialog", getDialogEngine().selectDialog(0, dialogs) );
		model.addAttribute("npc",npc);

		return new ModelAndView(getPages().getPAGE_NPCDIALOG(), model);
	}







	@RequestMapping(method = RequestMethod.POST)
	public ModelAndView nextDialog(
			@RequestParam(value="id",required=true) long dialogId,
			HttpServletRequest req, HttpServletResponse response,  ModelMap model){


		Character c = null;
		Object[] out = getPages().initController(c, model, req);
		if(out[0] instanceof Character){
			c = (Character) out[0];
			model = (ModelMap)out[1];
		}
		else{
			return (ModelAndView)out[0];
		}


		ArrayList<Dialog> dialogs;
		Npc npc = null;
		
		try {
			AreaItem a =  c.getAreaItem();

			int NpcId = GenericUtil.toInt( a.getNpcs(),-1);

			if(NpcId==-1){
				throw new Exception("Cannot find NPC id:"+a.getNpcs() );
			}

			npc = getDaoManager().getNpcById(NpcId);

			//TODO remove servlet context usage
			try {
				dialogs = getDialogEngine().getDialogData( req.getSession().getServletContext().getResourceAsStream("/data/npc/"+ npc.getDialog() + ".properties") );
			} catch (IOException e) {
				throw new Exception("No dialogs file found! "+e.getMessage() );
			} 
		} catch (Exception e) {
			return new ModelAndView( getPages().getRedirect(req,getPages().getPAGE_MAP(), e.getMessage()) );
		}

		model.addAttribute("dialog", getDialogEngine().selectDialog(dialogId, dialogs) );
		model.addAttribute("npc",npc);

		return new ModelAndView(getPages().getPAGE_NPCDIALOG(), model);

	}


	

}
