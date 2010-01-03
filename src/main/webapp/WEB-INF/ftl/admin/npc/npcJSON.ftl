<#if n?exists && !grid>
{
	"n_id":"${n.id?string("0")}",
	"n_name":"${n.name?j_string}",
	"n_image":"${n.image}",
	"n_description":"${n.description?j_string}",
	"n_baseStr":"${n.baseStr?string("0")}",
	"n_baseInt":"${n.baseInt?string("0")}",
	"n_baseDex":"${n.baseDex?string("0")}",
	"n_baseCha":"${n.baseCha?string("0")}",
	"n_basePl":"${n.basePl?string("0")}",
	"n_basePm":"${n.basePm?string("0")}",
	"n_basePa":"${n.basePa?string("0")}",
	"n_basePc":"${n.basePc?string("0")}",
	"n_level":"${n.level?string("0")}",
	"n_px":"${n.px?string("0")}",
	"n_status":"${n.status?string("0")}",
	"n_gold":"${n.gold?string("0")}",
	"n_nitem":"${n.nitem?string("0")}",
	"n_dialog":"${n.dialog}",
	"n_areatype":"${n.areatype?string("0")}",
	"n_nattack":"${n.nattack?string("0")}",
	"n_attack":"${n.attack}",
	"n_ismonster":${n.ismonster?string},
	"n_useArm":${n.useArm?string},
	"n_useShld":${n.useShld?string},
	"n_useWpn":${n.useWpn?string}
}
<#elseif npcs?exists && grid>

{
	"page":"1",
	"total":"1",
	"records":"${npcs?size}",
	"rows":[
		<#list npcs as npc>
		{
			"id":"${npc.id?string("0")}",
			"cell":["<div onclick='loadData(${npc.id?string("0")})'><img width='64' src='${imgpath + npc.image + imgext}'></div>","${npc.name?j_string}"]
		}<#if !(npc == npcs?last)>,</#if>
		</#list>
	]
}
<#else>
"error"
</#if>