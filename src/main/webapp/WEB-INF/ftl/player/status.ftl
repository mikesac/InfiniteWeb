<html>
<head>
<title>Player Status</title>
</head>
<body>

<style>
.smallfont{font-size: 8pt;}
.ui-progressbar { position:relative; }
.pblabel { position: absolute; width: 100%; text-align: center; line-height: 1.9em; }
#bar_xp .ui-widget-header{ background: #0486E6; }
</style>

<div style="width: 1020px;">

<table cellpadding="5">
	
			<tr>
				<th colspan="2">Type</th>
				<th>Base</th>
				<th>Mod</th>
				<th>&nbsp;</th>
				<th colspan="2">Type</th>
				<th>Base</th>
				<th>Mod</th>
				<th>&nbsp;</th>
			</tr>
			
			
			<tr>
				<td>
				<div class="iconlarge"
					style="background-image: url(${pages.IMG_WEB_PATH}stats/life.png);">
				<div class="tile" />
				</div>
				</td>
				<td><p style="color:#B80701">Life Points (LP)</p>
				<p class="smallfont">Life points represents the amount of damage you can get from enemies before being defeated.</p>
				</td>
				<td>${character.pointsLifeBase}</td>
				<td>${character.pointsLifeMax - character.pointsLifeBase}</td>
				<td>
					<#if up >
						<a href="javascript:doUpgrade(${PL})"><img border=0 src="${pages.IMG_WEB_PATH}stats/plus.png" alt="Increment this skill" title="Increment this skill"/></a>
					<#else>
						&nbsp;
					</#if>
				</td>
				<td>
				<div class="iconlarge" style="background-image: url(${pages.IMG_WEB_PATH}stats/str.png);">
				<div class="tile" /></div>
				</td>
				<td><p style="color:#B80701">Strength (STR)</p>
					<p class="smallfont">Strength represent your player constitution and ability to inflict damage. Increasing your strength will give you bonus on hit and damage roll in melee fight and increase your LP</p>
				</td>
				<td>${character.dao.baseStr}</td>
				<td>${character.strenght - character.dao.baseStr}</td>
				<td> 
					<#if up >
						<a href="javascript:doUpgrade(${STR})"><img border=0 src="${pages.IMG_WEB_PATH}stats/plus.png" alt="Increment this skill" title="Increment this skill"/></a>
					<#else>
						&nbsp;
					</#if>
				</td>
			</tr>
			
			
			<tr>
				<td>
				<div class="iconlarge" style="background-image: url(${pages.IMG_WEB_PATH}stats/mana.png);">
				<div class="tile" /></div>
				</td>
				<td><p style="color:#1B1DDF">Magic Points (MP)</p>
				<p class="smallfont">Magic points determines the amount of magic spell you can cast. If you try to cast a spell with insufficient MP the spell will fail</p>
				</td>
				<td>${character.pointsMagicBase}</td>
				<td>${character.pointsMagicMax - character.pointsMagicBase}</td>
				<td> 
					<#if up ><a href="javascript:doUpgrade(${PM})"><img border=0 src="${pages.IMG_WEB_PATH}stats/plus.png" alt="Increment this skill" title="Increment this skill"/></a>
						<#else>
						&nbsp;
					</#if>
				</td>
				<td>
				<div class="iconlarge"
					style="background-image: url(${pages.IMG_WEB_PATH}stats/int.png);">
				<div class="tile" /></div>
				</td>
				<td><p style="color:#1B1DDF">Intelligence (INT)</p>
					<p class="smallfont">Intelligence is your character acknowledge of the mysteries of the world and its rules and it's the door to magic. Increasing you intelligence will enhance you ability to cast spell and your MP</p>
				</td>
				<td>${character.dao.baseInt}</td>
				<td>${character.intelligence - character.dao.baseInt}</td>
				<td> 
					<#if up ><a href="javascript:doUpgrade(${INT})"><img border=0 src="${pages.IMG_WEB_PATH}stats/plus.png" alt="Increment this skill" title="Increment this skill"/></a>
						<#else>
						&nbsp;
					</#if>
				</td>
			</tr>
			
			
			<tr>
				<td>
				<div class="iconlarge"
					style="background-image: url(${pages.IMG_WEB_PATH}stats/action.png);">
				<div class="tile" /></div>
				</td>
				<td><p style="color:#CFA80C">Action Points (AP)</p>
				<p class="smallfont">Action point gives you mobility. Any action you perform (moving, fighting,etc) will consume AP, once terminated you will have to rest before moving again.</p>
				</td>
				<td>${character.pointsActionBase}</td>
				<td>${character.pointsActionMax - character.pointsActionBase}</td>
				<td> 
					<#if up ><a href="javascript:doUpgrade(${PA})"><img border=0 src="${pages.IMG_WEB_PATH}stats/plus.png" alt="Increment this skill" title="Increment this skill"/></a>
						<#else>
						&nbsp;
					</#if>
				</td>
				<td>
				<div class="iconlarge"
					style="background-image: url(${pages.IMG_WEB_PATH}stats/dex.png);">
				<div class="tile" /></div>
				</td>
				<td><p style="color:#CFA80C">Dexterity (DEX)</p>
					<p class="smallfont">Dexterity is your attitude to move fast and carefully, it will influence your reflex and your efficiency in battle. Increasing dexterity will bring you more AP to performed any desired action.</p>
				</td>
				<td>${character.dao.baseDex}</td>
				<td>${character.dexterity - character.dao.baseDex}</td>
				<td> 
					<#if up ><a href="javascript:doUpgrade(${DEX})"><img border=0 src="${pages.IMG_WEB_PATH}stats/plus.png" alt="Increment this skill" title="Increment this skill"/></a>
						<#else>
						&nbsp;
					</#if>
				</td>
			</tr>
			
			
			<tr>
				<td>
				<div class="iconlarge"
					style="background-image: url(${pages.IMG_WEB_PATH}stats/charm.png);">
				<div class="tile" /></div>
				</td>
				<td><p style="color:#9800F0">Charm Points (CP)</p>
				<p class="smallfont">Charm points represents your smartness and your ability to trade.You can use them to teke advantage over shopkeepers or other players</p>
				</td>
				<td>${character.pointsCharmBase}</td>
				<td>${character.pointsCharmMax - character.pointsCharmBase}</td>
				<td> 
					<#if up ><a href="javascript:doUpgrade(${PC})"><img border=0 src="${pages.IMG_WEB_PATH}stats/plus.png" alt="Increment this skill" title="Increment this skill"/></a>
						<#else>
						&nbsp;
					</#if>
				</td>
				<td>
				<div class="iconlarge"
					style="background-image: url(${pages.IMG_WEB_PATH}stats/cha.png);">
				<div class="tile" /></div>
				</td>
				<td><p style="color:#9800F0">Charisma (CHA)</p>
					<p class="smallfont">Charisma is your ability to seduce people with your tales and to think in a different way than anybody else. It won't help you in meelee fight but will let you find a shortcut to defeat your enemy without having to face him.</p>
				</td>
				<td>${character.dao.baseCha}</td>
				<td>${character.charisma - character.dao.baseCha}</td>
				<td> 
					<#if up ><a href="javascript:doUpgrade(${CHA})"><img border=0 src="${pages.IMG_WEB_PATH}stats/plus.png" alt="Increment this skill" title="Increment this skill"/></a>
						<#else>
						&nbsp;
					</#if>
				</td>
			</tr>
	
	
			<tr>
				<td>
				<div class="iconlarge"
					style="background-image: url(${pages.IMG_WEB_PATH}stats/px.png);">
				<div class="tile" /></div>
				</td>
				<td colspan="3">
					<p style="color:#0486E6">Experience Points (XP)</p>
					<p class="smallfont">Experience Pints represent the progress of your character, once the bar is filled you will level up.</p>
					
					<div id="bar_xp">
						<span class="pblabel">
							${curr_xp} / ${next_xp}
						</span>
					</div>
					
				</td>
				<td></td>
				<td></td>
				<td>Points still to assign: ${character.dao.assign}</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
	
		</table>

</div>

<#if up >
	<form name="upgrade" method="POST" action="${rc.getContextPath() + pages.PAGE_STATUS + pages.PAGE_EXT}">
		<input type="hidden" name="attType">
	</form>
	
	<script>
	function doUpgrade(type){
		document.forms['upgrade'].attType.value=type;
		document.forms['upgrade'].submit();
	}
	</script>	
</#if>

<script>
	$("#bar_xp").progressbar({	value: ${ (100 * curr_xp / next_xp)?int} });
</script>

</body>
</html>