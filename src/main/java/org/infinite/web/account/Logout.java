package org.infinite.web.account;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.web.utils.PagesCst;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@RequestMapping("/logout.html")
public class Logout{

	@Autowired
	private	PagesCst pages;
	
	public void setPages(PagesCst pages) {this.pages = pages;}
	public PagesCst getPages() {return pages;}
	
	
	
	@RequestMapping(method = RequestMethod.GET)
	protected ModelAndView logout(HttpServletRequest request, HttpServletResponse response,  ModelMap model) {

		//save all player data to DB before closing
		request.getSession().invalidate();
		return new ModelAndView(new RedirectView( request.getContextPath() +  getPages().getPAGE_ROOT() + getPages().getPAGE_EXT()) );
	}

}