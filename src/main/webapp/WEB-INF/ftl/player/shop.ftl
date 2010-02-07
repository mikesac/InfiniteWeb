<html>
<head>
<title>Shop</title>
</head>
<body>
<table>
	<tr>
		<td colspan=2>
			<table width="100%">
				<td style="border:3px double #684331;" align="center"><img src="${pages.IMG_NPC_PATH + npc.image + pages.IMG_NPC_EXT}" /></td>
				<td>
					Welcome to my shop!<br />
					Remember that your charisma will influence the prices and that all requirements are evaluated on your <b>base</b> attributes.<br />
					Player's Charisma: <span style="color:#9800F0;font-weight: bold;">${character.charisma}</span> VS 
					Merchant's Charisma: <span style="color:red;font-weight: bold;">${npc.baseCha}</span><br/>
					Price adjustment: ${ (100 * npc.baseCha) / character.charisma }% (price are shown without adjustment)
				</td>
				<td align="right"><img src="../imgs/web/shop/shop.gif" /></td>
			</table>
		</td>
	</tr>
	<tr>
		<td valign="top" align="center">
			<table id="shopgrid"></table>
		</td>
		<td valign="top" align="center">
			<table id="playgrid" class="scroll"></table>
		</td>
	</tr>
</table>

<form name="shop" method="post" action="${rc.getContextPath() + pages.PAGE_SHOP + pages.PAGE_EXT}">
<input type="hidden" name=act value="-1"/>
<input type="hidden" name="it" value="-1"/>
</form>




<script type="text/javascript" src="../js/jquery/grid/jquery.jqGrid.min.js"></script>
<link rel="stylesheet" type="text/css" href="../js/jquery/grid/ui.jqgrid.css">
<style>
	th{font-size:small;}
	.ui-jqgrid tr.jqgrow td {font-size:small;}
</style>
<script>

function onload()
{
var play = jQuery("#playgrid").jqGrid({
		 url:"${rc.getContextPath() + pages.PAGE_SHOP}.json?t=0", 
		 datatype: "json", 
		 forceFit:true,
		 loadtext:"Loading...",
		 hidegrid:false,
		 height: 380, 
		 caption: "Your Item",
		 colModel:[ 
		 	{width:42,label:'Icon',sortable:false,resizable:false,align:"center"}, 
		 	{width:220,label:'Name',sorttype:"string",resizable:false}, 
		 	{width:80,label:'Require',sorttype:"string",resizable:false,align:"right"},
		 	{width:80,label:'Provide',sorttype:"string",resizable:false,align:"right"},
		 	{width:80,label:'Price',sorttype:"string",resizable:false,align:"right"},
		 	{width:50,label:'&nbsp;',sorttype:"string",resizable:false}
		 	]
		  });
	var shop = jQuery("#shopgrid").jqGrid({
		 url:"${rc.getContextPath() + pages.PAGE_SHOP}.json?t=1", 
		 datatype: "json", 
		 loadtext:"Loading...",
		 hidegrid:false,
		 height: 380,
		 rowNum:-1,
		 caption: "Shop Item",
		 colModel:[ 
		 	{width:42,label:'Icon',sortable:false,resizable:false,align:"center"}, 
		 	{width:220,label:'Name',sorttype:"string",resizable:false}, 
		 	{width:80,label:'Require',sorttype:"string",resizable:false,align:"right"},
		 	{width:80,label:'Provide',sorttype:"string",resizable:false,align:"right"},
		 	{width:80,label:'Price',sorttype:"string",resizable:false,align:"right"},
		 	{width:50,label:'&nbsp;',sorttype:"string",resizable:false}
		 	]
		 });
		
	
		 
}

function buy(id){
	document.forms['shop'].elements['act'].value=${act_buy};
	document.forms['shop'].elements['it'].value=id;
	document.forms['shop'].submit();
}

function sell(id){
	document.forms['shop'].elements['act'].value=${act_sell};
	document.forms['shop'].elements['it'].value=id;
	document.forms['shop'].submit();
}

function learn(id){
	document.forms['shop'].elements['act'].value=${act_learn};
	document.forms['shop'].elements['it'].value=id;
	document.forms['shop'].submit();
}

function nobuy(id){
	alert("You cannot buy this item, requirements not met!")
}
</script>
</body>
</html>