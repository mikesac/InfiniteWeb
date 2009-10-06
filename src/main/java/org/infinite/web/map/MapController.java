package org.infinite.web.map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.dao.DaoManager;
import org.infinite.db.dto.Area;
import org.infinite.db.dto.AreaItem;
import org.infinite.engines.fight.FightEngine;
import org.infinite.engines.map.InaccessibleAreaException;
import org.infinite.engines.map.MapEngine;
import org.infinite.objects.Character;
import org.infinite.objects.Map;
import org.infinite.util.GenericUtil;
import org.infinite.web.utils.PagesCst;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@RequestMapping("/player/map.html")
public class MapController {

	@Autowired
	private FightEngine fightEngine;
	
	@Autowired
	private DaoManager daoManager;
	
	@Autowired
	private MapEngine mapEngine;
	
	@Autowired
	private	PagesCst pages;
	
	public void setPages(PagesCst pages) {this.pages = pages;}
	public PagesCst getPages() {return pages;}
	
	public void setMapEngine(MapEngine mapEngine) {this.mapEngine = mapEngine;}

	public MapEngine getMapEngine() {return mapEngine;}

	public void setDaoManager(DaoManager daoManager) {this.daoManager = daoManager;}

	public DaoManager getDaoManager() {	return daoManager;}

	public void setFightEngine(FightEngine fightEngine) {this.fightEngine = fightEngine;}

	public FightEngine getFightEngine() {return fightEngine;}
	
	private final String FORWARD = "ff";
	
	

	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView prepareMap(
			@RequestParam(value="m",required=false) String next,
			HttpServletRequest req, HttpServletResponse resp,ModelMap model){

		model.addAttribute(getPages().getCONTEXT_PAGES(), getPages());
		Character c = (Character) req.getSession().getAttribute(getPages().getCONTEXT_CHARACTER());
		
		if(c==null){
			model.addAttribute(getPages().getCONTEXT_ERROR(), "Character not found! Please re-login.");
			return new ModelAndView( getPages().getRedirect(req,getPages().getPAGE_ROOT()),model );
		}
		
		model.addAttribute("map_width", Map.MAP_WIDTH);
		model.addAttribute("map_height", Map.MAP_HEIGHT);
		
		//check for regeneration for AP
		Character.checkForRegeneration(c,getFightEngine());

		String ff = (String)req.getSession().getAttribute(FORWARD);
		req.getSession().removeAttribute(FORWARD);
		boolean moved = false;
		AreaItem nextArea = null;
		
		Area a = getMapEngine().getAreaFromAreaItem( c.getAreaItem() );;
		if(next==null){
			next = ""+ c.getAreaItem().getId();
			//model.addAttribute(getPages().getCONTEXT_ERROR(), "Could not access this page directly, missing parameters!");
//			return new ModelAndView(new RedirectView( req.getContextPath() + getPages().getPAGE_ROOT()+getPages().getPAGE_EXT() ));
		}
		else{

			nextArea = getDaoManager().getAreaItem( GenericUtil.toInt(next, -1) );

			if(c.getPointsAction() < nextArea.getCost()){
				model.addAttribute(getPages().getCONTEXT_ERROR(), "You do not have enough Action Point to move to that Area!");
			}
			else{
				
				
				try {
					a = c.moveToAreaItem(nextArea,getMapEngine());
					moved = true;
				} catch (InaccessibleAreaException e) {
					
					
					int status = GenericUtil.toInt(e.getMessage(), -1);
					String msg = "unknown error";
					switch (status) {
					case MapEngine.AREA_STATUS_BANNED:
						msg = "your level is too low";
						break;
					case MapEngine.AREA_STATUS_FAR:
						msg = "this area is too far, move nearer";
						break;
					case MapEngine.AREA_STATUS_LOCKED:
						msg = "you do not have proper key";
						break;
					case MapEngine.AREA_STATUS_HIDDEN:
						msg = "hidden area";
						break;
					}
					
					model.addAttribute(getPages().getCONTEXT_ERROR(),"Failed to move to choosen area:"+msg);
				}
				
			}
		}
			
		Map m = new Map(a,c,getMapEngine());
		model.addAttribute("mapbackground", m.getMapBackground());
		req.getSession().setAttribute(getPages().getCONTEXT_MAP(), m);
		req.getSession().setAttribute(getPages().getCONTEXT_CHARACTER(), c);
		
		
		if(moved && nextArea.getUrl().length()!=0 & ff==null){
			if(nextArea.isDoublestep()){
				req.getSession().setAttribute(FORWARD, "1");
			}
			return new ModelAndView( new RedirectView( req.getContextPath() + nextArea.getUrl() ));
		}
		else
			return new ModelAndView(getPages().getPAGE_MAP(),model );


	}

}
