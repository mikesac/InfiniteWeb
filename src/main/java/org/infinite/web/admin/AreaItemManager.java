package org.infinite.web.admin;


import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.dao.DaoManager;
import org.infinite.db.dto.Area;
import org.infinite.db.dto.AreaItem;
import org.infinite.db.dto.Player;
import org.infinite.db.dto.TomcatRoles;
import org.infinite.engines.map.MapEngine;
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

@Controller
public class AreaItemManager{

	@Autowired
	private	PagesCst pages;
	
	@Autowired
	private	MapEngine mapEngine;

	@Autowired
	private DaoManager daoManager;

	public void setMapEngine(MapEngine mapEngine) {this.mapEngine = mapEngine;}
	public MapEngine getMapEngine() {return mapEngine;}
	
	public void setPages(PagesCst pages) {this.pages = pages;}
	public PagesCst getPages() {return pages;}

	public void setDaoManager(DaoManager dao) {this.daoManager = dao;}
	public DaoManager getDaoManager() { return daoManager; }

	
	
	@RequestMapping(value="/admin/area/areaItem.html",method = RequestMethod.GET)
	public ModelAndView initArea(
			HttpServletRequest request, HttpServletResponse resp, ModelMap model,
			@RequestParam(value="areaid",required=true) int areaId
	){
		
		String userName = request.getUserPrincipal().getName();		
		TomcatRoles role = getDaoManager().getUserRole(userName);		
		if(role==null || !role.getRole().equalsIgnoreCase("manager")){
			return new ModelAndView( getPages().getRedirect(request,getPages().getPAGE_ROOT(),"You cannot access this area!") );
		}
		
		return new ModelAndView( getPages().getADMIN_AREAITEMS(),prepareModel(areaId,model) );
	}
	
	
	
	private ModelMap prepareModel(int areaId, ModelMap model) {
		
		Area a = getDaoManager().getArea(areaId);		
		Map m = new Map(a,null,getMapEngine());
		
		model.addAttribute("mapbackground", m.getMapBackground());
		model.addAttribute("icons",getDaoManager().getAreaItemsIcons());
		model.addAttribute("allareas",getDaoManager().listAllArea());
		model.addAttribute("adminmap",m);
			
		model.addAttribute(getPages().getCONTEXT_PAGES(), getPages());
		
		model.addAttribute("area", a);
		
		model.addAttribute("map_width", Map.MAP_WIDTH);
		model.addAttribute("map_height", Map.MAP_HEIGHT);
		
		return model;
	}
	

	@RequestMapping(value="/admin/area/areaItem.html",method = RequestMethod.POST)
	public ModelAndView saveArea(
			HttpServletRequest request, HttpServletResponse resp, ModelMap model,
			@RequestParam(value="act",required=true) int action,
			@RequestParam(value="areaid",required=true) int areaId,
			
			@RequestParam(value="id"	,required=false) int aiId,
			@RequestParam(value="name"	,required=false) 	String aiName,
			@RequestParam(value="icon"	,required=false) String aiIcon,
			@RequestParam(value="cost"	,required=false) int aiCost,
			@RequestParam(value="areax"	,required=false) int aiAreaX,
			@RequestParam(value="areay"	,required=false) int aiAreaY,
			@RequestParam(value="x"		,required=false) int aiX,
			@RequestParam(value="y"		,required=false) int aiY,
			@RequestParam(value="arealock"	,required=false) String aiLock,
			@RequestParam(value="questlock"	,required=false) String aiQLock,
			@RequestParam(value="act"		,required=false) String aiUrl,
			@RequestParam(value="url"		,required=false) String loop,
			@RequestParam(value="hide"		,required=false) String hide,
			@RequestParam(value="areaItemLevel",required=false) int aiLevel,
			@RequestParam(value="npcs"		,required=false) String aiNpcs
	){

		try {

			if(areaId==-1)
				throw new Exception("Invalid AREA ID");

			boolean aidoublestep = 	(hide!=null && (loop.equals("true") || loop.equals("on") ) ); 	 	
			boolean aiHide = 		(hide!=null && ( hide.equals("true") || hide.equals("on") )); 	 
			
			switch (action) {
			case 0:
				try{
					AreaItem ai = new AreaItem("NewAreaItem", "temp", 0, areaId,
							(short)0, (short)0, 0, 0, "",0,"", "",  
							false, false, 0, "");

					getDaoManager().create(ai);
					model.addAttribute(getPages().getCONTEXT_ERROR(),"New Area Item Created");
				}
				catch (Exception e) {
					throw new Exception("Could not save Area "+aiName + " please contact admin");
				}
			
				break;
			case 1:

				if(aiId==-1)
					throw new Exception("Invalid ID");
				if(aiName==null || aiName.length()==0)
					throw new Exception("Invalid NAME");
				if(aiIcon==null || aiIcon.length()==0)
					throw new Exception("Invalid ICON");
				if(aiCost==-1)
					throw new Exception("Invalid COST");
				if(aiAreaX==-1)
					throw new Exception("Invalid AreaX");
				if(aiAreaY==-1)
					throw new Exception("Invalid aiAreaY");
				if(aiX==-999)
					throw new Exception("Invalid X");
				if(aiY==-999)
					throw new Exception("Invalid Y");
				if(aiLock==null )
					throw new Exception("Invalid AREA LOCK");
				if(aiQLock==null )
					throw new Exception("Invalid QUEST LOCK");
				if(aiUrl==null || aiUrl.length()==0)
					throw new Exception("Invalid URL");
				if(aiLevel==-1)
					throw new Exception("Invalid LEVEL");
				if(aiNpcs==null )
					throw new Exception("Invalid NPCs");

				try{
					AreaItem ai = (AreaItem) getDaoManager().getAreaItem( aiId );
					ai.setName(aiName);
					ai.setIcon(aiIcon);
					ai.setCost(aiCost);
					ai.setAreax((short)aiAreaX);
					ai.setAreay((short)aiAreaY);
					ai.setX(aiX);
					ai.setY(aiY);
					ai.setArealock(aiLock);
					//TODO area type
					ai.setAreatype(0);
					ai.setQuestlock(aiQLock);
					ai.setUrl(aiUrl);
					ai.setDoublestep(aidoublestep);
					ai.setHidemode(aiHide);
					ai.setLevel(aiLevel);
					ai.setNpcs(aiNpcs);

					getDaoManager().update(ai);
					model.addAttribute(getPages().getCONTEXT_ERROR(),"Area Item Saved");
				}
				catch (Throwable e) {
					throw new Exception("Could not update Area "+aiName + " please contact admin");
				}
				break;
			case 2:
				try{
				AreaItem ai = (AreaItem) getDaoManager().getAreaItem( aiId );	
				ArrayList<Player> list = getDaoManager().getAllPlayerInArea(aiId);
				
				if(list.size()==0){				
					getDaoManager().delete(ai);
					model.addAttribute(getPages().getCONTEXT_ERROR(),"Area Item Deleted");
				}
				else{
					StringBuffer sb = new StringBuffer("Player(s) ");
					for(Player p : list){
						sb.append("[").append(p.getName()).append("] ");
					}
					sb.append(" are in this area, please move them first.");
					throw new Exception(sb.toString());
				}
				
				}catch (Throwable e) {
					throw new Exception("Could not delete Area "+aiName + ":"+e.getMessage());
				}
				break;
			}
			
			


		} catch (Exception e) {
			model.addAttribute(getPages().getCONTEXT_ERROR(),e.getMessage());
			GenericUtil.err("AreaItemSave Exception", e);
		}

		model.addAttribute("areaid",areaId);
		model = prepareModel(areaId,model);
		return new ModelAndView(getPages().getADMIN_AREAITEMS(), model);

	}
	
	@RequestMapping(value="/admin/area/jsonAreaItem.html",method = RequestMethod.GET)
	public ModelAndView initJson(
			HttpServletRequest request, HttpServletResponse resp, ModelMap model,
			@RequestParam(value="id",required=true) int id
	){
		AreaItem ai = (AreaItem) getDaoManager().getAreaItem(id);
		model.addAttribute("area",ai);
		return new ModelAndView(getPages().getADMIN_JSONAREAITEMS(), model);
	}

}
