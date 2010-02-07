<#if shoplist?exists >
{
	"page":"1",
	"total":"1",
	"records":"${shoplist?size}",
	"rows":[
		<#list shoplist as item>
		{
"id":"s_${item.id}",
"cell":[
"<img src='${ pages.IMG_ITEM_PATH + item.image + pages.IMG_ITEM_EXT}' width='40'>", 
"${item.name?j_string}",
"<span style='color:<#if item.reqStr &gt; character.strenght>red<#else>green</#if>'>&nbsp;${item.reqStr?string("0")}</span>&nbsp;<img src='${pages.IMG_WEB_PATH}shop/l2.gif'>\
&nbsp;<span style='color:<#if item.reqInt &gt; character.intelligence>red<#else>green</#if>'>&nbsp;${item.reqInt?string("0")}</span>&nbsp;<img src='${pages.IMG_WEB_PATH}shop/m2.gif'>\
<br/><span style='color:<#if item.reqDex &gt; character.dexterity>red<#else>green</#if>'>&nbsp;${item.reqDex?string("0")}</span>&nbsp;<img src='${pages.IMG_WEB_PATH}shop/d2.gif'>\
&nbsp;<span style='color:<#if item.reqCha &gt; character.charisma>red<#else>green</#if>'>&nbsp;${item.reqCha?string("0")}</span>&nbsp;<img src='${pages.IMG_WEB_PATH}shop/c2.gif'>",
"${item.modStr?string("0")}&nbsp;<img src='${pages.IMG_WEB_PATH}shop/l2.gif'>\
&nbsp;${item.modInt?string("0")}&nbsp;<img src='${pages.IMG_WEB_PATH}shop/m2.gif'>\
<br/>${item.modDex?string("0")}&nbsp;<img src='${pages.IMG_WEB_PATH}shop/d2.gif'>\
&nbsp;${item.modCha?string("0")}&nbsp;<img src='${pages.IMG_WEB_PATH}shop/c2.gif'>",
"<span style='color:<#if item.price &gt; character.gold>red<#else>green</#if>'>${item.price?j_string}</span>&nbsp;<img src='${pages.IMG_WEB_PATH}stats/ico/gold.gif' width=20>",
<#if (item.price>character.gold) || (item.reqStr &gt; character.strenght) || (item.reqInt &gt; character.intelligence) || (item.reqDex &gt; character.dexterity) || (item.reqCha &gt; character.charisma) >
"<img src='${pages.IMG_WEB_PATH}shop/nobuy.gif' alt='Buy' title='Buy' onclick='nobuy()' >"
<#else>
"<img src='${pages.IMG_WEB_PATH}shop/buy.gif' alt='Buy' title='Buy' onclick='<#if isspell>learn<#else>buy</#if>(${item.id})' >"
</#if>
			]
		}<#if !(item == shoplist?last)>,</#if>
		</#list>
	]
}
</#if>

<#if playerlist?exists>
{
	"page":"1",
	"total":"1",
	"records":"${playerlist?size}",
	"rows":[
		<#list playerlist as poi>
		{
			"id":"p_${poi.id}",
			"cell":[
			"<img src='${ pages.IMG_ITEM_PATH + poi.item.image + pages.IMG_ITEM_EXT}' width='40'>", 
		 	"${poi.item.name?j_string}",
		 	"<span style='color:<#if poi.item.reqStr &gt; character.strenght>red<#else>green</#if>'>&nbsp;${poi.item.reqStr?string("0")}</span>&nbsp;<img src='${pages.IMG_WEB_PATH}shop/l2.gif'>\
&nbsp;<span style='color:<#if poi.item.reqInt &gt; character.intelligence>red<#else>green</#if>'>&nbsp;${poi.item.reqInt?string("0")}</span>&nbsp;<img src='${pages.IMG_WEB_PATH}shop/m2.gif'>\
<br/><span style='color:<#if poi.item.reqDex &gt; character.dexterity>red<#else>green</#if>'>&nbsp;${poi.item.reqDex?string("0")}</span>&nbsp;<img src='${pages.IMG_WEB_PATH}shop/d2.gif'>\
&nbsp;<span style='color:<#if poi.item.reqCha &gt; character.charisma>red<#else>green</#if>'>&nbsp;${poi.item.reqCha?string("0")}</span>&nbsp;<img src='${pages.IMG_WEB_PATH}shop/c2.gif'>",
"${poi.item.modStr?string("0")}&nbsp;<img src='${pages.IMG_WEB_PATH}shop/l2.gif'>\
&nbsp;${poi.item.modInt?string("0")}&nbsp;<img src='${pages.IMG_WEB_PATH}shop/m2.gif'>\
<br/>${poi.item.modDex?string("0")}&nbsp;<img src='${pages.IMG_WEB_PATH}shop/d2.gif'>\
&nbsp;${poi.item.modCha?string("0")}&nbsp;<img src='${pages.IMG_WEB_PATH}shop/c2.gif'>",
		 	"${(poi.item.price/2)?j_string}&nbsp;<img src='${pages.IMG_WEB_PATH}stats/ico/gold.gif' width=20>",
		 	"<img src='${pages.IMG_WEB_PATH}shop/sell.gif' alt='Sell' title='Sell' onclick='sell(${poi.id})'>"
			]
		}<#if !(poi == playerlist?last)>,</#if>
		</#list>
	]
}
</#if>