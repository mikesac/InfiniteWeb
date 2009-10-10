package org.infinite.web;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.dao.DaoManager;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/player/equip.html")
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

		Character c = null;
		Object[] out = getPages().initController(c, model, req);
		if(out[0] instanceof Character){
			c = (Character) out[0];
			model = (ModelMap)out[1];
		}
		else{
			return (ModelAndView)out[0];
		}

		PlayerOwnItem left = c.getHandLeftPoi();
		PlayerOwnItem right = c.getHandRightPoi();
		PlayerOwnItem body = c.getBodyPoi();
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
	protected ModelAndView doEquip(
			@RequestParam(value="itemid",required=true) int poiId,
			@RequestParam(value="mode",required=true) int mode,
			HttpServletRequest req, HttpServletResponse resp,  ModelMap model){

		Character c = null;
		Object[] out = getPages().initController(c, model, req);
		if(out[0] instanceof Character){
			c = (Character) out[0];
			model = (ModelMap)out[1];
		}
		else{
			return (ModelAndView)out[0];
		}

		String error = null;
		PlayerOwnItem poi = getDaoManager().getPlayerItem(poiId);

		if(poi==null)
			mode=-1;

		switch (mode) {
		case InfiniteCst.POI_EQUIP:				
			try {
				c.wearItem(poi,getItemsEngine());
			} catch (Exception e) {
				error =  e.getMessage() ;
			}
			break;
		case InfiniteCst.POI_DROP:
			c.dropItem(poi,getItemsEngine());
			break;
		case InfiniteCst.POI_UNEQUIP:
			c.moveToInventory(poi,getItemsEngine());
			break;

		default:
			error =  "Item ("+poiId+") not found";
		break;
		}

		return new ModelAndView(getPages().getRedirect(req, getPages().getPAGE_EQUIP(),error) );

	}




}
