<#include "../../common/macro.ftl" >
<html>
<head>
	<title>Area Item Editor</title>
</head>
<body>
<style>
	.ui-widget input, .ui-widget select{font-size:small;}
</style>
<table width="100%">
	<tr>
		<td align="center" valign="top">
			<form method="GET" name="formlist" action="${rc.getContextPath() + pages.ADMIN_AREAITEMS + pages.PAGE_EXT}">
				<select name="areaid">
					<#list allareas as a>
						<option value="${a.id}" <#if a.id==area.id>selected="selected"</#if> >${a.name}</option>
					</#list>
				</select>
				<input type="submit" value="go">
			</form>			
			<div style="width:${map_width+10}px;padding-top:5px;padding-bottom:5px;background-color:black;"">		
				<table cellpadding=0 cellspacing=0 border=0 width="${map_width}px" height="${map_height}" id="prwTable" >
				<#list mapbackground as row>
					<tr>
					<#list row as cell>
						<td style="width:${map_width / adminmap.nx};height:${map_height / adminmap.ny};background-image:url('${pages.IMG_MAP_PATH}${cell.background}.jpg');">
						<#list cell.items as areaItem>			
							<div id="${areaItem.name}" class="iconmedium" style="position:relative;top:${areaItem.y}px;left:${areaItem.x}px;background-image: url(../${pages.IMG_WEB_PATH}maps/${areaItem.icon}.png);">
								<div class="tile">
									<a href="javascript:getAreaData(${areaItem.id})" ></a>
									<img src="../${pages.IMG_WEB_PATH}maps/ok.gif" width="22" >
								</div>								
								<#if areaItem.icon=="fight" > 
									<span style="position:relative;color:white;background-color:black;top:-18;left:30;">${areaItem.level}</span>
								</#if>				
							</div>
						</#list> 	
						</td>
					</#list>
					</tr>
				</#list>
				</table>			
			</div>
			<button onclick="togglePad()" style="font-size:x-small">Toggle Border</button>		
		</td>
		<td valign="top">
		
			<@nestedpanel icon="image" title="Edit Area Item Data" width=350 height=520>
			<form action="${rc.getContextPath() + pages.ADMIN_AREAITEMS + pages.PAGE_EXT}" name="formedit" method="post">
				<input type="hidden" name="areaid" value="${area.id}" />
				<input type="hidden" name="act" value="1" />			
				<table>
					<tr>
						<td>id</td>
						<td><input type="text" name="id" readonly="readonly" size="3" value="0"></td>
					</tr>
					<tr>
						<td>name</td>
						<td><input type="text" name="name"></td>
					</tr>
					<tr>
						<td>icon</td>
						<td>
							<select name="icon">
								<#list icons as icon>
									<option value="${icon}">${icon}</option>
								</#list> 
							</select>
						</td>
					</tr>
					<tr>
						<td>cost</td>
						<td><input type="text" name="cost" size="3" value="0"></td>
					</tr>			
					<tr>
						<td colspan=2>
							<table width="100%">
								<tr>					
									<td width="25%">areax</td>
									<td width="25%"><input type="text" name="areax" size="3" value="0" ></td>								
									<td width="25%">areay</td>
									<td width="25%"><input type="text" name="areay" size="3" value="0" ></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td colspan=2>
							<table width="100%">
								<tr>
									<td width="25%">x</td>
									<td width="25%"><input type="text" name="x" size="3" value="0" ></td>								
									<td width="25%">y</td>
									<td width="25%"><input type="text" name="y" size="3" value="0" ></td>									
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>arealock</td>
						<td><input type="text" name="arealock" size="3" ></td>
					</tr>
					<tr>
						<td>questlock</td>
						<td><input type="text" name="questlock" size="3" ></td>
					</tr>
					<tr>
						<td>url</td>
						<td><input type="text" name="url" ></td>
					</tr>
					<tr>
						<td>loop</td>
						<td><input type="checkbox" name="loop"></td>
					</tr>
					<tr>
						<td>hidemode</td>
						<td><input type="checkbox" name="hide"></td>
					</tr>
					<tr>
						<td>areaItemLevel</td>
						<td><input type="text" name="areaItemLevel" size="3" value="0"></td>
					</tr>
					<tr>
						<td>npcs</td>
						<td><input type="text" name="npcs" ></td>
					</tr>
				</table>
			</form>
			<table>
				<tr>
					
					<td valign="top" align="center" width="50%">
						<button onclick="newArea()" >New</button><br/>
						<button onclick="saveArea()">Save</button>
						<button onclick="deleteArea()">Delete</button>
						<button onclick="preview()" >Preview X&Y</button>
					</td>
					<td valign="top" align="right">						
						<img src="../${pages.IMG_WEB_PATH}admin/areas.gif" >
					</td>
				</tr>
			</table>
			<hr/>
		Need more help? Consult <a href="http://wiki.github.com/mikesac/infiniteworld/expand-game-nuova-area">wiki</a>
			</@nestedpanel>
		</td>
	</tr>
</table>

<script>
	var padded = false;

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

	function preview(){
		var name = document.forms['formedit'].elements["name"].value;
		var x = document.forms['formedit'].elements["x"].value + "px";
		var y = document.forms['formedit'].elements["y"].value + "px";

		document.getElementById(name).style.left = x;
		document.getElementById(name).style.top = y;
		
	}
	
	function getAreaData(id){

		$.getJSON(
			"${rc.getContextPath() + pages.ADMIN_JSONAREAITEMS + pages.PAGE_EXT}?id="+id,
		  	function(jdata){
		    	for(var i=0;i<document.forms['formedit'].elements.length;i++){
					var name = document.forms['formedit'].elements[i].name;

					if(document.forms['formedit'].elements[name].type=="checkbox"){
						document.forms['formedit'].elements[name].checked=jdata[name];
					}
					else{						
						document.forms['formedit'].elements[name].value = jdata[name];
					}
				}
				document.forms['formedit'].elements["act"].value="1";
		  	}
		);
	
	}

	function newArea(){

		document.forms['formedit'].reset();
		document.forms['formedit'].elements["act"].value="0";		
		document.forms['formedit'].submit();
	}
	
	function saveArea(){
		document.forms['formedit'].submit();
	}
	
	function deleteArea(){
		if(document.forms['formedit'].elements["areaid"].value==0){
			alert("select an area to be deleted!");
		}
		else{
			document.forms['formedit'].elements["act"].value="2";		
			document.forms['formedit'].submit();
		}
	}

	
</script>

</body>
</html>