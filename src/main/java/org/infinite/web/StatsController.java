package org.infinite.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.dao.DaoManager;
import org.infinite.engines.AI.AiEngine;
import org.infinite.objects.Character;
import org.infinite.util.GenericUtil;
import org.infinite.util.InfiniteCst;
import org.infinite.web.utils.PagesCst;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/player/status.html")
public class StatsController {

	@Autowired
	private DaoManager daoManager;

	@Autowired
	private	PagesCst pages;

	public void setPages(PagesCst pages) {this.pages = pages;}
	public PagesCst getPages() {return pages;}

	public void setDaoManager(DaoManager dao) {this.daoManager = dao;}
	public DaoManager getDaoManager() { return daoManager; }


	
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView initStatus(	HttpServletRequest req, HttpServletResponse resp, ModelMap model)
	{
		Character c = null;
		Object[] out = getPages().initController(c, model, req);
		if(out[0] instanceof Character){
			c = (Character) out[0];
			model = (ModelMap)out[1];
		}
		else{
			return (ModelAndView)out[0];
		}
		
		model.addAttribute("up", (c.getDao().getAssign()>0) );
			
		model.addAttribute("curr_xp", c.getExperience() ) ;
		model.addAttribute("next_xp", AiEngine.getLevelPx( c.getLevel()+1 ) );
		
		model.addAttribute("STR", InfiniteCst.STATUS_TYPE_STR );
		model.addAttribute("INT", InfiniteCst.STATUS_TYPE_INT );
		model.addAttribute("DEX", InfiniteCst.STATUS_TYPE_DEX );
		model.addAttribute("CHA", InfiniteCst.STATUS_TYPE_CHA );
		
		model.addAttribute("PL", InfiniteCst.STATUS_TYPE_PL );
		model.addAttribute("PM", InfiniteCst.STATUS_TYPE_PM );
		model.addAttribute("PA", InfiniteCst.STATUS_TYPE_PA );
		model.addAttribute("PC", InfiniteCst.STATUS_TYPE_PC );
		
		return new ModelAndView( getPages().getPAGE_STATUS() , model );
	}
	

	@RequestMapping(method = RequestMethod.POST)
	public ModelAndView upgradeStatus(
			@RequestParam(value="attType",required=false) String attType,
			HttpServletRequest req, HttpServletResponse resp, ModelMap model)
	{
		try{

			int type = GenericUtil.toInt( attType , -1);

			Character c = null;
			Object[] out = getPages().initController(c, model, req);
			if(out[0] instanceof Character){
				c = (Character) out[0];
				model = (ModelMap)out[1];
			}
			else{
				return (ModelAndView)out[0];
			}

			if( type == -1 ){
				throw new Exception("Could not access this page directly, missing parameters!");
			}

			if( c.getDao().getAssign() <= 0 ){
				throw new Exception("No points to assign!");
			}

			c.upgradeStatus(type);

		}
		catch (Exception e) {
			model.addAttribute(getPages().getCONTEXT_ERROR(), e.getMessage());
		}

		return new ModelAndView( getPages().getPAGE_STATUS() , model );
	}

}
