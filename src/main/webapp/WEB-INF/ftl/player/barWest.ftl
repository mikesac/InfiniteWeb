<style type="text/css">
	.ui-progressbar { position:relative; }
	.pblabel { position: absolute; width: 100%; text-align: center; line-height: 1.9em; }
	#bar_life .ui-widget-header{ background: #E44F57; }
	#bar_mana .ui-widget-header{ background: #3F6DB5; }
	#bar_action .ui-widget-header{ background:#E4B64F; }
	#bar_charm .ui-widget-header{ background: #B345BA; }
</style>

<!-- c = Character.checkForRegeneration(c); -->

<table  align="center" >
	<tr>
		<td align="center" colspan="2">
		
		<div class="ui-dialog ui-widget ui-widget-content ui-corner-all" style="width:130px;">
			<div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix" >
				<span class="ui-dialog-title">${Session.character.name}</span>
			</div>
			<div class="ui-dialog-content ui-widget-content">
				<img alt="No Character" width="100" height="100" class="avatar"	src="${rc.getContextPath()}/imgs/player/${Session.character.pic}">
				<span>Level ${Session.character.level}</span>
			</div>
		</div>
	
		</td>
	</tr>

	<tr>
		<td align="right">
			<img src="${rc.getContextPath()}/imgs/web/stats/ico/life.gif" alt="Life Points" title="Life Points">
		</td>
		<td>
			<div id="bar_life">
				<span class="pblabel">
					${Session.character.pointsLife} / ${Session.character.pointsLifeMax}
				</span>
			</div>
		</td>
	</tr>
	<tr>
		<td align="right"><img src="${rc.getContextPath()}/imgs/web/stats/ico/mana.gif"
			alt="Magic Points" title="Magic Points"></td>
		<td>
		<div id="bar_mana">
				<span class="pblabel">
					${Session.character.pointsMagic} / ${Session.character.pointsMagicMax}
				</span>
		</div>
		</td>
	</tr>
	<tr>
		<td align="right"><img src="${rc.getContextPath()}/imgs/web/stats/ico/action.gif"
			alt="Action Points" title="Action Points"></td>
		<td>
		<div id="bar_action">
				<span class="pblabel">
					${Session.character.pointsAction} / ${Session.character.pointsActionMax}
				</span>
		</div>
		</td>
	</tr>
	<tr>
		<td align="right"><img src="${rc.getContextPath()}/imgs/web/stats/ico/charm.gif"
			alt="Charm Points" title="Charm Points"></td>
		<td>
		<div id="bar_charm"><div id="bar_action">
				<span class="pblabel">
					${Session.character.pointsCharm} / ${Session.character.pointsCharmMax}
				</span>
		</div>
		</td>
	</tr>

<#if Session.character.nexRegenereationTime?int!=0 >
	 
	 <tr><td colspan="2" align="center" class="smallfont" id="reg">Regenerate in <span id="regtime2"></span><span style="display:none" id="regtime1">
	 ${Session.character.nexRegenereationTime?string("0")}
	 </span></td></tr> 
	 </#if>

	<tr>
		<td><img src="${rc.getContextPath()}/imgs/web/stats/ico/str.gif" alt="Strenght" title="Strenght"></td>
		<td><input type="text" size="10" readonly="readonly" value="${Session.character.strenght}"
			style="text-align: right;" /></td>
	</tr>

	<tr>
		<td><img src="${rc.getContextPath()}/imgs/web/stats/ico/int.gif" alt="Intelligence" title="Intelligence"></td>
		<td><input type="text" size="10" readonly="readonly" value="${Session.character.intelligence}"
			style="text-align: right;" /></td>
	</tr>

	<tr>
		<td><img src="${rc.getContextPath()}/imgs/web/stats/ico/dex.gif" alt="Dexterity" title="Dexterity"></td>
		<td><input type="text" size="10" readonly="readonly" value="${Session.character.dexterity}"
			style="text-align: right;" /></td>
	</tr>

	<tr>
		<td><img src="${rc.getContextPath()}/imgs/web/stats/ico/cha.gif" alt="Charisma" title="Charisma"></td>
		<td><input type="text" size="10" readonly="readonly" value="${Session.character.charisma}"
			style="text-align: right;" /></td>
	</tr>
	
	<tr>
		<td><img src="${rc.getContextPath()}/imgs/web/stats/ico/ac.gif" alt="Armor Class" title="Armor Class"></td>
		<td><input type="text" size="10" readonly="readonly" value="${Session.character.totalCA}"
			style="text-align: right;" /></td>
	</tr>
	<tr>
		<td><img src="${rc.getContextPath()}/imgs/web/stats/ico/px.gif" alt="Experience" title="Experience"></td>
		<td><input type="text" size="10" readonly="readonly" value="${Session.character.experience}"
			style="text-align: right;" /></td>
	</tr>
	<tr>
		<td><img src="${rc.getContextPath()}/imgs/web/stats/ico/gold.gif"
			alt="Gold" title="Gold"></td>
		<td><input type="text" size="10" readonly="readonly" value="${Session.character.gold}"
			style="text-align: right;" /></td>
	</tr>

</table>

<script>

$("#bar_life").progressbar({	value: ${ ((100 * Session.character.pointsLife ) / Session.character.pointsLifeMax )?int} });
$("#bar_mana").progressbar({	value: ${ ((100 * Session.character.pointsMagic ) / Session.character.pointsMagicMax )?int} });
$("#bar_action").progressbar({	value: ${ ((100 * Session.character.pointsAction?float ) / Session.character.pointsActionMax )?int} });
$("#bar_charm").progressbar({	value: ${ ((100 * Session.character.pointsCharm ) / Session.character.pointsCharmMax )?int} });



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
