<#if s?exists && !grid>
{
	"s_id":"${s.id?string("0")}",
	"s_name":"${s.name}",
	"s_description":"${s.description?j_string}",
	"s_image":"${s.image}",
	"s_costMp":"${s.costMp?string("0")}",
	"s_price":"${s.price?string("0")}",
	"s_reqLev":"${s.reqLev?string("0")}",
	"s_level":"${s.level?string("0")}",
	"s_duration":"${s.duration?string("0")}",
	"s_initiative":"${s.initiative?string("0")}",
	"s_damage":"${s.damage}",
	"s_savingthrow":"${s.savingthrow?string("0")}",
	"s_spelltype":"${s.spelltype?string("0")}",
	"s_reqStr":"${s.reqStr?string("0")}",
	"s_reqInt":"${s.reqInt?string("0")}",
	"s_reqDex":"${s.reqDex?string("0")}",
	"s_reqCha":"${s.reqCha?string("0")}",
	"s_modStr":"${s.modStr?string("0")}",
	"s_modInt":"${s.modInt?string("0")}",
	"s_modDex":"${s.modDex?string("0")}",
	"s_modCha":"${s.modCha?string("0")}"
}
<#elseif spells?exists && grid>

{
	"page":"1",
	"total":"1",
	"records":"${spells?size}",
	"rows":[
		<#list spells as spell>
		{
			"id":"${spell.id?string("0")}",
			"cell":["<div onclick='loadData(${spell.id?string("0")})' class='iconlarge' style='background-image: url(${pages.IMG_SPELL_PATH}${spell.image}${pages.IMG_SPELL_EXT});'><div class='tile'/></div>","${spell.name}"]
		}<#if !(spell == spells?last)>,</#if>
		</#list>
	]
}
<#else>
"error"
</#if>