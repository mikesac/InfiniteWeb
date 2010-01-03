package org.infinite.web.admin;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.dao.DaoManager;
import org.infinite.db.dto.Item;
import org.infinite.db.dto.Spell;
import org.infinite.db.dto.TomcatRoles;
import org.infinite.util.GenericUtil;
import org.infinite.web.utils.ControllerUtils;
import org.infinite.web.utils.PagesCst;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ItemManager {

	@Autowired
	private	PagesCst pages;

	@Autowired
	private DaoManager daoManager;

	public void setPages(PagesCst pages) {this.pages = pages;}
	public PagesCst getPages() {return pages;}

	public void setDaoManager(DaoManager dao) {this.daoManager = dao;}
	public DaoManager getDaoManager() { return daoManager; }

	@RequestMapping(value="/admin/item/item.html",method = RequestMethod.GET)
	public ModelAndView initItems(HttpServletRequest request, HttpServletResponse resp, ModelMap model)
	{
		String userName = request.getUserPrincipal().getName();		
		TomcatRoles role = getDaoManager().getUserRole(userName);		
		if(role==null || !role.getRole().equalsIgnoreCase("manager")){
			return new ModelAndView( getPages().getRedirect(request,getPages().getPAGE_ROOT(),"You cannot access this area!") );
		}
		
		model = getPages().initController(model, request);
		
		model = prepareModel(request, model);
		return new ModelAndView( getPages().getADMIN_ITEM(),model );
	}



	@RequestMapping(value="/admin/item/item.json",method = RequestMethod.GET)
	public ModelAndView getJson(
			HttpServletRequest request, HttpServletResponse resp, ModelMap model,
			@RequestParam(value="id",required=true) int id,
			@RequestParam(value="f",required=false) Integer itemType
	)
	{
		if(id<0){
			ArrayList<Item> list = getDaoManager().getItemListByType(itemType);
			model.addAttribute("items", list);
			model.addAttribute("grid", true);
			model.addAttribute("pages", getPages());
		}
		else{
			Item it = getDaoManager().getItemById(id);
			model.addAttribute("i",it);
			model.addAttribute("grid", false);
		}

		return new ModelAndView( getPages().getADMIN_ITEM_JSON(),model );
	}



	@RequestMapping(value="/admin/item/item.html",method = RequestMethod.POST)
	public ModelAndView saveItem(HttpServletRequest request, HttpServletResponse resp, ModelMap model,
			@RequestParam(value="act",required=true) int act,
			@RequestParam(value="data",required=true) String data)
	{

		String msg = "";
		try{
			JSONParser parser=new JSONParser();

			JSONObject obj =(JSONObject)parser.parse(data);

			int id = GenericUtil.toInt( (String) obj.get("i_id"), -1);
			Item it;
			switch (act) {
			case 0: //save
				it= new Item();
				it = (Item) ControllerUtils.populateObject(it,obj,"i_");
				getDaoManager().create(it);
				msg = "New Item ["+it.getName()+"] Created";
				break;
			case 1:	//edit					
				it = getDaoManager().getItemById(id);
				it = (Item) ControllerUtils.populateObject(it,obj,"i_");
				getDaoManager().update(it);
				msg = "Item ["+it.getName()+"] Updated";
				break;				
			case 2:	//delete
				it = getDaoManager().getItemById(id);
				getDaoManager().delete( it );
				msg = "Item Deleted";
				break;

			default:
				break;
			}


		} catch (Exception e) 
		{
			model.addAttribute(getPages().getCONTEXT_ERROR(),e.getMessage());
		}

		model.addAttribute(getPages().getCONTEXT_ERROR(),msg);

		model = prepareModel(request, model);

		return new ModelAndView( getPages().getADMIN_ITEM(),model );
	}

	

	@RequestMapping(value="/admin/item/item.json",method = RequestMethod.POST)
	public ModelAndView uploadImage(HttpServletRequest request, HttpServletResponse resp, ModelMap model)
	{
		try{
			ControllerUtils.uploadAndResizeImage(request,
					getPages().getAbsoluteIMG_ITEM_PATH(),null,
					getPages().getIMG_ITEM_EXT().substring(1),
					56,56);
		}
		catch (Exception e) {
			return new ModelAndView( getPages().getRedirect(request,getPages().getADMIN_ITEM(),e.getMessage()) );
		}

		return new ModelAndView( getPages().getRedirect(request,getPages().getADMIN_ITEM(),"File succesfully uploaded!") );
	}
	

	
	private ModelMap prepareModel(HttpServletRequest request, ModelMap model) 
	{
		
		ArrayList<String> l = ControllerUtils.getFileList(getPages().getAbsoluteIMG_ITEM_PATH());
		model.addAttribute("images", l);
		
		ArrayList<Spell> slist = getDaoManager().getSpellList();
		model.addAttribute("spells", slist);

		model.addAttribute(getPages().getCONTEXT_PAGES(), getPages());
		model.addAttribute("base", request.getContextPath());

		return model;
	}

	
}
