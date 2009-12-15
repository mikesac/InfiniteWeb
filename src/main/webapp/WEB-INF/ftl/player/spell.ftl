<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Spell Book</title>
</head>
<body>

<script type="text/javascript" src="../js/jquery/grid/jquery.jqGrid.min.js"></script>
<link rel="stylesheet" type="text/css" href="../js/jquery/grid/ui.jqgrid.css">

<style>
#spellbook{
	width:700px;
	height:542px;
}

#triskel{
	width:228px; height:225px; 
	background-image: url(${pages.IMG_WEB_PATH}spell/triskel.png);
	background-repeat:no-repeat;
}

.bookpg1{
	border:0px;width:282px;height:443px; background-image: url("${pages.IMG_WEB_PATH}spell/bookbg.png");background-repeat:repeat-y;
	}
	
.bookpg2{
	border:0px;width:282px;height:443px;
	background-image: url("${pages.IMG_WEB_PATH}spell/bookbg2.png");
	background-repeat:repeat-y;
	}
	
#book_n{width:700px;height:28px;background-image: url("${pages.IMG_WEB_PATH}spell/book_n.png");background-repeat:no-repeat;}
#book_w{width:55px;height:443px;background-image: url("${pages.IMG_WEB_PATH}spell/book_w.png");background-repeat:no-repeat;}
#book_p1{width:282px;background-image: url("${pages.IMG_WEB_PATH}spell/bookbg.png");background-repeat:repeat-y;}
#book_c{width:27px;height:443px;background-image: url("${pages.IMG_WEB_PATH}spell/book_c.png");background-repeat:no-repeat;}
#book_p2{width:282px;background-image: url("${pages.IMG_WEB_PATH}spell/bookbg2.png");background-repeat:repeat-y;}
#book_e{width:55px;height:443px;background-image: url("${pages.IMG_WEB_PATH}spell/book_e.png");background-repeat:no-repeat;}
#book_s{width:700px;height:71px;background-image: url("${pages.IMG_WEB_PATH}spell/book_s.png");background-repeat:no-repeat;}

</style>

<div style="width: 1020px;">
<div style="padding: 1% 1% 1% 1%; margin-bottom: 30px;">

<table cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td rowspan="2" style="width: 730px" id="spellbook">
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td colspan="5" id="book_n"></td>
			</tr>
			<tr>
				<td id="book_w"></td>
				<td id="book_p1" valign="top">
				<div style="height: 443px; overflow: auto;">
				<table style="background-color: transparent;">
					
					<#list pks as ks>
					
					<tr>
						<td>
						<table class="char">
							<tr>
								<td>
									<div class="iconlarge" style="background-image: url(${pages.IMG_SPELL_PATH}${ks.spell.image}${pages.IMG_SPELL_EXT});">
										<div class="tile"/>
									</div>
								</td>
								<td nowrap="nowrap">${ks.spell.name}</td>
								<td>
								<table>
									<tr>
										<td valign="bottom">
										<button class="buttonstyle"
											onclick="openBook(${ks.id})">Details</button>
										</td>
									</tr>
									<tr>
										<td valign="bottom">
											<button onclick="prepareSpell(${ks.id})">Prepare</button>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
					</tr>
					
					</#list>
				
					
				</table>
				</div>
				</td>
				<td id="book_c"></td>
				<td id="book_p2">
				<div id="detail_page"></div>
				</td>
				<td id="book_e"></td>
			</tr>
			<tr>
				<td colspan="5" id="book_s"></td>
			</tr>
		</table>
		</td>
		<td id="triskel">
			<img onclick="goPage(${attack})" style="position: relative; top: -65px; left: 78.5px;" src="${pages.IMG_WEB_PATH}spell/globe_r.<#if type==attack>gif<#else>png</#if>" alt="Attack Spells" title="Attack Spells" /> 
			<img onclick="goPage(${heal})" style="position: relative; top: 41px; left: -18px;"	src="${pages.IMG_WEB_PATH}spell/globe_b.<#if type==heal>gif<#else>png</#if>"	alt="Healing Spells" title="Healing Spells" /> 
			<img onclick="goPage(${defend})" style="position: relative; top: 25px; left: 40px;" src="${pages.IMG_WEB_PATH}spell/globe_g.<#if type==defend>gif<#else>png</#if>" alt="Protection Spells" title="Protection Spells" /></td>
	</tr>
	<tr>
		<td valign="middle" align="center">
			<table id="spells" class="scroll" cellpadding="0" cellspacing="0"></table>	
		</td>
	</tr>
</table>
</div>
</div>


<form action="${rc.getContextPath()}${pages.PAGE_SPELL}${pages.PAGE_EXT}" method="POST" name="spellform">
	<input type="hidden" name="spellid"	value="-1" /> 
	<input type="hidden" name="mode" value="-1" />
</form>


<script type="text/javascript">

	function prepareSpell(id){
		document.forms['spellform'].elements['spellid'].value=id;
		document.forms['spellform'].elements['mode'].value=${equip};
		document.forms['spellform'].submit();
	}
	
	function removespell(id){
		document.forms['spellform'].elements['spellid'].value=id;
		document.forms['spellform'].elements['mode'].value=${drop};
		document.forms['spellform'].submit();
	}

	function goPage(id){
		var url = "${rc.getContextPath()+pages.PAGE_SPELL+pages.PAGE_EXT}?${typename}="+id;
		document.location=url;
	}

	function openBook(id){
	
		$.ajax({
			type: 'get',
			url: "${rc.getContextPath()+pages.PAGE_SPELLBOOK}.json",
		  	cache: false,
		  	data: ({spellid : id}),		  
		  	success: function(html){
		    	$("#detail_page").append(html);
		  	}
		});
	
	}
	
	function initGrid(){
	jQuery("#spells").jqGrid({
		 datatype: "local", 
		 autowidth:true,
		 forceFit:true,
		 hidegrid:false,
		 height: 250, 
		 colNames:['','Image', 'Name', 'Actions' ], 
		 colModel:[ 
		 	{name:'id',index:'id', hidden:true, width:0}, 
		 	{name:'img',index:'img', width:80, sorttype:"string",resizable:false}, 
		 	{name:'name',index:'name', width:80, sorttype:"string",resizable:false}, 
		 	{name:'act',index:'act', width:80,resizable:false}
		 ], 
		 caption: "Prepared Spells ( ${character.availableSpellSlot} Slot left)" }); 
		 
	var mydata = [
		<#list character.preparedSpells as ps >
			<#if ps.status == ready>
			{
				id:"${ps.id}",
				img:'<img src="${pages.IMG_SPELL_PATH}${ps.spell.image}${pages.IMG_SPELL_EXT}" />',
				name:"${ps.spell.name}",
				act:'<button onclick="removespell(${ps.id})">Remove</button>'
			}
			</#if><#if !(ps == character.preparedSpells?last)>,</#if>
		</#list>
	]; 
	
	for(var i=0;i<=mydata.length;i++) 
		jQuery("#spells").addRowData(i+1,mydata[i]); 
}

initGrid();
</script>
</body>
</html>