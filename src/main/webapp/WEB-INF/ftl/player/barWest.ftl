<style type="text/css">
	.ui-progressbar { position:relative;height:10px; }
	.pblabel { position: absolute; width: 100%; text-align: center; font-size:8px;font-weight:bold; }
	#bar_life .ui-widget-header{ background: #E44F57; }
	#bar_mana .ui-widget-header{ background: #3F6DB5; }
	#bar_action .ui-widget-header{ background:#E4B64F; }
	#bar_charm .ui-widget-header{ background: #B345BA; }
	#bar_xp .ui-widget-header{ background: #0486E6; }
</style>


<table style="margin-left:3px;">
	<tr>
		<td>
			<div class="ui-corner-all" style="border:2px solid lightgray" >
				<img alt="No Character" width="100" height="100" class="avatar"	src="${pages.IMG_PC_PATH}${Session.character.pic}">
			</div>
		</td>
		<td>
		
			<table>
				<tr>
					<td>${Session.character.name}<br/>Level ${Session.character.level}</td>
				</tr>
				<tr>
					<td>
						<div id="bar_life">
							<span class="pblabel">
								${Session.character.pointsLife} / ${Session.character.pointsLifeMax}
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div id="bar_mana">
							<span class="pblabel">
								${Session.character.pointsMagic} / ${Session.character.pointsMagicMax}
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div id="bar_action">
							<span class="pblabel">
								${Session.character.pointsAction} / ${Session.character.pointsActionMax}
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div id="bar_charm">
							<span class="pblabel">
								${Session.character.pointsCharm} / ${Session.character.pointsCharmMax}
							</span>
						</div>
					</td>
				</tr>
				
			</table>
			
		</td>
	</tr>
	<tr>
		<td colspan=2>
			<div id="bar_xp">
				<span class="pblabel">
					${Session.character.experience} / ${Session.character.nextExperience}
				</span>
			</div>
		</td>
	</tr>
</table>

<center>

<table>
	<tr>
		<td colspan="2" align="center" class="smallfont" id="reg">
			<#if Session.character.nexRegenereationTime?int&gt;0 >
	 		 Regenerate in <span id="regtime2"></span><span style="display:none" id="regtime1">${Session.character.nexRegenereationTime?string("0")}</span>
	 		</#if>
		</td>
	</tr> 
	<tr>
		<td class="ui-state-default ui-corner-all" width="50%" valign="middle" align="center">
			<a href="${rc.getContextPath()}${pages.PAGE_MAP}${pages.PAGE_EXT}" >
				<img height="50px" src="${pages.IMG_WEB_PATH}admin/maps.gif" alt="Map" title="Map" border="0">
			</a>
		</td>
		<td class="ui-state-default ui-corner-all" valign="middle" align="center">
			<a href="${rc.getContextPath()}${pages.PAGE_EQUIP}${pages.PAGE_EXT}" >
				<img height="50px" src="${pages.IMG_WEB_PATH}admin/equip.gif" alt="Equipment" title="Equipment" border="0">
			</a>
		</td>
	</tr>
	<tr>
		<td class="ui-state-default ui-corner-all"  valign="middle" align="center">
			<a href="${rc.getContextPath()}${pages.PAGE_SPELL}${pages.PAGE_EXT}" >
				<img height="50px" src="${pages.IMG_WEB_PATH}admin/spells.gif" alt="Spell Book" title="Spell Book" border="0">
			</a>
		</td>
		<td class="ui-state-default ui-corner-all" valign="middle" align="center" >
			<a href="${rc.getContextPath()}${pages.PAGE_BATTLEPLAN}${pages.PAGE_EXT}" >
				<img height="50px" src="${pages.IMG_WEB_PATH}admin/battle.gif" alt="Battle Strategy" title="Battle Strategy" border="0">
			</a>
		</td>
	</tr>
	<tr>
		<td class="ui-state-default ui-corner-all" valign="middle" align="center" >
			<a href="${rc.getContextPath()}${pages.PAGE_STATUS}${pages.PAGE_EXT}" >
				<img height="50px" src="${pages.IMG_WEB_PATH}admin/stats.gif" alt="Status" title="Status" border="0">
			</a>
		</td>
		<td class="ui-state-default ui-corner-all" valign="middle" align="center" >
			<a href="javascript:alert('TODO')" >
				<img height="50px" src="${pages.IMG_WEB_PATH}admin/quests.gif" alt="Quests" title="Quests" border="0">
			</a>
		</td>
	</tr>
	<tr>
		<td class="ui-state-default ui-corner-all" valign="middle" align="center" >
			<a href="javascript:alert('TODO')" >
				<img height="50px" src="${pages.IMG_WEB_PATH}admin/messages.gif" alt="Messages" title="Messages" border="0">
			</a>
		</td>
		<td></td>
	</tr>
</table>

</center>


<table  align="center" >
	



	<tr>
		<td><img src="${pages.IMG_WEB_PATH}stats/ico/str.gif" alt="Strenght" title="Strenght"></td>
		<td><input type="text" size="2" readonly="readonly" value="${Session.character.strenght}"
			style="text-align: right;" /></td>
	
		<td><img src="${pages.IMG_WEB_PATH}stats/ico/int.gif" alt="Intelligence" title="Intelligence"></td>
		<td><input type="text" size="2" readonly="readonly" value="${Session.character.intelligence}"
			style="text-align: right;" /></td>
	</tr>

	<tr>
		<td><img src="${pages.IMG_WEB_PATH}stats/ico/dex.gif" alt="Dexterity" title="Dexterity"></td>
		<td><input type="text" size="2" readonly="readonly" value="${Session.character.dexterity}"
			style="text-align: right;" /></td>
	
		<td><img src="${pages.IMG_WEB_PATH}stats/ico/cha.gif" alt="Charisma" title="Charisma"></td>
		<td><input type="text" size="2" readonly="readonly" value="${Session.character.charisma}"
			style="text-align: right;" /></td>
	</tr>
	
	<tr>
		<td><img src="${pages.IMG_WEB_PATH}stats/ico/ac.gif" alt="Armor Class" title="Armor Class"></td>
		<td><input type="text" size="2" readonly="readonly" value="${Session.character.totalCA}"
			style="text-align: right;" /></td>
	
		<td><img src="${pages.IMG_WEB_PATH}stats/ico/gold.gif" alt="Gold" title="Gold"></td>
		<td><input type="text" size="2" readonly="readonly" value="${Session.character.gold}" style="text-align: right;" /></td>
	</tr>

</table>

<script>

$("#bar_life").progressbar({	value: ${ ((100 * Session.character.pointsLife ) / Session.character.pointsLifeMax )?int} });
$("#bar_mana").progressbar({	value: ${ ((100 * Session.character.pointsMagic ) / Session.character.pointsMagicMax )?int} });
$("#bar_action").progressbar({	value: ${ ((100 * Session.character.pointsAction?float ) / Session.character.pointsActionMax )?int} });
$("#bar_charm").progressbar({	value: ${ ((100 * Session.character.pointsCharm ) / Session.character.pointsCharmMax )?int} });
$("#bar_xp").progressbar({	value: ${ (100 * Session.character.experience / Session.character.nextExperience)?int} });


el = document.getElementById("regtime1");
if(el){
	mil = parseInt(el.innerHTML);
	setInterval ( "formatRegTime()", 1000 );
}


function formatRegTime(){
	
	el = document.getElementById("regtime1");
	if(el){
		var mm = Math.floor(mil / (1000*60));
		var ss = Math.floor((mil - mm* (1000*60))/1000);

		if(ss<10) ss = "0"+ss;

		document.getElementById("regtime2").innerHTML = mm + ":" + ss;
		mil -= 1000;

		if(mil <= 0){
			document.getElementById("reg").innerHTML = "<a href=\"javascript:document.location=document.location.pathname\">Reload</a>";
		}
	
	}
}

</script>
