package org.infinite.web.account;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.infinite.db.dao.DaoManager;
import org.infinite.engines.fight.FightEngine;
import org.infinite.engines.items.ItemsEngine;
import org.infinite.engines.magic.MagicEngine;
import org.infinite.engines.map.MapEngine;
import org.infinite.objects.Character;
import org.infinite.objects.Map;
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
@RequestMapping("/player/start.html")
public class StartPlaying {

	@Autowired
	private DaoManager daoManager;

	@Autowired
	private ItemsEngine itemsEngine;

	@Autowired
	private MagicEngine magicEngine;

	@Autowired
	private MapEngine mapEngine;

	@Autowired
	private FightEngine fightEngine;
	
	@Autowired
	private	PagesCst pages;
	
	public void setPages(PagesCst pages) {this.pages = pages;}
	public PagesCst getPages() {return pages;}

	public void setFightEngine(FightEngine fightEngine) {this.fightEngine = fightEngine;}

	public FightEngine getFightEngine() {return fightEngine;}

	public void setMapEngine(MapEngine mapEngine) {this.mapEngine = mapEngine;}

	public MapEngine getMapEngine() {return mapEngine;}

	public void setDaoManager(DaoManager daoManager) {this.daoManager = daoManager;}

	public DaoManager getDaoManager() {	return daoManager;	}

	public void setItemsEngine(ItemsEngine itemsEngine) {this.itemsEngine = itemsEngine;}

	public ItemsEngine getItemsEngine() {return itemsEngine;}

	public void setMagicEngine(MagicEngine magicEngine) {this.magicEngine = magicEngine;}

	public MagicEngine getMagicEngine() {return magicEngine;}


	@RequestMapping(method = RequestMethod.POST)
	public  ModelAndView prepareToStart(
			@RequestParam(value="chname",required=true) String chName,
			HttpServletRequest req, HttpServletResponse response,  ModelMap model) {

		String acName = req.getRemoteUser();

		if(acName==null || chName==null || acName.length()==0 || chName.length()==0){
			model.addAttribute(getPages().getCONTEXT_ERROR(), "Wrong request parametes!");
			return new ModelAndView(new RedirectView( getPages().getPageUrl(req,getPages().getPAGE_ROOT()) )  );
		}

		Character c;
		try {
			c = new Character(chName,acName,getDaoManager(),getItemsEngine(),getMagicEngine());
		} 
		catch (Exception e) 
		{
			return new ModelAndView( getPages().getRedirect(req,getPages().getPAGE_CHARACTER(),"Error loading character:"+e.getMessage()));

		}		
		Map m = new Map( getMapEngine().getAreaFromAreaItem( c.getAreaItem() ),c, getMapEngine());

		//before saving into context check if some regeneration or effect occurred 
		c = Character.checkForRegeneration(c,getFightEngine() );

		req.getSession().setAttribute(getPages().getCONTEXT_CHARACTER(), c);
		req.getSession().setAttribute(getPages().getCONTEXT_MAP(), m);
		
		return new ModelAndView( getPages().getRedirect(req,getPages().getPAGE_MAP() ,null));

	}


	public boolean redirectToCharSelect(HttpSession s,HttpServletRequest request,HttpServletResponse response) throws IOException{

		if(s.getAttribute(getPages().getCONTEXT_CHARACTER())==null){
			response.sendRedirect(request.getContextPath()+getPages().getPAGE_CHARACTER()+getPages().getPAGE_EXT());
			return true;
		}
		return false;
	}
}
