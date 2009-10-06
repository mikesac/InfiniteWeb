package org.infinite.web.utils;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.view.RedirectView;


public class PagesCst {
	
	private final String STATIC_BASEPATH = "/Infinite";
	private final String PAGE_EXT = ".html";
	
	//PAGES
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
	private final String PAGE_SSHOP= "/player/sshop";
	
	//IMAGES
	private final String IMG_ITEM_EXT= ".jpg";
	private final String IMG_ITEM_PATH= STATIC_BASEPATH  + "/imgs/item/";
	
	private final String IMG_SPELL_EXT= ".jpg";
	private final String IMG_SPELL_PATH= STATIC_BASEPATH  + "/imgs/spell/";
	
	private final String IMG_MONST_EXT= ".jpg";
	private final String IMG_MONST_PATH= STATIC_BASEPATH  + "/imgs/monster/";
	
	private final String IMG_NPC_EXT= ".jpg";
	private final String IMG_NPC_PATH= STATIC_BASEPATH  + "/imgs/npc/";
	
	//model variables
	private final String CONTEXT_PAGES = "pages";
	private final String CONTEXT_CHARACTER = "character";
	private final String CONTEXT_ERROR = "error";
	private final String CONTEXT_MAP = "map";
	private final String CONTEXT_MAPITEM = "map_item";
	private final String CONTEXT_SPELLTYPE = "spell_type";
	private final String CONTEXT_SPELLPAGE = "spell_page";
	private final String CONTEXT_FIGHT_REPORT = "fight_report";
	
	private final String CONTEXT_SPELLBOOK = "spell_book";
	
	private final String CONTEXT_FIGHT_REPORT_S1 = "fight_report_s1";
	private final String CONTEXT_FIGHT_REPORT_S2= "fight_report_s2";

	private final String ADMIN_HOME = "/admin/adminHome";
	private final String ADMIN_MAPPREVIEW = "/admin/map/mapUtilPreview";
	
	private final String ADMIN_MAPUTIL = 	"/admin/map/mapUtil";
	private final String ADMIN_MAPLIST = 	"/admin/map/listArea";
	private final String ADMIN_MAPITEMS = "/admin/map/mapItems";
	
	
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
		return IMG_ITEM_PATH;
	}
	public String getIMG_SPELL_EXT() {
		return IMG_SPELL_EXT;
	}
	public String getIMG_SPELL_PATH() {
		return IMG_SPELL_PATH;
	}
	public String getIMG_MONST_EXT() {
		return IMG_MONST_EXT;
	}
	public String getIMG_MONST_PATH() {
		return IMG_MONST_PATH;
	}
	public String getIMG_NPC_EXT() {
		return IMG_NPC_EXT;
	}
	public String getIMG_NPC_PATH() {
		return IMG_NPC_PATH;
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
	public String getADMIN_MAPUTIL() {
		return ADMIN_MAPUTIL;
	}
	public String getADMIN_MAPLIST() {
		return ADMIN_MAPLIST;
	}
	public String getADMIN_MAPITEMS() {
		return ADMIN_MAPITEMS;
	}
	public String getCONTEXT_PAGES() {
		return CONTEXT_PAGES;
	}
	
	
	public String getPageUrl(HttpServletRequest request, String page){
		return request.getContextPath() + page + getPAGE_EXT();
	}
	
	public RedirectView getRedirect(HttpServletRequest request, String page){
		return new RedirectView( getPageUrl(request, page) );
	}
	
	
	
	
}