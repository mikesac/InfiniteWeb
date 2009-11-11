package org.infinite.web.engines.account;

import java.util.List;

import org.infinite.db.dao.DaoManager;
import org.infinite.db.dto.TomcatRoles;
import org.infinite.db.dto.TomcatUsers;
import org.springframework.beans.factory.annotation.Autowired;

import com.octo.captcha.service.CaptchaServiceException;

public class AccountEngine {

	@Autowired
	private DaoManager daoManager;
	
	public void setDaoManager(DaoManager dao) {this.daoManager = dao;}
	public DaoManager getDaoManager() { return daoManager; }
	
	public void registerNewUser(String user,String pass,String email,String captchaId,String captchaResponse) throws Exception{
		registerNewUser(user, pass, email, captchaId, captchaResponse,true);
	}
	
	public void registerNewUser(String user,String pass,String email) throws Exception{
		registerNewUser(user, pass, email, "", "",false);
	}
	
	//captcha must be disable for testUnit
	public void registerNewUser(String user,String pass,String email,String captchaId,String captchaResponse,boolean useCaptcha) throws Exception{

		if(useCaptcha && !validateCaptchaForId(captchaId,captchaResponse))
		{
			throw new Exception("Invalid Captcha");
		}


		if(user==null || user.length()==0 ){
			throw new Exception("Invalid Username");
		}

		if(pass==null || pass.length()==0 ){
			throw new Exception("Invalid Password");
		}

		if(email==null || email.length()==0 || email.indexOf("@")==-1){
			throw new Exception("Invalid email");
		}

		List<TomcatUsers> l = getDaoManager().findTomcatUsers(user, email);

		if(l==null){
			throw new Exception("Error retrieving users data, prease try again or contact support");
		}
		
		if(l.size()!=0){
			throw new Exception("USERNAME or EMAIL already in use, please choose a different ones");
		}

		TomcatUsers u = new TomcatUsers(user,pass,email);
		TomcatRoles r = new TomcatRoles(u,"player");
		getDaoManager().create(u);
		getDaoManager().create(r);	

	}


	private static boolean validateCaptchaForId(String captchaId,String captchaResponse) {

		boolean isResponseCorrect = false;

		// Call the Service method
		try {
			isResponseCorrect = CaptchaServiceSingleton.getInstance().validateResponseForID(captchaId, captchaResponse);
		} catch (CaptchaServiceException e) {
			// should not happen, may be thrown if the id is not valid
		}

		return isResponseCorrect;
	}
}
