<html>
<head>
<title>Choose Your Character</title>
</head>
<body>

<div style="width:${map_width?int}px;padding:5px 5px 5px 5px;margin-top:1%;background-color:black;" class="ui-widget ui-corner-all">
<table cellpadding=0 cellspacing=0 border=0 width="${map_width?int}px" height="${map_height?int}">

<#list mapbackground as row>
	<tr>
	<#list row as cell>
		<td style="width:${map_width / map.nx};height:${map_height / map.ny};background-image:url('${rc.getContextPath()}/imgs/maps/${cell.background}.jpg');">
		
		<#list cell.items as areaitem>			
			<div class="iconmedium"	style="position:relative;top:${areaitem.y}px;left:${areaitem.x}px;background-image: url(${rc.getContextPath()}/imgs/maps/icons/${areaitem.icon}.png);">
				<div class="tile">
					<a href="${rc.getContextPath()}${pages.PAGE_MAP}${pages.PAGE_EXT}?m=${areaitem.id}" ></a>
					
					<#switch areaitem.status >					
						<#case 0>
							<img style="margin-top:5px;margin-left:5px;" src="${rc.getContextPath()}/imgs/maps/icons/here.gif" width="34" />
							<#break>
						<#case 5>
							<img src="${rc.getContextPath()}/imgs/maps/icons/ok.gif" width="22" />
							<#break>
						<#case 1>
							<img style="margin-top:5px;margin-left:5px;" src="${rc.getContextPath()}/imgs/maps/icons/banned.png" width="34" />
							<#break>
						<#case 4>
							<img style="margin-top:5px;margin-left:5px;" src="${rc.getContextPath()}/imgs/maps/icons/step.png" width="34" />
							<#break>
						<#case 3>
							<#break>
						<#case 2>
							<img style="margin-top:5px;margin-left:5px;" src="${rc.getContextPath()}/imgs/maps/icons/lock.png" width="34" />
							<#break>
					</#switch>
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
</body>
</html>