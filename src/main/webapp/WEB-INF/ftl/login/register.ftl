<#include "../common/macro.ftl" >
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Register</title>
</head>
<body>

		<form name="register" method="post" action="${rc.getContextPath() + pages.PAGE_REGISTER + pages.PAGE_EXT}">
		
		<@nestedpanel icon="person" title="Please provide your data" width=400 height=500>
		
		<center>
		<table>
			<tr>
				<td colspan="2" align="center" ><img class="round"
					align="center" src="${pages.IMG_WEB_PATH}hdr/logo.png">
				</td>
			</tr>			
			<tr>
				<td>Username</td>
				<td><input type="text" name="username" /></td>
			</tr>
			<tr>
				<td>Password</td>
				<td><input type="password" name="password" /></td>
			</tr>
			<tr>
				<td>Email</td>
				<td><input type="text" name="email" /></td>
			</tr>
			
			<tr>
				<td colspan="2" align="center" ><img src="${rc.getContextPath()}/jcaptcha"></td>
			</tr>
			<tr>
				<td>Captcha	</td>
				<td><input type='text' name='j_captcha_response' value=''></td>
			</tr>
		</table>
		<input type="submit" />
		</form>
		</center>
		</@nestedpanel>
</body>
</html>