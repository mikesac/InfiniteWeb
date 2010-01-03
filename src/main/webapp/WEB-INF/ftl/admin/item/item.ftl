<#include "../../common/macro.ftl" >
<html>
<head>
	<title>Items Editor</title>
</head>

<body>

<style>
td { white-space: nowrap; text-align:right;}
.ins{text-align:left;}
</style>
<table width="100%">
	<tr>
		<td width="70%" valign="top">
			<@nestedpanel icon="person" title="Item Data" width=950 height=350>
			
				<form name="formedit" id="formedit">
					<table width="900px">
					<tr>
						<td>Id</td>
						<td class="ins"><input type="text" value="" size=3 name="i_id" readonly="readonly"></td>
						
						<td></td>
						<td>Name</td>
						<td colspan=2 class="ins"><input type="text" value="" name="i_name"></td>
						
						<td rowspan=2 colspan=2 align="right">
							<img width=100 src="../${pages.IMG_WEB_PATH}admin/items.gif">
						</td>
						
					</tr>
					<tr>
						<td>Description</td>
						<td colspan=2 class="ins"><textarea name="i_description"></textarea></td>
						
						<td>Image</td>
						<td class="ins">
							<select name="i_image" onchange="updatePreview()">
								<option value="">No Image</option>
								<#list images as img>
								<option value="${img}">${img}</option>
								</#list>
							</select>
						</td>
						<td>
							<div id="preview" class="iconlarge" >
								<div class="tile"/>
							</div>
						</td>
					</tr>
					<tr>
												
						<td>Action Points</td>
						<td class="ins"><input type="text" value="0" size=3 name="i_costAp"></td>
						
						<td>Price</td>
						<td class="ins"><input type="text" value="0" size=3 name="i_price"></td>
						
						
					</tr>
					
					<tr>
						<td>Required Lev</td>
						<td class="ins"><input type="text" value="0" size=3 name="i_reqLev"></td>
						
						<td>Item Level</td>
						<td class="ins"><input type="text" value="0" size=3 name="i_level"></td>
						
						<td>Durability</td>
						<td class="ins"><input type="text" value="0" size=3 name="i_durability"></td>
						
						<td>Initiative</td>
						<td class="ins"><input type="text" value="0" size=3 name="i_initiative"></td>
						
					</tr>
					
					<tr>
						<td>Damage</td>
						<td class="ins"><input type="text" value="0d0" size=3 name="i_damage"></td>
						
						<td>Cast Spell</td>
						<td class="ins">
							<select name="i_spell" style="width:100px">
								<#list spells as sp>
								<option value="${sp.id}">${sp.name}</option>
								</#list>
							</select>
						</td>
						
						<td>Item Type</td>
						<td colspan="3" class="ins">
							<select name="i_type">
								<option value="0">No Item</option>
								<option value="1">Weapon</option>
								<option value="2">Shield</option>
								<option value="3">Armour</option>
								<option value="10">Quest Item</option>
							</select>
						</td>
					</tr>
										
					<tr>
						<td>Required Str</td>
						<td class="ins"><input type="text" value="0" size=3 name="i_reqStr"></td>
						
						<td>Required Int</td>
						<td class="ins"><input type="text" value="0" size=3 name="i_reqInt"></td>
						
						<td>Required Dex</td>
						<td class="ins"><input type="text" value="0" size=3 name="i_reqDex"></td>
						
						<td>Required Cha</td>
						<td class="ins"><input type="text" value="0" size=3 name="i_reqCha"></td>
					</tr>
					
					<tr>
						<td>Modified Str</td>
						<td class="ins"><input type="text" value="0" size=3 name="i_modStr"></td>
						
						<td>Modified Int</td>
						<td class="ins"><input type="text" value="0" size=3 name="i_modInt"></td>
						
						<td>Modified Dex</td>
						<td class="ins"><input type="text" value="0" size=3 name="i_modDex"></td>
						
						<td>Modified Cha</td>
						<td class="ins"><input type="text" value="0" size=3 name="i_modCha"></td>
					</tr>					
					</table>
					
				</form>
				
				<table>
					<tr>
						<td>
							<form id="formsend" name="formsend" method="POST" action="${rc.getContextPath() + pages.ADMIN_ITEM+ pages.PAGE_EXT}">
								<input type="hidden" name="data" value="">
								<input type="hidden" name="act" value="0">
							</form>
							<center>							
								<button onclick="send(0)">Save</button>
								<button onclick="send(1)">Modify</button>
								<button onclick="send(2)">Delete</button>
								</center>
							</td><td><center>
								<span style="font-size:small;">
								Use this form to create/delete/edit spells for the game.<br/>You can create new by filling the form or get data from existing spells by clicking on the list on the right.
								</span>
								</center>
						</td>
					</tr>
				</table>		
			</@nestedpanel>
			<br/>
			<@nestedpanel icon="person" title="Upload New Icon" width=950 height=80>
			
			<form name="uploadImage" method="POST" action="${rc.getContextPath() + pages.ADMIN_ITEM}.json" enctype="multipart/form-data">
				<table>
				<tr>
					<td>Icon name</td>
					<td><input type="text" name="icon"></td>
					
					<td>Image to upload</td>
					<td><input type="file" name="image"></td>
					<td><input type="submit" ></td>
				</tr>
				<tr>
					<td colspan=5>
					<center>
					<span style="font-size:small;">Use this form to upload new items icon, once uploaded the icon will be available in the "image" combo on the main form.
					<br/>Uploaded Images will be automatically converted to ${pages.IMG_ITEM_EXT} format an resized to fit game needs.</span>
					</center>
					</td>
				</tr>
				</table>
			</form>
			
			</@nestedpanel>
		</td>
		<td width="30%">
			<table>
				<tr>
					<td>Filter
						<select id="list_type" onChange="reloadGrid()">
							<option value="-1">All Items</option>
							<option value="1">Weapon</option>
							<option value="2">Shield</option>
							<option value="3">Armour</option>
							<option value="10">Quest Item</option>
						</select>
					</td>
				<tr>
					<td>
						<table id="list" class="scroll" cellpadding="0" cellspacing="0">
							<tr><td>Loading data...</td></tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<link rel="stylesheet" type="text/css" href="../../js/jquery/grid/ui.jqgrid.css">
<script type="text/javascript" src="../../js/jquery/grid/jquery.jqGrid.min.js"></script>
<script>

function reloadGrid()
{

	var el = document.getElementById('list_type');
	f= el.options[el.selectedIndex].value;
	
	$('#list').setGridParam({url:"${rc.getContextPath() + pages.ADMIN_ITEM}.json?id=-99&f="+f});
    $('#list').trigger("reloadGrid");
}

function initGrid()
{

	var el = document.getElementById('list_type');
	f= el.options[el.selectedIndex].value;
	
	jQuery("#list").jqGrid({
		 url:"${rc.getContextPath() + pages.ADMIN_ITEM}.json?id=-99&f="+f, 
		 datatype: "json", 
		 width:380,
		 forceFit:true,
		 hidegrid:false,
		 height: 500, 
		 colNames:['Image', 'Name'], 
		 colModel:[ 
		 	{name:'img', width:60, sorttype:"string",resizable:false}, 
		 	{name:'name', sorttype:"string",resizable:false}, 
		 ], 
		 caption: "Item List" }); 
		 
}

function loadData(id){

	
	$.getJSON( 
		"${rc.getContextPath() + pages.ADMIN_ITEM}.json?id="+id,
        function(jdata){
        	for(var i=0;i<document.forms['formedit'].elements.length;i++){
					var name = document.forms['formedit'].elements[i].name;
					if(name==""){
						continue;
					}
					
					if(document.forms['formedit'].elements[name].type=="checkbox"){
						document.forms['formedit'].elements[name].checked=jdata[name];
					}
					else{						
						document.forms['formedit'].elements[name].value = jdata[name];
					}
				}
			updatePreview();
        }
	);	
}

function prepareForm(){

    var o = "";
    var a = $("#formedit").serializeArray();
    $.each(a, function() {
        o = o +  ",\"" + this.name + "\":\"" + (this.value || "") + "\"";
        }
    );
    
    o = o.substring(1)
   
    return "{"+o+"}";
}
	



function send(act){
	document.forms['formsend'].elements["act"].value = act;
	document.forms['formsend'].elements["data"].value = prepareForm( )
		
	document.forms['formsend'].submit()
	document.forms['formsend'].reset()
	document.forms['formedit'].reset()
}

function updatePreview(){

	var preview = document.forms['formedit'].i_image.value;

	if(preview!=""){
		preview = "${pages.IMG_ITEM_PATH}"+preview+"${pages.IMG_ITEM_EXT}"
	}

	document.getElementById('preview').style.backgroundImage="url("+preview+")";
}

initGrid();
</script>
</body>
</html>