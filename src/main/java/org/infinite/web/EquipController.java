package org.infinite.web;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.dao.DaoManager;
import org.infinite.db.dto.Item;
import org.infinite.db.dto.PlayerOwnItem;
import org.infinite.engines.items.ItemsEngine;
import org.infinite.objects.Character;
import org.infinite.util.InfiniteCst;
import org.infinite.web.utils.PagesCst;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping({"/player/equip.html"})
public class EquipController {

	@Autowired
	private DaoManager daoManager;

	@Autowired
	private	PagesCst pages;
	
	@Autowired
	private	ItemsEngine itemsEngine;
	
	public void setItemsEngine(ItemsEngine engine) {this.itemsEngine = engine;}
	public ItemsEngine getItemsEngine() {return itemsEngine;}
	
	public void setPages(PagesCst pages) {this.pages = pages;}
	public PagesCst getPages() {return pages;}
	
	public void setDaoManager(DaoManager dao) {this.daoManager = dao;}
	public DaoManager getDaoManager() { return daoManager; }
	
	
	
	
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView initEquip(HttpServletRequest req, HttpServletResponse response,  ModelMap model){
		
		model.addAttribute(getPages().getCONTEXT_PAGES(), getPages());
		Character c = (Character) req.getSession().getAttribute(getPages().getCONTEXT_CHARACTER());
		
		if(c==null){
			model.addAttribute(getPages().getCONTEXT_ERROR(), "Character not found! Please re-login.");
			return new ModelAndView( getPages().getRedirect(req,getPages().getPAGE_ROOT()),model );
		}
		
		Item left = c.getHandLeft();
		Item right = c.getHandRight();
		Item body = c.getBody();
		ArrayList<PlayerOwnItem> pois = c.getInventory();
		
		if(left!=null){
			model.addAttribute("left", left);
		}
		
		if(right!=null){
			model.addAttribute("right", right);
		}
		
		if(body!=null){
			model.addAttribute("body", body);
		}
		
		model.addAttribute("pois", pois!=null?pois:(new ArrayList<PlayerOwnItem>()));
		model.addAttribute("equip", InfiniteCst.POI_EQUIP);
		model.addAttribute("unequip", InfiniteCst.POI_UNEQUIP);
		model.addAttribute("drop", InfiniteCst.POI_DROP);
		
		return new ModelAndView(getPages().getPAGE_EQUIP(),model);
	}

	
	
	
	@RequestMapping(method = RequestMethod.POST)
	protected ModelAndView doEquip(HttpServletRequest req, HttpServletResponse resp,  ModelMap model){
		
		String p_id = req.getParameter("itemid");
		String p_mode = req.getParameter("mode");
		
		model.addAttribute(getPages().getCONTEXT_PAGES(), getPages());
		Character c = (Character) req.getSession().getAttribute(getPages().getCONTEXT_CHARACTER());
		
		if(c==null){
			model.addAttribute(getPages().getCONTEXT_ERROR(), "Character not found! Please re-login.");
			return new ModelAndView( getPages().getRedirect(req,getPages().getPAGE_ROOT()),model );
		}
		
		
		if( p_id==null || p_mode == null){
			req.getSession().setAttribute(getPages().getCONTEXT_ERROR(), "Could not access this page directly, missing parameters!");
		}
		else{
			
			int poiId = Integer.parseInt(p_id);
			int mode = Integer.parseInt(p_mode);
			
			PlayerOwnItem poi = getDaoManager().getPlayerItem(poiId);
			
			if(poi==null)
				mode=-1;
			
			switch (mode) {
			case InfiniteCst.POI_EQUIP:				
				try {
						c.wearItem(poi,getItemsEngine());
					} catch (Exception e) {
						req.getSession().setAttribute(getPages().getCONTEXT_ERROR(), e.getMessage());
					}
				break;
			case InfiniteCst.POI_DROP:
				c.dropItem(poi,getItemsEngine());
				break;
			case InfiniteCst.POI_UNEQUIP:
				c.moveToInventory(poi,getItemsEngine());
				break;

			default:
				req.getSession().setAttribute(getPages().getCONTEXT_ERROR(), "Item ("+poiId+") not found");
				break;
			}
			
			
		}
		return new ModelAndView(getPages().getPAGE_EQUIP(),model);
		
	}
	
	
	
	
}
