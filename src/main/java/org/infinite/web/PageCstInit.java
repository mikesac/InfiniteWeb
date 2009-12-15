package org.infinite.web;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.web.utils.PagesCst;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping({"/login/login.html","/index.html"})

public class PageCstInit {

	@Autowired
	private	PagesCst pages;
		
	public void setPages(PagesCst pages) {this.pages = pages;}
	public PagesCst getPages() {return pages;}

	@RequestMapping(method = RequestMethod.GET)
	public  String initConstants(HttpServletRequest request, HttpServletResponse response,  ModelMap model) 
	{
		model.addAttribute(getPages().getCONTEXT_PAGES(), getPages());
		model.addAttribute("base", request.getContextPath());

		return request.getRequestURI().substring(request.getContextPath().length()).replaceAll("\\.html", "");
	}
}