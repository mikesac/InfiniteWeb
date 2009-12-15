<#include "../../common/macro.ftl" >
<html>
<head>
<title>Map Preview</title>
</head>
<body>

<table width="98%">
	<tr>
		<td width="80%">
		<table align="center" id="prwTable" cellpadding="2" cellspacing="2" style="background-color: black;">
			<#list tiles as tilesx>
				<tr>
				<#list tilesx as tile>
					<td><img src="${tile}"/></td>
				</#list>
				</tr>
			</#list>
		</table>
		</td>
		<td valign="middle" align="left">
			
			<@nestedpanel icon="home" title="Save map data" width=400 height=450>			
			
			<form name="map_form" action="${rc.getContextPath() + pages.ADMIN_MAP + pages.PAGE_EXT}" method="post">
				<table width="100%">
				<tr><td>Name</td><td><input type="text" name="area_name" size="10" value="" ></td></tr>
				<tr><td>Description</td><td><textarea name="area_desc"  value="" ></textarea></td></tr>
				<tr><td>World</td><td><input type="text" name="area_world" size=3  value="0" ></td></tr>
				<tr><td>n.X</td><td><input type="text" name="area_x" size=3 value="${nx}" readonly="readonly" ></td></tr>
				<tr><td>n.Y</td><td><input type="text" name="area_y" size=3 value="${ny}" readonly="readonly" ></td></tr>
				</table>
				<input type="hidden" name="area_path" value="${path}">
				<input onclick="validate()" type="submit" value="Save"/>
			</form>
			
			<hr/>
			Use this button to toggle tiles border on/off
			<button onclick="togglePad()">Toggle Border</button>
			<hr/>
		Need more help? Consult <a href="http://wiki.github.com/mikesac/infiniteworld/expand-game-nuova-area">wiki</a>
			<img src="../${pages.IMG_WEB_PATH}admin/maps.gif" >
			</@nestedpanel>
		</td>
	</tr>
</table>


<script>
	var padded = true;

	function togglePad() {

		if (padded) {
			document.getElementById("prwTable").cellPadding = 0;
			document.getElementById("prwTable").cellSpacing = 0;
		} else {
			document.getElementById("prwTable").cellPadding = 2;
			document.getElementById("prwTable").cellSpacing = 2;
		}
		padded = !padded;

	}
	
	function validate()
	{
		out = true;
		
		if(document.forms['map_form'].elements['area_name'].value==""){
			alert('[Name] is mandatory');
			out=false;
		}
			
		if(document.forms['map_form'].elements['area_desc'].value==""){
			alert('[Description] is mandatory');
			out=false;
		}
			
		if(document.forms['map_form'].elements['area_world'].value==""){
			alert('[World] is mandatory, set to 0 if you are not sure.');
			document.forms['map_form'].elements['area_world'].value="0";
			out=false;
		}
		return out;
	}
</script>



</body>
</html>