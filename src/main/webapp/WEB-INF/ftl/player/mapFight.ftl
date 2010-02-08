<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Fight Report</title>
</head>
<body>

<div style="width:980px; height:500px;overflow: auto;padding: 1% 1% 1% 1%;">
<div>
	<center>
	<table>
		<tr>
			<td width="390" align="right">
				
				<table>
					<tr>
					<#list fight_report_s1 as side>
						<td align="center">
							<img style="border:1px outset gray;" width="100px" height="100px" src="<#if side.monster>${pages.IMG_MONST_PATH}<#else>${pages.IMG_PC_PATH}</#if>${side.pic}" alt="${side.pic}" title="${side.pic}" />					
							<br/>${side.name}
						</td>
					</#list>
					</tr>
				</table>
			 	
			</td>
			<td width="200"  align="center">
				<img width="100px" src="${pages.IMG_WEB_PATH}home/play.gif" alt="VS"/>
			</td>
			<td width="390" align="left">
				
				<table>
					<tr>
					<#list fight_report_s2 as side>
						<td align="center">
							<img style="border:1px outset gray;" width="100px" height="100px" src="<#if side.monster>${pages.IMG_MONST_PATH}<#else>${pages.IMG_PC_PATH}</#if>${side.pic}.jpg" alt="${side.pic}" title="${side.pic}" />					
							<br/>${side.name}
						</td>
					</#list>
				 	</tr>
				 </table>
			 	
			</td>
		</tr>
	</table>
	
	
	<table>
		<tr>
			<td style="width:100px; background-repeat:repeat-y; background-image: url(${pages.IMG_WEB_PATH}fight/celcol.gif);"></td>
			<td>
	
	<table>
	
	<#list fight_report as round>
		<tr class="<#if round.spellEffect>firstSide<#else>secondSide</#if>">
			<td nowrap="nowrap">
				<#switch round.roundType>
					<#case type_magic>
						<img width="30px" height="30px" src="${pages.IMG_SPELL_PATH + round.attackImg + pages.IMG_SPELL_EXT}"	alt="${round.attackName}" />
				    <#break>
					<#case type_idle>
						<img width="30px" height="30px" src="${pages.IMG_WEB_PATH}fight/rest.gif" alt="rest" />
				    <#break>
				    <#default>
				    	<#list round.attackImg?split(",") as img>
							<img width="30px" height="30px" src="${pages.IMG_ITEM_PATH + img + pages.IMG_ITEM_EXT}"	alt="${round.attackName}" />
						</#list>
				    <#break>
				</#switch>
			</td>
			<td>
				<img width="30px" height="30px"	src="${pages.IMG_WEB_PATH}fight/<#if round.hit ><#if round.spellEffect>star<#else>ok</#if><#else>error</#if>.gif" alt="Attack result" />
			</td>
			<td>
				<#switch round.roundType>
					<#case type_weapon>
						${round.attacker} attacks ${round.defender} with ${round.attackName}, he rolls 
						<#list round.attackRoll as roll>
						${roll}<#if roll==round.attackRoll?last>,</#if>
						</#list>
						against a CA of ${round.defenderCA}
						<#if round.hit > causing ${round.attackDmg} Hp of damage<#else>, his attack fails!</#if>
				    <#break>
					<#case type_magic>
						<#if round.spellEffect>
							${round.attacker} persist on  ${round.defender}
						<#else>
							${round.attacker} casts  ${round.attackName}
						</#if>
						<#if round.attackType == uncast>
							 but doesn't have enough MP to complete the spell
						<#elseif round.attackType == heal>
							 healing ${round.attackDmg} Hp
						<#else>
							 causing ${round.attackDmg} Hp of damage
						</#if>
				    <#break>
					<#case type_idle>
						${round.attacker} needs to rest, regaining ${round.attackDmg} AP/MP
				    <#break>
				</#switch>
			</td>
		</tr>
		
		<#if round.endRound>
			<tr>
				<td>
					<img width="30px" height="30px"	src="${pages.IMG_WEB_PATH}fight/dead.gif" alt="death" title="death" />
				</td>
				<td colspan="2">
					${round.defender} dies, ${round.attacker} gains	${round.gold} GP, ${round.items?size} items 
					<#list round.items as item>
						<img width="20" title="${item.name}" alt="${item.name}" src="${pages.IMG_ITEM_PATH + item.image?lower_case + pages.IMG_ITEM_EXT}"/>&nbsp;
					</#list>					
					and ${round.px} PX.
				</td>
			</tr>
		
		</#if>
		
		
		
	</#list>
		<tr>
			<td>
				<div class="iconmedium"
					style="background-image: url(../imgs/web/maps/map.png);">
				<div class="tile"><a
					href="${rc.getContextPath() + pages.PAGE_MAP + pages.PAGE_EXT}" ></a></div>
				</div>
			</td>
			<td colspan="2" align="left">Back To Map</td>
		</tr>
	</table>
	
	
	</td>
			<td style="width:100px; background-repeat:repeat-y; background-image: url(${pages.IMG_WEB_PATH}fight/celcol.gif);"></td>
		</tr>
	</table>
	
	</center>
	
</div>
</div>


</body>

</html>