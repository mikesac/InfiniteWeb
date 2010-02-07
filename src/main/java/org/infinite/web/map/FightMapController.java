package org.infinite.web.map;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.dao.DaoManager;
import org.infinite.db.dto.Npc;
import org.infinite.db.dto.Player;
import org.infinite.engines.AI.AiEngine;
import org.infinite.engines.fight.FightEngine;
import org.infinite.engines.fight.FightRound;
import org.infinite.engines.fight.PlayerInterface;
import org.infinite.engines.items.ItemsEngine;
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
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/player/mapfight.html")

public class FightMapController {

	@Autowired
	private DaoManager daoManager;

	@Autowired
	private	PagesCst pages;

	@Autowired
	private	FightEngine fightEngine;

	@Autowired
	private AiEngine aiEngine;

	@Autowired
	private MagicEngine magicEngine;

	@Autowired
	private ItemsEngine itemsEngine;

	public void setItemsEngine(ItemsEngine itemsEngine) {this.itemsEngine = itemsEngine;}
	public ItemsEngine getItemsEngine() {return itemsEngine;}

	public void setMagicEngine(MagicEngine magicEngine) {this.magicEngine = magicEngine;}
	public MagicEngine getMagicEngine() {return magicEngine;}

	public void setAiEngine(AiEngine aiEngine) {this.aiEngine = aiEngine;}
	public AiEngine getAiEngine() {	return aiEngine;}

	public void setFightEngine(FightEngine fightEngine) {this.fightEngine = fightEngine;}
	public FightEngine getFightEngine() {return fightEngine;}

	public void setPages(PagesCst pages) {this.pages = pages;}
	public PagesCst getPages() {return pages;}

	public void setDaoManager(DaoManager dao) {this.daoManager = dao;}
	public DaoManager getDaoManager() { return daoManager; }


	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView processFight(HttpServletRequest req, HttpServletResponse response,  ModelMap model){

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

			//Party one is player, party 2 depends on map area				
			ArrayList<PlayerInterface> side1  = new ArrayList<PlayerInterface>();
			ArrayList<PlayerInterface> side2  = new ArrayList<PlayerInterface>();

			if(c.getPointsLife()<=0){
				throw new Exception("Cannot enter fight, insufficent Life Points");
			}

			side1.add(c);

			//get monster based on areaItem level
			int level = c.getAreaItem().getLevel();
			level = getAiEngine().getMatchingLevel(level);
			
			if(level==0){
				throw new Exception("No monsters encounter this time!");
			}

			ArrayList<Npc> listNPC = getDaoManager().getMonsterList(level);
			ArrayList<Player> listPC = getDaoManager().getOtherPlayerInArea(c);

			if((listNPC.size()+listPC.size())==0){
				throw new Exception("No monsters matching your level ("+level+")");
			}

			int index = GenericUtil.getRandomNumber(0, listNPC.size() + listPC.size());

			try {

				if(index<listNPC.size()){
					side2.add( getAiEngine().spawn(listNPC.get(index).getName()) );
					//side2.add( newAIEngine.spawn("Black bear") );
				}
				else{
					Player p = listPC.get( index-listNPC.size() );
					side2.add(  new Character( p.getName(),p.getTomcatUsers().getUser(),getDaoManager(),getItemsEngine(),getMagicEngine()) );
				}


			} catch (Exception e1) {
				throw new Exception("Error Spawining Monster",e1); 
			}

			//sides must be saved first, after fight death pc are missing
			model.addAttribute(getPages().getCONTEXT_FIGHT_REPORT_S1(), side1.clone());
			model.addAttribute(getPages().getCONTEXT_FIGHT_REPORT_S2(), side2.clone());

			ArrayList<FightRound> report = getFightEngine().runFight(side1,side2);	
			model.addAttribute(getPages().getCONTEXT_FIGHT_REPORT(), report);

		}
		catch (Exception e) {
			return new ModelAndView( getPages().getRedirect(req,getPages().getPAGE_MAP(), e.getMessage()) );
		}	
		
		model.addAttribute("type_weapon", InfiniteCst.ATTACK_TYPE_WEAPON);
		model.addAttribute("type_magic", InfiniteCst.ATTACK_TYPE_MAGIC);
		model.addAttribute("type_idle", InfiniteCst.ATTACK_TYPE_IDLE);
		model.addAttribute("attack", InfiniteCst.MAGIC_ATTACK);
		model.addAttribute("heal", InfiniteCst.MAGIC_HEAL);
		model.addAttribute("defend", InfiniteCst.MAGIC_DEFEND);
		model.addAttribute("uncast", InfiniteCst.MAGIC_UNCAST);


		return new ModelAndView( getPages().getPAGE_MAPFIGHT(), model );
		
	}
}
