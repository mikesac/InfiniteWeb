<html>
<head>

<title>Login</title>
</head>
<body>

<div class="toggler">

<div class="ui-dialog ui-widget ui-widget-content ui-corner-all" style="width: 40%; height: 30%; position: relative; top: 25%; ">
   <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
      <span id="ui-dialog-title-dialog" class="ui-dialog-title">Infinite Login!</span>
      <span class="ui-dialog-titlebar-close ui-corner-all"><span class="ui-icon ui-icon-person">person</span></span>
   </div>
   <div style="height: 200px;  width: auto;" class="ui-dialog-content ui-widget-content" id="dialog">
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
</div>

</body>
</html>