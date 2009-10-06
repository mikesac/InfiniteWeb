package org.infinite.web;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.dao.DaoManager;
import org.infinite.db.dto.PlayerKnowSpell;
import org.infinite.db.dto.Spell;
import org.infinite.engines.magic.MagicEngine;
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

public class SpellController {

	@Autowired
	private DaoManager daoManager;

	@Autowired
	private	PagesCst pages;
	
	@Autowired
	private	MagicEngine magicEngine;
	
	public void setMagicEngine(MagicEngine magicEngine) {this.magicEngine = magicEngine;}
	public MagicEngine getMagicEngine() {return magicEngine;}
	
	public void setPages(PagesCst pages) {this.pages = pages;}
	public PagesCst getPages() {return pages;}
	
	public void setDaoManager(DaoManager dao) {this.daoManager = dao;}
	public DaoManager getDaoManager() { return daoManager; }
	
	
	@RequestMapping(value="/player/spell.html", method = RequestMethod.GET)
	public ModelAndView initSpell(
			@RequestParam(value="spell_type",required=false) String type,
			HttpServletRequest req, HttpServletResponse response,  ModelMap model){
		
		model.addAttribute(getPages().getCONTEXT_PAGES(), getPages());
		Character c = (Character) req.getSession().getAttribute(getPages().getCONTEXT_CHARACTER());
		
		if(c==null){
			model.addAttribute(getPages().getCONTEXT_ERROR(), "Character not found! Please re-login.");
			return new ModelAndView( getPages().getRedirect(req,getPages().getPAGE_ROOT()),model );
		}
		
		
		ArrayList<PlayerKnowSpell> pks = null;
		int iType = GenericUtil.toInt(type,InfiniteCst.MAGIC_ATTACK);
		switch( iType){
		case InfiniteCst.MAGIC_ATTACK:
			pks = c.getSpellBookFight();
			break;
		case InfiniteCst.MAGIC_HEAL:
			pks = c.getSpellBookHeal();
			break;
		case InfiniteCst.MAGIC_DEFEND:
			pks = c.getSpellBookProtect();
			break;
		}
		
		
		model.addAttribute("pks", pks);
		model.addAttribute("typename", getPages().getCONTEXT_SPELLTYPE());
		model.addAttribute("type", iType);
		model.addAttribute("attack", InfiniteCst.MAGIC_ATTACK);
		model.addAttribute("heal", InfiniteCst.MAGIC_HEAL);
		model.addAttribute("defend", InfiniteCst.MAGIC_DEFEND);
		model.addAttribute("ready", InfiniteCst.SPELL_READY);
		model.addAttribute("drop", InfiniteCst.PKS_DROP);
		model.addAttribute("equip", InfiniteCst.PKS_EQUIP);
		
		
		
		return new ModelAndView(getPages().getPAGE_SPELL(),model );
	}
	
	
	
	
	@RequestMapping(value="/player/spellbook.json", method = RequestMethod.GET)
	public ModelAndView getSpellBook(
			@RequestParam(value="spellid",required=true) String p_id,
			HttpServletRequest req, HttpServletResponse response,  ModelMap model){

		try{
		
			model.addAttribute(getPages().getCONTEXT_PAGES(), getPages());
			Character c = (Character) req.getSession().getAttribute(getPages().getCONTEXT_CHARACTER());
			
			if(c==null){
				model.addAttribute(getPages().getCONTEXT_ERROR(), "Character not found! Please re-login.");
				return new ModelAndView( getPages().getRedirect(req,getPages().getPAGE_ROOT()),model );
			}
			
			if( p_id==null)
				throw new Exception("Could not access this page directly, missing parameters!");

			int pksId = Integer.parseInt(p_id);

			PlayerKnowSpell pks = getDaoManager().getPlayerSpell( pksId);

			if(pks==null)
				throw new Exception("You don't know this spell!");

			Spell s = pks.getSpell(); 			
			model.addAttribute("spell", s);
			model.addAttribute("heal",InfiniteCst.MAGIC_HEAL);
			
		}
		catch (Exception e) {
			model.addAttribute(getPages().getCONTEXT_ERROR(), e.getMessage() );
			return new ModelAndView( getPages().getRedirect(req, getPages().getPAGE_SPELL() ));
			
		}

		return new ModelAndView(getPages().getPAGE_SPELLBOOK(),model );

	}

	@RequestMapping(value="/player/spell.html", method = RequestMethod.POST)
	protected ModelAndView prepareSpell(HttpServletRequest req, HttpServletResponse response,  ModelMap model)	throws ServletException, IOException {

		try{
			
			model.addAttribute(getPages().getCONTEXT_PAGES(), getPages());
			Character c = (Character) req.getSession().getAttribute(getPages().getCONTEXT_CHARACTER());
			
			if(c==null){
				model.addAttribute(getPages().getCONTEXT_ERROR(), "Character not found! Please re-login.");
				return new ModelAndView( getPages().getRedirect(req,getPages().getPAGE_ROOT()),model );
			}
			
			String p_id = req.getParameter("spellid");
			String p_mode = req.getParameter("mode");


			if( p_id==null || p_mode == null){
				throw new Exception("Could not access this page directly, missing parameters!");
			}
			else{

				int pksId = Integer.parseInt(p_id);
				int mode = Integer.parseInt(p_mode);

				PlayerKnowSpell pks = getDaoManager().getPlayerSpell( pksId);

				if(pks==null)
					mode=-1;

				switch (mode) {
				case InfiniteCst.PKS_EQUIP:		
					if(c.getAvailableSpellSlot()==0)
						throw new Exception("No more slots available!");
					c.prepareSpell(pks,getMagicEngine());					
					break;
				case InfiniteCst.PKS_DROP:
					c.unprepareSpell(pksId,getMagicEngine());
					break;

				default:
					throw new Exception( "Spell ("+pksId+") not found") ;
				}

			}
			
		}
		catch (Exception e) {
			req.getSession().setAttribute(getPages().getCONTEXT_ERROR(), e.getMessage());
		}
		
		return new ModelAndView(getPages().getPAGE_SPELL(),model);
	}

	


}
