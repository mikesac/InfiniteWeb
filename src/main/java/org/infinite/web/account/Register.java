package org.infinite.web.account;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.dao.DaoManager;
import org.infinite.web.engines.account.AccountEngine;
import org.infinite.web.utils.PagesCst;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/login/register.html")
public class Register {

	private static final long serialVersionUID = 1L;

	@Autowired
	private AccountEngine accountEngine;
	
	@Autowired
	private DaoManager daoManager;

	@Autowired
	private	PagesCst pages;

	public void setAccountEngine(AccountEngine accountEngine) {	this.accountEngine = accountEngine;	}
	public AccountEngine getAccountEngine() {return accountEngine;}
	
	public void setPages(PagesCst pages) {this.pages = pages;}
	public PagesCst getPages() {return pages;}

	public void setDaoManager(DaoManager dao) {this.daoManager = dao;}
	public DaoManager getDaoManager() { return daoManager; }
	
	
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView initRegister(HttpServletRequest req, HttpServletResponse resp, ModelMap model){
		
		model.addAttribute("pages", getPages());
		
		return new ModelAndView(getPages().getPAGE_REGISTER(),model );
	}
	
	
	@RequestMapping(method = RequestMethod.POST)
	public ModelAndView register(	
			HttpServletRequest req, HttpServletResponse resp, ModelMap model,
			@RequestParam(value="username",required=true) String user,
			@RequestParam(value="password",required=true) String pass,
			@RequestParam(value="email",required=true) String email,
			@RequestParam(value="j_captcha_response",required=true) String captchaResponse
	){

		String err = "";
		String next = getPages().getPAGE_REGISTER();


			try{

				String captchaId = req.getSession().getId();

				getAccountEngine().registerNewUser(user, pass, email, captchaId, captchaResponse);
				
				err ="Account created,login as "+user;
				next = getPages().getPAGE_ROOT();
			}
			catch (Exception e) {
				err = e.getMessage();
			}
		
		model.addAttribute(getPages().getCONTEXT_ERROR(),err);
		return new ModelAndView(next,model );
		
	}

}