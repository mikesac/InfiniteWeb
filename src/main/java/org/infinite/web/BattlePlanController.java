package org.infinite.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.dao.DaoManager;
import org.infinite.objects.Character;
import org.infinite.web.utils.PagesCst;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/player/battleplan.html")
public class BattlePlanController {

	@Autowired
	private DaoManager daoManager;

	@Autowired
	private	PagesCst pages;
	
	public void setPages(PagesCst pages) {this.pages = pages;}
	public PagesCst getPages() {return pages;}
	
	public void setDaoManager(DaoManager dao) {this.daoManager = dao;}
	public DaoManager getDaoManager() { return daoManager; }
	

	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView initPlan(HttpServletRequest req, HttpServletResponse response,  ModelMap model){
		
		Character c = null;
		Object[] out = getPages().initController(c, model, req);
		if(out[0] instanceof Character){
			c = (Character) out[0];
			model = (ModelMap)out[1];
		}
		else{
			return (ModelAndView)out[0];
		}
		
		model.addAttribute("right", c.getHandRightPoi() );
					
		
		return new ModelAndView(getPages().getPAGE_BATTLEPLAN(), model);
	}
	
	
	@RequestMapping(method = RequestMethod.POST)
	public ModelAndView savePlan(
			@RequestParam(value="serialized",required=true) String serializedPlan,
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
		
		
		if( serializedPlan == null){
			return new ModelAndView( getPages().getRedirect(req,getPages().getPAGE_ROOT(),"Could not access this page directly, missing parameters!") );
		}
		else{

			try {
				c.setBattlePlan( c.deserializeBattlePlan(serializedPlan) );				
			} 
			catch (Exception e) {
				model.addAttribute(getPages().getCONTEXT_ERROR(), "Error saving Battle Plan");
			}
			
		}
		return new ModelAndView(getPages().getPAGE_BATTLEPLAN(), model);
		
	}
	
	
	
	
}
