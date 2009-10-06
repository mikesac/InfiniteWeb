<html>
<head>
<title>Choose Your Character</title>
</head>
<body>
<center>
<div style="width:50%">
<table width="99%">
	<tr><td colspan=5 " align="center">Choose your character</td></tr>
</table>
</div>

<div style="width:1200px; height:430px;overflow: auto;padding: 1% 1% 1% 1%;">
<div>

<table width="99%">
	
	<#list characterList as c>

			
			<tr>
			<td><img class="avatar" alt="${c.name}" src="%{base}/imgs/player/${c.image}"></td>
			<td align="center">${c.name}<br/> Level ${c.level}</td>
			<td colspan="3">
			<table>
				<tr>
					<td><img src="%{base}/imgs/web/lp.png" alt="Life Points" title="Life Points"></td>
					<td><input readonly="readonly" type="text" size=8" value="${c.basePl}" /></td>
					<td><img src="%{base}/imgs/web/mp.png" alt="Magic Points" title="Magic Points"></td>
					<td><input readonly="readonly" type="text" size=8" value="${c.basePm}" /></td>
					<td><img src="%{base}/imgs/web/ap.png" alt="Action Points" title="Action Points"></td>
					<td><input readonly="readonly" type="text" size=8" value="${c.basePa}" /></td>
					<td><img src="%{base}/imgs/web/cp.png" alt="Charm Points" title="Charm Points"></td>
					<td><input readonly="readonly" type="text" size=8" value="${c.basePc}" /></td>
					<td><img src="%{base}/imgs/web/gp.png" alt="Gold" title="Gold"></td>
					<td><input readonly="readonly" type="text" size=8" value="${c.gold}" /></td>
					<td><img src="%{base}/imgs/web/px.png" alt="Experience Points" title="Experience Points"></td>
					<td><input readonly="readonly" type="text" size=8" value="${c.px}" /></td>
				</tr>
				<tr>
					<td><img src="%{base}/imgs/web/str.png" alt="Strenght" title="Strenght"></td>
					<td><input readonly="readonly" type="text" size=8" value="${c.baseStr}" /></td>
					<td><img src="%{base}/imgs/web/int.png" alt="Intelligence" title="Intelligence"></td>
					<td><input readonly="readonly" type="text" size=8" value="${c.baseInt}" /></td>
					<td><img src="%{base}/imgs/web/dex.png" alt="Dexterity" title="Dexterity"></td>
					<td><input readonly="readonly" type="text" size=8" value="${c.baseDex}" /></td>
					<td><img src="%{base}/imgs/web/cha.png" alt="Charisma" title="Charisma"></td>
					<td><input readonly="readonly" type="text" size=8" value="${c.baseCha}" /></td>
					<td><img src="%{base}/imgs/web/area.png" alt="Area" title="Area"></td>
					<td colspan="3"><input readonly="readonly" type="text" size="20" value="${c.areaItem.name}" /></td>
				</tr>
			</table>
			
			</td>
			<td><button onclick="javascript:goplay('${c.name}')">Play</button></td>
		</tr>
		<tr><td colspan=6" align="center"><hr width="90%"/></td></tr>
		
	</#list>

	<form name="newchar" method="POST" action="%{base}/newChar" enctype="multipart/form-data">	
		<tr>
		<td><img class="avatar" alt="No Character" src="%{base}/imgs/player/pg_void.png"></td>
		<td>Character Name</td>
		<td><input type="text" name="new_name" /></td>
		<td>Character Picture</td>
		<td><input type="file" name="new_pic" /></td>
		<td><input type="submit" /></td>
	</tr>
	</form>
</table>


</div>
</div>

</center>

<form  name="start" action="%{base}/start" method="post">
<input type="hidden" value="" name="chname">
</form>

<script type="text/javascript">
function goplay(name){
	document.forms.start.chname.value = name;
	document.forms.start.submit();
}

</script>

</body>

</html>