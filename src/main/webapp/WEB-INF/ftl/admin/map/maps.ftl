<#include "../../common/macro.ftl" >
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Infinite World Test Server</title>
	</head>
	<body>
	
	<h1>New Map Management</h1>
	
	<@nestedpanel icon="person" title="Create New Map" width=400 height=300>
	
		<table>
			<tr>
				<td><img src="../${pages.IMG_WEB_PATH}admin/maps.gif" ></td>
				<td>Fill the form with the Map image and the size of the areas you want it to be splitted in.</td>
			</tr>
		</table>
		<hr/>
		<form name="maps" method="POST" action="${rc.getContextPath() + pages.ADMIN_MAPPREVIEW + pages.PAGE_EXT}" enctype="multipart/form-data">
		<table align="center">
			<tr>
				<td>X</td>
				<td>
					<select name="x">
						<option value="5">5</option>
						<option value="4" selected="selected">4</option>
						<option value="3">3</option>
						<option value="2">2</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>Y</td>
				<td>
					<select name="y">
						<option value="5">5</option>
						<option value="4">4</option>
						<option value="3" selected="selected">3</option>
						<option value="2">2</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr><td>Image</td><td><input type="file" name="map"/></td></tr>
		</table>
		<input type="submit"/>
		</form>
		<hr/>
		Need more help? Consult <a href="http://wiki.github.com/mikesac/infiniteworld/expand-game-nuova-area">wiki</a>
	</@nestedpanel>
	
	
	</body>
</html>