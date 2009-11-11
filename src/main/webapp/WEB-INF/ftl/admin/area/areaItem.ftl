<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Area Item Editor</title>
</head>
<body>
<table width="100%">
	<tr>
		<td style="width:${map_width+40}px;">			
			<div style="width:${map_width+20}px;">		
			<table cellpadding=0 cellspacing=0 border=0 width="${map_width}px" height="${map_height}" id="prwTable" >
			<#list mapbackground as row>
				<tr>
				<#list row as cell>
					<td style="width:${map_width / map.nx};height:${map_height / map.ny};background-image:url('${rc.getContextPath()}/imgs/maps/${cell.background}.jpg');">
					
					<#list cell.items as areaitem>			
						<div onclick="getAreaData(${areaItem.id})" id="${areaItem.name}" class="iconmedium" style="position:relative;top:${areaitem.y}px;left:${areaitem.x}px;background-image: url(${rc.getContextPath()}/imgs/maps/icons/${areaitem.icon}.png);">
							<div class="tile">
								<a href="${rc.getContextPath()}${pages.PAGE_MAP}${pages.PAGE_EXT}?m=${areaitem.id}" ></a>
								<img src="${rc.getContextPath()}/imgs/maps/icons/ok.gif" width="22" />
							</div>
							
							<#if areaitem.icon=="fight" && (areaitem.status==0 || areaitem.status==5 || areaitem.status==1) > 
								<span style="position:relative;color:white;background-color:black;top:-18;left:30;">${areaitem.level}</span>
							</#if>				
						</div>
					</#list> 	
					</td>
				</#list>
				</tr>
			</#list>
			</table>			
			</div>
		
		</td>
		<td valign="top">
			<div style="width: 400px" align="center">
			<h3 style="text-align: center">Edit Area Item Data</h3> 
			
			<form action="${rc.getContextPath()}/saveAreaItem" name="formedit" method="post">
			
			<input type="hidden" name="areaid" value="${area.id}" />
			<input type="hidden" name="act" value="1" />
			
		<table>
		
			<tr>
				<td>id</td>
				<td><input type="text" name="id" readonly="readonly" size="3"></td>
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
				<td><input type="text" name="cost" size=3></td>
			</tr>
			
			<tr>
				<td>areax</td>
				<td><input type="text" name="areax" size=3></td>
			</tr>
			<tr>
				<td>areay</td>
				<td><input type="text" name="areay" size=3></td>
			</tr>
			<tr>
				<td>x</td>
				<td><input type="text" name="x" size=3></td>
			</tr>
			<tr>
				<td>y</td>
				<td><input type="text" name="y" size=3></td>
			</tr>
			<tr>
				<td>arealock</td>
				<td><input type="text" name="arealock" size=3></td>
			</tr>
			<tr>
				<td>questlock</td>
				<td><input type="text" name="questlock" size=3></td>
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
				<td><input type="text" name="areaItemLevel" size=3></td>
			</tr>
			<tr>
				<td>npcs</td>
				<td><input type="text" name="npcs" ></td>
			</tr>
		</table>
		
		<input type="submit" value="Save" />
		</form>

		<table>
			<tr>
				<td>
					<button onclick="preview()" style="font-size:x-small">Preview (only X & Y)</button>
				</td>
				
				<td>
					<button onclick="newArea()" style="font-size:x-small">New</button>
				</td>
				
				<td>
					<button onclick="togglePad()" style="font-size:x-small">Toggle Border</button>
				</td>
			</tr>
			<tr>
				<td colspan="3">
				<form method="post" name="formlist"
					action="${rc.getContextPath() + pages.ADMIN_MAPITEMS}">
				<select name="areaid">
					<#list allareas as area>
						<option value="${area.id}" <#if area.id==a.id>selected="selected"</#if> >${area.name}</option>
					</#list>
				</select> <input type="submit" value="go"></form>
				</td>
			</tr>
		</table>
		
			
			</div>			
		</td>
	</tr>
	
</table>

<script type="text/javascript" src="../../js/prototype.js"></script>
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

		new Ajax.Request('${rc.getContextPath()}/admin/map/jsonAreaItem.jsp', {
			  parameters: { id: id },
			  method: 'get',
			  sanitizeJSON:true,
			  onSuccess: function(response) {
				  	jdata = response.responseJSON;

				  	

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
			});		
	}

	function newArea(){

		document.forms['formedit'].elements["act"].value="0";
		document.forms['formedit'].reset();
		document.forms['formedit'].submit();
	}

	
</script>

</body>
</html>