<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Character Equipment</title>
</head>
<body>

<style>
.equipbody{width:500px;height:500px;background-image:url("${pages.IMG_WEB_PATH}equip/equip_bg.gif");background-repeat:no-repeat;}
.equipped{width:70px;height:70px;background-image: url("${pages.IMG_WEB_PATH}equip/bg2.gif");border:3px inset gray;}
</style>

<script type="text/javascript" src="../js/jquery/grid/jquery.jqGrid.min.js"></script>
<link rel="stylesheet" type="text/css" href="../js/jquery/grid/ui.jqgrid.css">
	


<div style="width:1020px;">


<div style="padding: 1% 1% 1% 1%; margin-bottom:30px;">

<table>
	<tr>
		<td class="equipbody">
		<table width="500px" height="500px" border=0>
			<tr style="height: 25%;">
				<td align="center" valign="middle">
				<div class="equipped" id="handleft">
				<#if left?exists>
					<div onclick="unequip(${left.id})" class="iconlarge" style="background-image: url(${pages.IMG_ITEM_PATH}${left.item.image}${pages.IMG_ITEM_EXT});">
						<div class="tile"></div>
					</div>
				</#if>			
				</div>
				</td>
				<td>&nbsp;</td>
				<td align="center" valign="middle">
				<div class="equipped" id="handright">
				<#if right?exists>
					<div onclick="unequip(${right.id})" class="iconlarge" style="background-image: url(${pages.IMG_ITEM_PATH}${right.item.image}${pages.IMG_ITEM_EXT});">
						<div class="tile"/>
					</div>
				</#if>
				</div>
				</td>
			</tr>
			<tr style="height: 25%;">
				<td>&nbsp;</td>
				<td align="center" valign="middle">
				<div class="equipped" id="body">
				<#if body?exists>
					<div onclick="unequip(${body.id})" class="iconlarge" style="background-image: url(${pages.IMG_ITEM_PATH}${body.item.image}${pages.IMG_ITEM_EXT});">
						<div class="tile"/>
					</div>
				</#if>
				</div>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr style="height: 25%;">
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr style="height: 25%;">
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		</td>
		<td>
		
		<table id="pack" class="scroll" cellpadding="0" cellspacing="0"></table>
		</div>
		</td>
	</tr>
</table>
</div></div>


<form name="formequip" action="${rc.getContextPath()}${pages.PAGE_EQUIP}${pages.PAGE_EXT}" method="POST" >
<input type="hidden" name="itemid" value=""/>
<input type="hidden" name="mode" value=""/>
</form>



<script type="text/javascript">
function goEquip(mode,id){
	document.forms['formequip'].elements['itemid'].value=id;
	document.forms['formequip'].elements['mode'].value=mode;
	document.forms['formequip'].submit();
	
}

function equip(id){
	var mode = "${equip}";
	goEquip(mode,id);
}

function unequip(id){
	if( confirm("Do you really want unequip this item?") ){
		var mode = "${unequip}";
		goEquip(mode,id);
	}	
}

function drop(id){	
	if( confirm("Do you really want to drop this item?") ){
		var mode = "${drop}";
		goEquip(mode,id);
	}	
}

function initGrid(){
	jQuery("#pack").jqGrid({
		 datatype: "local", 
		 width:420,
		 forceFit:true,
		 hidegrid:false,
		 height: 500, 
		 colNames:['','Image', 'Name', 'Description','Actions' ], 
		 colModel:[ 
		 	{name:'id',index:'id', hidden:true, width:0}, 
		 	{name:'img',index:'img', width:80, sorttype:"string",resizable:false}, 
		 	{name:'name',index:'name', width:80, sorttype:"string",resizable:false}, 
		 	{name:'desc',index:'desc', width:100, sorttype:"string",resizable:false},
		 	{name:'act',index:'act', width:80,resizable:false}
		 ], 
		 caption: "Backpack" }); 
		 
	var mydata = [
		<#list pois as poi>
		{
			id:"${poi.id}",
			img:'<div class="iconlarge" style="background-image: url(${pages.IMG_ITEM_PATH}${poi.item.image}${pages.IMG_ITEM_EXT});"><div class="tile"/></div>',
			name:"${poi.item.name}",
			desc:"${poi.item.description}",
			act:'<button onclick="equip(${poi.id})">Equip</button><br/><button onclick="drop(${poi.id})">Drop</button>'
		}<#if !(poi == pois?last)>,</#if>
		</#list>
	]; 
	
	for(var i=0;i<=mydata.length;i++) 
		jQuery("#pack").addRowData(i+1,mydata[i]); 
}

initGrid();
</script>
</body>

</html>