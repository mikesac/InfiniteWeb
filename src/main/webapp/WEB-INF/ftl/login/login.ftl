<html>
<head>
<title>Login</title>
</head>
<body>
<div id="dialog" title="Infinite Login">
	<form name="login" method="post" action="j_security_check">
		<table align="center">
			<tr	align="center">
				<td>Username</td>
				<td><input type="text" name="j_username" /></td>
			</tr>
			<tr>
				<td>Password</td>
				<td><input type="password" name="j_password" /></td>
			</tr>
			<tr	align="center">
				<td colspan="2"><input type="submit" /></td>
			</tr>
		</table>
	</form>
</div>
<script>
	$("#dialog").dialog({ draggable: false,resizable: false ,closeOnEscape: false, modal:true,close: reopen,hide: 'fold'  });	
	function reopen(){  $("#dialog").dialog('open') } 
</script>
</body>
</html>