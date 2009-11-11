package org.infinite.engines.account;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.fail;

import org.infinite.db.dao.DaoManager;
import org.infinite.db.dto.TomcatUsers;
import org.infinite.util.TestUtil;
import org.infinite.web.engines.account.AccountEngine;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.xml.XmlBeanFactory;

public class AccountEngineTest {

	String USER = "testUser";
	String PASS = "testPass";
	String EMAIL = "test@test.org";
	String ROLE = "player";
	
	private AccountEngine accountEngine;
	private DaoManager daoManager;
	
	@Before
	public void setUp() throws Exception {
		XmlBeanFactory factory = TestUtil.getBeanFactory();
		accountEngine= (AccountEngine) factory.getBean("AccountEngine");
		daoManager= (DaoManager) factory.getBean("DaoManager");
	}
	
	
	@Test
	public void testRegisterNewUserStringStringStringStringStringBoolean() {
		
		
		try {
			accountEngine.registerNewUser(USER, PASS, EMAIL, "", "",false);
			
			TomcatUsers l = daoManager.getTomcatUsers(USER);
			
			assertNotNull(l);
			
			TomcatUsers t = l;
			assertNotNull(t);
			
			assertEquals(t.getUser(), USER);
			assertEquals(t.getPassword(), PASS);
			assertEquals(t.getEmail(), EMAIL);
			assertNotNull(t.getTomcatRoles());
			assertEquals(t.getTomcatRoles().getUser(), USER);
			assertEquals(t.getTomcatRoles().getRole(), ROLE);
			
			daoManager.delete(t);
			
		} catch (Exception e) {
			fail( e.getMessage() );
		}
		
		
	}

}
