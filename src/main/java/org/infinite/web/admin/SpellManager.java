package org.infinite.web.admin;

import java.io.File;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.dao.DaoManager;
import org.infinite.db.dto.Spell;
import org.infinite.db.dto.TomcatRoles;
import org.infinite.util.GenericUtil;
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
public class SpellManager {

	@Autowired
	private	PagesCst pages;

	@Autowired
	private DaoManager daoManager;

	public void setPages(PagesCst pages) {this.pages = pages;}
	public PagesCst getPages() {return pages;}

	public void setDaoManager(DaoManager dao) {this.daoManager = dao;}
	public DaoManager getDaoManager() { return daoManager; }

	@RequestMapping(value="/admin/spell/spell.html",method = RequestMethod.GET)
	public ModelAndView initSpells(HttpServletRequest request, HttpServletResponse resp, ModelMap model)
	{
		String userName = request.getUserPrincipal().getName();		
		TomcatRoles role = getDaoManager().getUserRole(userName);		
		if(role==null || !role.getRole().equalsIgnoreCase("manager")){
			return new ModelAndView( getPages().getRedirect(request,getPages().getPAGE_ROOT(),"You cannot access this area!") );
		}
		model = prepareModel(request, model);
		return new ModelAndView( getPages().getADMIN_SPELL(),model );
	}
	
	
	
	@RequestMapping(value="/admin/spell/spell.json",method = RequestMethod.GET)
	public ModelAndView getJson(
			HttpServletRequest request, HttpServletResponse resp, ModelMap model,
			@RequestParam(value="id",required=true) int id
		)
	{
		
		Spell spell = getDaoManager().getSpellById(id);
		
		model.addAttribute("s",spell);
		
		return new ModelAndView( getPages().getADMIN_SPELL_JSON(),model );
	}
	
	
	
	@RequestMapping(value="/admin/spell/spell.html",method = RequestMethod.POST)
	public ModelAndView saveSpell(HttpServletRequest request, HttpServletResponse resp, ModelMap model,
			@RequestParam(value="act",required=true) int act,
			@RequestParam(value="data",required=true) String data)
	{
		
		String msg = "";
		try{
		JSONParser parser=new JSONParser();
		  
			JSONObject obj =(JSONObject)parser.parse(data);
			
			int id = GenericUtil.toInt( (String) obj.get("s_id"), -1);
			Spell s;
			switch (act) {
			case 0: //save
				s= new Spell();
				s = populateSpell(s,obj);
				getDaoManager().create(s);
				msg = "New Spell ["+s.getName()+"] Created";
				break;
			case 1:	//edit					
				s = getDaoManager().getSpellById(id);
				s = populateSpell(s,obj);
				getDaoManager().update(s);
				msg = "Spell ["+s.getName()+"] Updated";
				break;				
			case 2:	//delete
				s = getDaoManager().getSpellById(id);
				getDaoManager().delete( s );
				msg = "Spell Deleted";
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
		
		return new ModelAndView( getPages().getADMIN_SPELL(),model );
	}
	
	
	@SuppressWarnings("unchecked")
	private Spell populateSpell(Spell s, JSONObject obj) throws Exception{
		
		Class<?> c = s.getClass();
		for (Iterator<String> iterator = obj.keySet().iterator(); iterator.hasNext();) {
			String key = iterator.next();
			String value = (String)obj.get(key);
			if(key.startsWith("s_")){
				key = key.substring(2);
			}
			
			String getter = "get" + key.substring(0,1).toUpperCase() + key.substring(1, key.length());
			String setter = "set" + key.substring(0,1).toUpperCase() + key.substring(1, key.length());
			
			//obtain type from getter
			Method m = c.getMethod(getter);			
			Class returnType = m.getReturnType();
			
			//use it to retrieve setter
			m = c.getMethod(setter, returnType);
			
			if(returnType.equals( String.class) ){
				m.invoke(s, value);
			}
			else if(returnType.equals( Integer.class)){
				int v = GenericUtil.toInt( value, -1);
				m.invoke(s, v);
			}
			else if(returnType.equals( Long.class) || returnType.equals(Float.class)|| returnType.toString().equalsIgnoreCase("float")){
				int v = GenericUtil.toInt( value, -1);
				m.invoke(s, (1.0f * v));
			}
			else{
				String msg="unrecognized reflection type:"+returnType.toString()+"form method "+m.toString();
				System.err.println(msg);
				throw new Exception(msg);
			}
		}		
		return s;
	}
	
	
	private ModelMap prepareModel(HttpServletRequest request, ModelMap model) {
		ArrayList<String> imageList = new ArrayList<String>();
		File f = new File(getPages().getAbsoluteIMG_SPELL_PATH());
		if(f.exists() && f.isDirectory()){
			String[] imgList= f.list(null);
			for (int i = 0; i < imgList.length; i++) {
				imageList.add(imgList[i].substring(0,imgList[i].lastIndexOf(".")));
			}
		}
		model.addAttribute("images", imageList);
		
		ArrayList<Spell> list = getDaoManager().getSpellList();
		model.addAttribute("spells", list);
			
		model.addAttribute(getPages().getCONTEXT_PAGES(), getPages());
		model.addAttribute("base", request.getContextPath());
		
		return model;
	}
	
	
}
