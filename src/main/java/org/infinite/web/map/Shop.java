package org.infinite.web.map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.dao.DaoManager;
import org.infinite.db.dto.Item;
import org.infinite.db.dto.Npc;
import org.infinite.db.dto.PlayerOwnItem;
import org.infinite.db.dto.Spell;
import org.infinite.engines.items.ItemsEngine;
import org.infinite.engines.magic.MagicEngine;
import org.infinite.objects.Character;
import org.infinite.util.GenericUtil;
import org.infinite.util.InfiniteCst;
import org.infinite.web.utils.PagesCst;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public class Shop {

	@Autowired
	private DaoManager daoManager;

	@Autowired
	private	PagesCst pages;

	@Autowired
	private	ItemsEngine itemsEngine;
	
	@Autowired
	private	MagicEngine magicEngine;

	public void setMagicEngine(MagicEngine magicEngine) {this.magicEngine = magicEngine;}
	public MagicEngine getMagicEngine() {return magicEngine;}
	
	public void setItemsEngine(ItemsEngine itemsEngine) {this.itemsEngine = itemsEngine;}
	public ItemsEngine getItemsEngine() {return itemsEngine;}

	public void setPages(PagesCst pages) {this.pages = pages;}
	public PagesCst getPages() {return pages;}

	public void setDaoManager(DaoManager daoManager) {this.daoManager = daoManager;	}
	public DaoManager getDaoManager() {	return daoManager;}

	
	
	@RequestMapping(method = RequestMethod.POST)
	public ModelAndView goShopping(
			HttpServletRequest req, HttpServletResponse response,  ModelMap model,
			@RequestParam(value="it",required=true) int itemId,
			@RequestParam(value="act",required=true) int action
	){
	
		try{
			
			Character c = null;
			Object[] out = getPages().initController(c, model, req);
			if(out[0] instanceof Character){
				c = (Character) out[0];
				model = (ModelMap)out[1];
			}
			else{
				return (ModelAndView)out[0];
			}
			 			
			if(itemId==-1)
				throw new Exception("Invalid item id:"+itemId);
			
			if(action==-1 || action >2)
				throw new Exception("Invalid action id:"+action);
			
			
			
			int NpcId = GenericUtil.toInt( c.getAreaItem().getNpcs(),-1);

			if(NpcId==-1){
				throw new Exception("Cannot find NPC id:"+c.getAreaItem().getNpcs() );
			}
			Npc npc = getDaoManager().getNpcById(NpcId);
			
			
			float priceAdj = 1.0f;
			
			switch (action) {
			case InfiniteCst.SHOP_BUY:
				priceAdj = (1.0f * npc.getBaseCha())/c.getDao().getBaseCha();
				Item item = getDaoManager().getItemById(itemId);				
				getItemsEngine().buyItem(c,item,priceAdj);
				model.addAttribute(getPages().getCONTEXT_ERROR(), item.getName()+" bought!");
				break;
			case InfiniteCst.SHOP_SELL:
				priceAdj = (1.0f * c.getCharisma())/npc.getBaseCha();
				PlayerOwnItem poi = getDaoManager().getPlayerItem(itemId);
				getItemsEngine().sellItem(c, poi, priceAdj);
				model.addAttribute(getPages().getCONTEXT_ERROR(), poi.getItem().getName()+" sold!");
				break;
			case InfiniteCst.SHOP_LEARN:
				priceAdj = (1.0f * npc.getBaseCha())/c.getDao().getBaseCha();
				Spell spell = getDaoManager().getSpellById(itemId);				
				getMagicEngine().buySpell(c,spell,priceAdj);
				model.addAttribute(getPages().getCONTEXT_ERROR(), spell.getName()+" bought!");
				break;
			default:
				throw new Exception("Invalid action id:"+action);
			}
			
			
		}catch (Exception e) {
			req.getSession().setAttribute(getPages().getCONTEXT_ERROR(), e.getMessage());
			GenericUtil.err("Shop", e);
		}
		
		ModelAndView out = null;
		if(action==InfiniteCst.SHOP_LEARN)
			out = new ModelAndView(getPages().getPAGE_SSHOP(),model );
		else
			out = new ModelAndView( getPages().getPAGE_SHOP(),model );
		
		return out;

	}

}
