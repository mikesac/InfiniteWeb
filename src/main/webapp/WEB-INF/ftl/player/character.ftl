<html>
<head>
<title>Choose Your Character</title>
</head>
<body>

<div class="ui-widget" style="width:50%">
	<div class="ui-state-highlight ui-corner-all" style="padding: 0pt 0.7em; margin-top: 20px;">
		<h2>Choose your character</h2>
	</div>
</div>
<div id="accordion" style="width:80%;margin-top:1%;inherit:false;">
	<#list characterList as c>
		<h3><a href="#" >${c.name}</a></h3>
    	<div>
    	   	
			<table>
				<tr>
					<td style="text-align:center">
						<div class="ui-widget ui-widget-content ui-corner-all" style="padding: 3px 10px 3px 10px;">
						<img alt="${c.name}" src="${pages.IMG_PC_PATH}${c.image}" width="100" ><br/>Level ${c.level}
						</div>
					</td>
					<td>
					<table>
						<tr>
							<td><img src="${pages.IMG_WEB_PATH}stats/ico/life.gif" alt="Life Points" title="Life Points"></td>
							<td><input readonly="readonly" type="text" size=8" value="${c.basePl}" /></td>
							<td><img src="${pages.IMG_WEB_PATH}stats/ico/mana.gif" alt="Magic Points" title="Magic Points"></td>
							<td><input readonly="readonly" type="text" size=8" value="${c.basePm}" /></td>
							<td><img src="${pages.IMG_WEB_PATH}stats/ico/action.gif" alt="Action Points" title="Action Points"></td>
							<td><input readonly="readonly" type="text" size=8" value="${c.basePa}" /></td>
							<td><img src="${pages.IMG_WEB_PATH}stats/ico/charm.gif" alt="Charm Points" title="Charm Points"></td>
							<td><input readonly="readonly" type="text" size=8" value="${c.basePc}" /></td>
							<td><img src="${pages.IMG_WEB_PATH}stats/ico/gold.gif" alt="Gold" title="Gold"></td>
							<td><input readonly="readonly" type="text" size=8" value="${c.gold}" /></td>
							<td><img src="${pages.IMG_WEB_PATH}stats/ico/px.gif" alt="Experience Points" title="Experience Points"></td>
							<td><input readonly="readonly" type="text" size=8" value="${c.px}" /></td>
						</tr>
						<tr>
							<td><img src="${pages.IMG_WEB_PATH}stats/ico/str.gif" alt="Strenght" title="Strenght"></td>
							<td><input readonly="readonly" type="text" size=8" value="${c.baseStr}" /></td>
							<td><img src="${pages.IMG_WEB_PATH}stats/ico/int.gif" alt="Intelligence" title="Intelligence"></td>
							<td><input readonly="readonly" type="text" size=8" value="${c.baseInt}" /></td>
							<td><img src="${pages.IMG_WEB_PATH}stats/ico/dex.gif" alt="Dexterity" title="Dexterity"></td>
							<td><input readonly="readonly" type="text" size=8" value="${c.baseDex}" /></td>
							<td><img src="${pages.IMG_WEB_PATH}stats/ico/cha.gif" alt="Charisma" title="Charisma"></td>
							<td><input readonly="readonly" type="text" size=8" value="${c.baseCha}" /></td>
							<td><img src="${pages.IMG_WEB_PATH}stats/ico/map.gif" alt="Area" title="Area"></td>
							<td colspan="3"><input readonly="readonly" type="text" size="20" value="${c.areaItem.name}" /></td>
						</tr>
					</table>
					
					</td>
					<td><button onclick="javascript:goplay('${c.name}')">Play</button></td>
				</tr>
			</table>
		</div>
	</#list>
    
    <h3><a href="#">Create new character</a></h3>
    <div>
		<form name="newchar" method="POST" action="${rc.getContextPath()}${pages.PAGE_CHARACTER}${pages.PAGE_EXT}" enctype="multipart/form-data">
		<table>	
		<tr>
		<td>
			<div class="ui-widget ui-widget-content ui-corner-all" style="padding: 3px 10px 3px 10px;">
			<img class="avatar" alt="No Character" src="${pages.IMG_WEB_PATH}player/pg_void.jpg" width="100">
			</div>
		</td>
		<td>Character Name</td>
		<td><input type="text" name="new_name" /></td>
		<td>Character Picture</td>
		<td><input type="file" name="new_pic" /></td>
		<td><input type="submit" /></td>
	</tr>
	</table>
	</form>
	</div>
</div>


<form  name="start" action="${rc.getContextPath()}${pages.PAGE_START}${pages.PAGE_EXT}" method="post">
<input type="hidden" value="" name="chname">
</form>

<script type="text/javascript">
$(document).ready(function(){
    $("#accordion").accordion({ event: 'mouseover' , fillSpace: true});
  });
	


function goplay(name){
	document.forms.start.chname.value = name;
	document.forms.start.submit();
}

</script>

</body>

</html>