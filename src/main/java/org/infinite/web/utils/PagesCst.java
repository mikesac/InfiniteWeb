package org.infinite.web.utils;

import javax.servlet.http.HttpServletRequest;

import org.infinite.engines.AI.AiEngine;
import org.infinite.objects.Character;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;


public class PagesCst {
	
	//Game data - get from spring context to be externally configurable
	private String absoluteDataPath;
	private String relativeDataPath;	
	
	/*
	 * INTERNAL REFERENCES
	 * 
	 * All this refers to server web data for common application behavior and should be INSIDE webapp
	 */
	
	
	private final String STATIC_BASEPATH = "/Infinite";
	private final String PAGE_EXT = ".html";
	
	//PAGES - game section
	private final String PAGE_START = "/player/start";
	private final String PAGE_MAPFIGHT = "/player/mapFight";
	private final String PAGE_MAPFIGHTREPORT = "/player/mapFightReport";
	private final String PAGE_ROOT = "/index";
	private final String PAGE_CHARACTER = "/player/character";
	private final String PAGE_MAP = "/player/map";
	private final String PAGE_EQUIP = "/player/equip";
	private final String PAGE_SPELL = "/player/spell";
	private final String PAGE_SPELLBOOK = "/player/spellbook";
	private final String PAGE_STATUS = "/player/status";
	private final String PAGE_REGISTER = "/login/register";
	private final String PAGE_BATTLEPLAN= "/player/battleplan";
	private final String PAGE_NPCDIALOG= "/player/npcdialog";
	private final String PAGE_SHOP= "/player/shop";
	private final String PAGE_SHOP_JSON= "/player/shopJSON";
	private final String PAGE_SSHOP= "/player/sshop";
	
	private final String PAGE_QUEST_ACTION	= "/player/quest_act";
	private final String PAGE_QUEST_STATUS	= "/player/quest_stat";
	
	
	//PAGES - admin section
	private final String ADMIN_HOME 		= "/admin/home";
	private final String ADMIN_DIALOG 		= "/admin/dialog/dialog";
	private final String ADMIN_DIALOG_JSON 	= "/admin/dialog/dialogJSON";
	private final String ADMIN_MAP 			= "/admin/map/maps";
	private final String ADMIN_MAPPREVIEW 	= "/admin/map/mapPreview";
	private final String ADMIN_MAPLIST 		= "/admin/map/listArea";
	private final String ADMIN_AREAITEMS 	= "/admin/area/areaItem";
	private final String ADMIN_JSONAREAITEMS 	= "/admin/area/jsonAreaItem";
	private final String ADMIN_SPELL 			= "/admin/spell/spell";
	private final String ADMIN_SPELL_JSON 		= "/admin/spell/spellJSON";
	private final String ADMIN_ITEM 			= "/admin/item/item";
	private final String ADMIN_ITEM_JSON 		= "/admin/item/itemJSON";
	private final String ADMIN_NPC				= "/admin/npc/npc";
	private final String ADMIN_NPC_JSON 		= "/admin/npc/npcJSON";

	
	//REFERENCES
	private final String IMG_WEB_EXT= ".jpg";
	private final String IMG_WEB_PATH= "../imgs/web/";
	
	//CONTEXT - model variables
	private final String CONTEXT_PAGES = "pages";
	private final String CONTEXT_CHARACTER = "character";
	public  final static String CONTEXT_ERROR = "error";
	private final String CONTEXT_MAP = "map";
	private final String CONTEXT_MAPITEM = "map_item";
	private final String CONTEXT_SPELLTYPE = "spell_type";
	private final String CONTEXT_SPELLPAGE = "spell_page";
	private final String CONTEXT_FIGHT_REPORT = "fight_report";
	
	private final String CONTEXT_SPELLBOOK = "spell_book";
	
	private final String CONTEXT_FIGHT_REPORT_S1 = "fight_report_s1";
	private final String CONTEXT_FIGHT_REPORT_S2= "fight_report_s2";
	
	/*
	 * GAME REFERENCES
	 * 
	 * All this refers to a local installation of a game and should be OUTSIDE webapps
	 */
	
	
	//IMAGES
	private final String IMG_PC_EXT= ".jpg";
	private final String IMG_PC_PATH= "/imgs/player/";
	
	private final String IMG_ITEM_EXT= ".jpg";
	private final String IMG_ITEM_PATH= "/imgs/item/";
	
	private final String IMG_SPELL_EXT= ".jpg";
	private final String IMG_SPELL_PATH= "/imgs/spell/";
	
	private final String IMG_MONST_EXT= ".jpg";
	private final String IMG_MONST_PATH= "/imgs/monster/";
	private final String IMG_MONST_PATH_BIG= "/imgs/monster/big/";
	
	private final String IMG_NPC_EXT= ".jpg";
	private final String IMG_NPC_PATH= "/imgs/npc/";
	private final String IMG_NPC_PATH_BIG= "/imgs/npc/big/";
	
	private final String IMG_MAP_EXT= ".jpg";
	private final String IMG_MAP_PATH= "/imgs/maps/";
	private final String IMG_MAP_PATH_TMP= "/imgs/maps/tmp/";
	
	private final String DATA_NPC_EXT= ".json";
	private final String DATA_NPC_PATH= "/dialogs/npc/";
	
	private final String DATA_MONST_EXT= ".json";
	private final String DATA_MONST_PATH= "/dialogs/monst/";
	
	
	

	
	
	public String getADMIN_SPELL() {
		return ADMIN_SPELL;
	}
	public String getADMIN_DIALOG_JSON() {
		return ADMIN_DIALOG_JSON;
	}
	public void setRelativeDataPath(String relativeDataPath) {
		this.relativeDataPath = relativeDataPath;
	}
	public String getRelativeDataPath() {
		return relativeDataPath;
	}
	public void setAbsoluteDataPath(String absoluteDataPath) {
		this.absoluteDataPath = absoluteDataPath;
	}
	public String getAbsoluteDataPath() {
		return absoluteDataPath;
	}
	public String getPAGE_START() {
		return PAGE_START;
	}
	public String getPAGE_EXT() {
		return PAGE_EXT;
	}
	public String getSTATIC_BASEPATH() {
		return STATIC_BASEPATH;
	}
	public String getPAGE_MAPFIGHT() {
		return PAGE_MAPFIGHT;
	}
	public String getPAGE_MAPFIGHTREPORT() {
		return PAGE_MAPFIGHTREPORT;
	}
	public String getPAGE_ROOT() {
		return PAGE_ROOT;
	}
	public String getPAGE_CHARACTER() {
		return PAGE_CHARACTER;
	}
	public String getPAGE_MAP() {
		return PAGE_MAP;
	}
	public String getPAGE_EQUIP() {
		return PAGE_EQUIP;
	}
	public String getPAGE_SPELL() {
		return PAGE_SPELL;
	}
	public String getPAGE_SPELLBOOK() {
		return PAGE_SPELLBOOK;
	}
	public String getPAGE_STATUS() {
		return PAGE_STATUS;
	}
	public String getPAGE_REGISTER() {
		return PAGE_REGISTER;
	}
	public String getPAGE_BATTLEPLAN() {
		return PAGE_BATTLEPLAN;
	}
	public String getPAGE_NPCDIALOG() {
		return PAGE_NPCDIALOG;
	}
	public String getPAGE_SHOP() {
		return PAGE_SHOP;
	}
	public String getPAGE_SSHOP() {
		return PAGE_SSHOP;
	}
	public String getIMG_ITEM_EXT() {
		return IMG_ITEM_EXT;
	}
	public String getIMG_ITEM_PATH() {
		return getRelativeDataPath() + IMG_ITEM_PATH;
	}
	public String getAbsoluteIMG_ITEM_PATH() {
		return getAbsoluteDataPath() + IMG_ITEM_PATH;
	}
	public String getIMG_SPELL_EXT() {
		return IMG_SPELL_EXT;
	}
	public String getIMG_SPELL_PATH() {
		return getRelativeDataPath() + IMG_SPELL_PATH;
	}
	public String getAbsoluteIMG_SPELL_PATH() {
		return getAbsoluteDataPath() + IMG_SPELL_PATH;
	}
	public String getIMG_MONST_EXT() {
		return IMG_MONST_EXT;
	}
	public String getIMG_MONST_PATH() {
		return getRelativeDataPath() + IMG_MONST_PATH;
	}
	public String getAbsoluteIMG_MONST_PATH() {
		return getAbsoluteDataPath() + IMG_MONST_PATH;
	}
	public String getIMG_NPC_EXT() {
		return IMG_NPC_EXT;
	}
	public String getIMG_NPC_PATH() {
		return getRelativeDataPath() + IMG_NPC_PATH;
	}
	public String getAbsoluteIMG_NPC_PATH() {
		return getAbsoluteDataPath() + IMG_NPC_PATH;
	}
	public String getAbsoluteIMG_NPC_PATH_BIG() {
		return getAbsoluteDataPath() + IMG_NPC_PATH_BIG;
	}
	public String getAbsoluteIMG_MONST_PATH_BIG() {
		return getAbsoluteDataPath() + IMG_MONST_PATH_BIG;
	}
	public String getCONTEXT_CHARACTER() {
		return CONTEXT_CHARACTER;
	}
	public String getCONTEXT_ERROR() {
		return CONTEXT_ERROR;
	}
	public String getCONTEXT_MAP() {
		return CONTEXT_MAP;
	}
	public String getCONTEXT_MAPITEM() {
		return CONTEXT_MAPITEM;
	}
	public String getCONTEXT_SPELLTYPE() {
		return CONTEXT_SPELLTYPE;
	}
	public String getCONTEXT_SPELLPAGE() {
		return CONTEXT_SPELLPAGE;
	}
	public String getCONTEXT_FIGHT_REPORT() {
		return CONTEXT_FIGHT_REPORT;
	}
	public String getCONTEXT_SPELLBOOK() {
		return CONTEXT_SPELLBOOK;
	}
	public String getCONTEXT_FIGHT_REPORT_S1() {
		return CONTEXT_FIGHT_REPORT_S1;
	}
	public String getCONTEXT_FIGHT_REPORT_S2() {
		return CONTEXT_FIGHT_REPORT_S2;
	}
	public String getADMIN_HOME() {
		return ADMIN_HOME;
	}
	public String getADMIN_MAPPREVIEW() {
		return ADMIN_MAPPREVIEW;
	}
	
	public String getADMIN_MAPLIST() {
		return ADMIN_MAPLIST;
	}
	public String getADMIN_AREAITEMS() {
		return ADMIN_AREAITEMS;
	}
	public String getCONTEXT_PAGES() {
		return CONTEXT_PAGES;
	}
	
	
	public String getPageUrl(HttpServletRequest request, String page){
		return request.getContextPath() + page + (page.toLowerCase().indexOf(".html")!=-1?"":getPAGE_EXT() );
	}
	
	public View getRedirect(HttpServletRequest request, String page,String error){
		if(error!=null){
			request.getSession().setAttribute(getCONTEXT_ERROR(), error);
		}
			
		return new RedirectView( getPageUrl(request, page));
	}
	
public Object[] initController(Character c, ModelMap model, HttpServletRequest req){
		
		Object[] out = new Object[2];
		
		model = initController(model, req);
		
		c = (Character) req.getSession().getAttribute(getCONTEXT_CHARACTER());
		
		if(c==null){
			out[0]=new ModelAndView( getRedirect(req,getPAGE_ROOT(),"Character not found! Please re-login." ));
		}
		else{
//			model.addAttribute("curr_xp", c.getExperience() ) ;
//			model.addAttribute("next_xp", AiEngine.getLevelPx( c.getLevel()+1 ) );
			out[0] = c;
			out[1] = model;
		}		
		return out;
	}

public ModelMap initController(ModelMap model, HttpServletRequest req){
	
	String error = (String) req.getSession().getAttribute( getCONTEXT_ERROR() );
	
	if(error!=null){
		model.addAttribute(getCONTEXT_ERROR(), error);
		req.getSession().removeAttribute(getCONTEXT_ERROR());
		
	}
	model.addAttribute(getCONTEXT_PAGES(), this);
	
	return model;
}

	public String getIMG_MONST_PATH_BIG() {
		return getRelativeDataPath() + IMG_MONST_PATH_BIG;
	}
	public String getIMG_NPC_PATH_BIG() {
		return getRelativeDataPath() + IMG_NPC_PATH_BIG;
	}
	public String getADMIN_MAP() {
		return ADMIN_MAP;
	}
	public String getIMG_MAP_EXT() {
		return IMG_MAP_EXT;
	}
	public String getIMG_MAP_PATH() {
		return getRelativeDataPath() + IMG_MAP_PATH;
	}
	public String getAbsoluteIMG_MAP_PATH() {
		return getAbsoluteDataPath() + IMG_MAP_PATH;
	}
	public String getIMG_MAP_PATH_TMP() {
		return getRelativeDataPath() + IMG_MAP_PATH_TMP;
	}
	public String getAbsoluteIMG_MAP_PATH_TMP() {
		return getAbsoluteDataPath() + IMG_MAP_PATH_TMP;
	}
	public String getADMIN_DIALOG() {
		return ADMIN_DIALOG;
	}
	public String getADMIN_JSONAREAITEMS() {
		return ADMIN_JSONAREAITEMS;
	}
	public String getDATA_NPC_EXT() {
		return DATA_NPC_EXT;
	}
	public String getDATA_NPC_PATH() {
		return getAbsoluteDataPath() + DATA_NPC_PATH;
	}
	public String getDATA_MONST_EXT() {
		return DATA_MONST_EXT;
	}
	public String getDATA_MONST_PATH() {
		return getAbsoluteDataPath() + DATA_MONST_PATH;
	}
	public String getIMG_WEB_EXT() {
		return IMG_WEB_EXT;
	}
	public String getIMG_WEB_PATH() {
		return IMG_WEB_PATH;
	}
	public String getIMG_PC_EXT() {
		return IMG_PC_EXT;
	}
	public String getIMG_PC_PATH() {
		return getRelativeDataPath() + IMG_PC_PATH;
	}
	public String getAbsoluteIMG_PC_PATH() {
		return getAbsoluteDataPath() + IMG_PC_PATH;
	}
	public String getADMIN_SPELL_JSON() {
		return ADMIN_SPELL_JSON;
	}
	public String getADMIN_ITEM() {
		return ADMIN_ITEM;
	}
	public String getADMIN_ITEM_JSON() {
		return ADMIN_ITEM_JSON;
	}
	public String getADMIN_NPC() {
		return ADMIN_NPC;
	}
	public String getADMIN_NPC_JSON() {
		return ADMIN_NPC_JSON;
	}
	public String getPAGE_QUEST_ACTION() {
		return PAGE_QUEST_ACTION;
	}
	public String getPAGE_QUEST_STATUS() {
		return PAGE_QUEST_STATUS;
	}
	public String getPAGE_SHOP_JSON() {
		return PAGE_SHOP_JSON;
	}
	
	
	
	
}
