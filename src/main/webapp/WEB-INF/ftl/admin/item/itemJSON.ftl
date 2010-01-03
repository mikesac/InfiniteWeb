<#if i?exists && !grid>
{
	"i_id":"${i.id?string("0")}",
	"i_name":"${i.name}",
	"i_description":"${i.description?j_string}",
	"i_image":"${i.image}",
	"i_costAp":"${i.costAp?string("0")}",
	"i_reqStr":"${i.reqStr?string("0")}",
	"i_reqInt":"${i.reqInt?string("0")}",
	"i_reqDex":"${i.reqDex?string("0")}",
	"i_reqCha":"${i.reqCha?string("0")}",
	"i_reqLev":"${i.reqLev?string("0")}",
	"i_modStr":"${i.modStr?string("0")}",
	"i_modInt":"${i.modInt?string("0")}",
	"i_modDex":"${i.modDex?string("0")}",
	"i_modCha":"${i.modCha?string("0")}",
	"i_price":"${i.price?string("0")}",
	"i_level":"${i.level?string("0")}",
	"i_spell":"${i.spell?string("0")}",
	"i_damage":"${i.damage}",
	"i_initiative":"${i.initiative?string("0")}",
	"i_durability":"${i.durability?string("0")}",
	"i_type":"${i.type?string("0")}"
}
<#elseif items?exists && grid>

{
	"page":"1",
	"total":"1",
	"records":"${items?size}",
	"rows":[
		<#list items as item>
		{
			"id":"${item.id?string("0")}",
			"cell":["<div onclick='loadData(${item.id?string("0")})' class='iconlarge' style='background-image: url(${pages.IMG_ITEM_PATH}${item.image}${pages.IMG_ITEM_EXT});'><div class='tile'/></div>","${item.name}"]
		}<#if !(item == items?last)>,</#if>
		</#list>
	]
}
<#else>
"error"
</#if>