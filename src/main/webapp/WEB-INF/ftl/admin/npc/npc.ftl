<#include "../../common/macro.ftl" >
<html>
<head>
	<title>Npc/Monster Editor</title>
</head>

<body>

<style>
	td { white-space: nowrap; text-align:right;}
	.ins{text-align:left;}
</style>
<table width="100%">
	<tr>
		<td width="70%" valign="top">
			<@nestedpanel icon="person" title="Npc/Monster" width=950 height=380>
			
				<form name="formedit" id="formedit">
					<table width="900px">
					<tr>
						<td>Id</td>
						<td class="ins"><input type="text" value="" size=3 name="n_id" readonly="readonly"></td>
						
						<td></td>
						<td>Name</td>
						<td colspan=2 class="ins"><input type="text" value="" name="n_name"></td>
						
						<td rowspan=2 colspan=2 align="right">
							<img src="../${pages.IMG_WEB_PATH}admin/monsters.gif">
						</td>
						
					</tr>
					<tr>
						<td>Description</td>
						<td colspan=2 class="ins"><textarea name="n_description"></textarea></td>
						
						<td>Image</td>
						<td class="ins">
							<select name="n_image" id="img_npc" onchange="updatePreview('${pages.IMG_NPC_PATH}')">
								<option value="">No Image</option>
								<#list images_npc as img>
								<option value="${img}">${img}</option>
								</#list>
							</select>
							<select name="off" style="display:none" id="img_monst" onchange="updatePreview('${pages.IMG_MONST_PATH}')">
								<option value="">No Image</option>
								<#list images_monst as img>
								<option value="${img}">${img}</option>
								</#list>
							</select>
							<br/>Click on the portrait to edit 
						</td>
						<td>
							<a href="javascript:toggleDialog()"><img width=64 border=1 src="" id="preview" /></a>
						</td>
					</tr>
					<tr>
												
						<td>Experience</td>
						<td class="ins"><input type="text" value="0" size=3 name="n_px"></td>
						
						<td>Gold</td>
						<td class="ins"><input type="text" value="0" size=3 name="n_gold"></td>
						
						<td>Area Type</td>
						<td class="ins" colspan="3">
							<select name="n_areatype">
								<option value="0">Standard</option>
							</select>
						</td>
					
					</tr>
					
					<tr>
						<td>Status</td>
						<td class="ins"><input type="text" value="0" size=3 name="n_status"></td>
						
						<td>N. of Attacks</td>
						<td class="ins"><input type="text" value="0" size=3 name="n_nattack"></td>
						
						<td>Attack Damage</td>
						<td class="ins" colspan=3><input type="text" value="0" size=25 name="n_attack"></td>
						
					</tr>
					
					<tr>
						
						
						<td>Level</td>
						<td class="ins"><input type="text" value="0" size=3 name="n_level"></td>
						
						<td>Dialog</td>
						<td colspan="3" class="ins">
							<select name="n_dialog" id="dialog_npc">
								<option value="">No Dialog</option>
								<#list dialogs_npc as d>
								<option value="${d}">${d}</option>
								</#list>
							</select>
							<select name="off" id="dialog_monst" style="display:none" >
								<option value="">No Dialog</option>
								<#list dialogs_monst as d>
								<option value="${d}">${d}</option>
								</#list>
							</select>
						</td>
					</tr>
										
					<tr>
						<td>Strength</td>
						<td class="ins"><input type="text" value="0" size=3 name="n_baseStr"></td>
						
						<td>Intelligence</td>
						<td class="ins"><input type="text" value="0" size=3 name="n_baseInt"></td>
						
						<td>Dexterity</td>
						<td class="ins"><input type="text" value="0" size=3 name="n_baseDex"></td>
						
						<td>Charisma</td>
						<td class="ins"><input type="text" value="0" size=3 name="n_baseCha"></td>
					</tr>
					
					<tr>
						<td>Life</td>
						<td class="ins"><input type="text" value="0" size=3 name="n_basePl"></td>
						
						<td>Magic</td>
						<td class="ins"><input type="text" value="0" size=3 name="n_basePm"></td>
						
						<td>Action</td>
						<td class="ins"><input type="text" value="0" size=3 name="n_basePa"></td>
						
						<td>Charm</td>
						<td class="ins"><input type="text" value="0" size=3 name="n_basePc"></td>
					</tr>
					<tr>
						<td>Can use weapons</td>
						<td class="ins">
							<select name="n_useWpn">
								<option value="false">No</option>
								<option value="true">Yes</option>								
							</select>
						</td>
						
						<td>Can use Armour</td>
						<td class="ins">
							<select name="n_useArm">
								<option value="false">No</option>
								<option value="true">Yes</option>
							</select>
						</td>
						
						<td>Can use shields</td>
						<td class="ins">
							<select name="n_useShld">
								<option value="false">No</option>
								<option value="true">Yes</option>
							</select>
						</td>
						
						<td>Monster</td>
						<td class="ins">
							<select name="n_ismonster" onchange="changeMonster(this.value)">
								<option value="false">No</option>
								<option value="true">Yes</option>
							</select>
						</td>
					</tr>					
					</table>
					
				</form>
				
				<table>
					<tr>
						<td>
							<form id="formsend" name="formsend" method="POST" action="${rc.getContextPath() + pages.ADMIN_NPC+ pages.PAGE_EXT}">
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
			<@nestedpanel icon="person" title="Upload New Spell Icon" width=950 height=80>
			
			<form name="uploadImage" method="POST" action="${rc.getContextPath() + pages.ADMIN_NPC}.json?m=0" enctype="multipart/form-data">
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
						<span style="font-size:small;">Use this form to upload new monster/npc image. You have to upload a large image (400px width) that describe the monster.
						<br/>Once uploaded,image will be available in the "image" combo. You can then edit it to choose a small area to be used as portrait.
						</span>
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
							<option value="0">NPCs</option>
							<option value="1">Monsters</option>
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


<div id="img_dialog">

<table>
	<tr>
		<td>
			<div id="crop">
			<img src="" id="preview_big" />
			</div>
		</td>
		<td align="right" valign="top">
			<@nestedpanel icon="person" title="Crop Data" width=200 height=350>
			<form name="editcrop" method="POST" action="${rc.getContextPath() + pages.ADMIN_NPC}CROP.json" >
				
				<table>
					<tr>
						<td>
							Name
						</td>
						<td colspan="2">
							<input type="text" size="10" readonly="readonly" name="crop_name">
						</td>
					</tr>
					<tr>
						<td>
							From
						</td>
						<td>
							<input type="text" size="3" readonly="readonly" name="crop_x1">
						</td>
						<td>
							<input type="text" size="3" readonly="readonly" name="crop_y1">
						</td>
					</tr>
					<tr>
						<td>
							To
						</td>
						<td>
							<input type="text" size="3" readonly="readonly" name="crop_x2">
						</td>
						<td>
							<input type="text" size="3" readonly="readonly" name="crop_y2">
						</td>
					</tr>
					<tr>
						<td colspan=3 >
							<input type="hidden" name="crop_type">
						</td>
					</tr>
					<tr>
						<td colspan=3 style="width:190;white-space:pre-line;text-align:center;font-size:small;">
							Select the area you want to use as a portrait picture for the Monster/Npc.<br/>
							The area will be resized to a 100x100 picture and made available in form "image" combo.
						</td>
					</tr>
					
				</table>
				
			</form>
			 
			</@nestedpanel>
			
		</td>
	</tr>
</table>


</div>





<link rel="stylesheet" type="text/css" href="../../js/jquery/grid/ui.jqgrid.css">
<script type="text/javascript" src="../../js/jquery/grid/jquery.jqGrid.min.js"></script>

<script src="../../js/jquery/jcrop/jquery.Jcrop.min.js"></script>
<link rel="stylesheet" href="../../js/jquery/jcrop/jquery.Jcrop.css" type="text/css" />



<script>

function reloadGrid()
{

	var el = document.getElementById('list_type');
	f= el.options[el.selectedIndex].value;
	
	$('#list').setGridParam({url:"${rc.getContextPath() + pages.ADMIN_NPC}.json?id=-99&f="+f});
    $('#list').trigger("reloadGrid");
}


function initGrid()
{
	var el = document.getElementById('list_type');
	f= el.options[el.selectedIndex].value;
	
	jQuery("#list").jqGrid({
		  url:"${rc.getContextPath() + pages.ADMIN_NPC}.json?id=-99&f="+f, 
		 datatype: "json", 
		 width:380,
		 forceFit:true,
		 hidegrid:false,
		 height: 500, 
		 colNames:['Image', 'Name'], 
		 colModel:[ 
		 	{name:'img',index:'img', width:60, sorttype:"string",resizable:false}, 
		 	{name:'name',index:'name', sorttype:"string",resizable:false}, 
		 ],
		 rowNum: -1,
		 caption: "Spell List" }); 
		  
}

function loadData(id){

	$.getJSON( 
		"${rc.getContextPath() + pages.ADMIN_NPC}.json?id="+id,
        function(jdata){
        
        	switchUpload(jdata['n_ismonster'])
                
        	for(var i=0;i<document.forms['formedit'].elements.length;i++){
					var name = document.forms['formedit'].elements[i].name;

					if(name=="" || name=="off"){
						continue;
					}
					
					if(document.forms['formedit'].elements[name].type=="checkbox"){
						document.forms['formedit'].elements[name].checked=jdata[name];
					}
					else{						
						document.forms['formedit'].elements[name].value = jdata[name];
					}
				}
			if(jdata['n_ismonster']){updatePreview('${pages.IMG_MONST_PATH}');}
			else{updatePreview('${pages.IMG_NPC_PATH}');}
        }
	);	
}

function changeMonster(value){
	switchUpload(value=="true");
}

function switchUpload(isMonster){

	if(isMonster){
		document.forms['uploadImage'].action = "${rc.getContextPath() + pages.ADMIN_NPC}.json?m=1";
		
		document.getElementById('img_monst').name = "n_image";
		document.getElementById('img_npc').name = "off";
		document.getElementById('img_npc').style.display = "none";
		document.getElementById('img_monst').style.display = "";
		
		document.getElementById('dialog_monst').name = "n_dialog";
		document.getElementById('dialog_npc').name = "off";
		document.getElementById('dialog_npc').style.display = "none";
		document.getElementById('dialog_monst').style.display = "";
		
	}
	else{
		document.forms['uploadImage'].action = "${rc.getContextPath() + pages.ADMIN_NPC}.json?m=0";	
		
		document.getElementById('img_npc').name = "n_image";
		document.getElementById('img_monst').name = "off";
		document.getElementById('img_monst').style.display = "none";
		document.getElementById('img_npc').style.display = "";
		
		document.getElementById('dialog_npc').name = "n_dialog";
		document.getElementById('dialog_monst').name = "off";
		document.getElementById('dialog_monst').style.display = "none";
		document.getElementById('dialog_npc').style.display = "";
		
		
	}
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

function updatePreview(path){

	var preview = document.forms['formedit'].n_image.value;

	if(preview!=""){
		preview_big = path +"big/"+ preview+"${pages.IMG_NPC_EXT}";
		preview = path + preview+"${pages.IMG_NPC_EXT}";		
	}

	document.getElementById('preview').src = preview;
	document.getElementById('preview_big').src = preview_big;
	
}

function toggleDialog(){

	if( document.forms['formedit'].n_image.value==""){
		alert("Choose and image from the combo");
		return;
	}
		

	if($("#img_dialog").dialog( 'isOpen' )){
		$("#img_dialog").dialog( 'close' );
	}
	else{
		var im = document.getElementById('preview_big').src;
		el = document.getElementById('crop');
		el.innerHTML = "";
		var pic = document.createElement('img');
		pic.src = im;
		pic.setAttribute("alt" , "Missing Image please re-upload it");
		pic.setAttribute("title","image");
		pic.id = "preview_big";
		el.appendChild(pic);
		
		jQuery('#preview_big').Jcrop({
            onSelect:    showCoords,
            bgColor:     'black',
            bgOpacity:   .4,
            setSelect:   [ 100, 100, 0, 0 ],
            minSize:	[100,100],
            aspectRatio: 1
    	});		
		
		document.forms['editcrop'].crop_name.value=	document.forms['formedit'].n_image.value;
		document.forms['editcrop'].crop_type.value=	document.forms['formedit'].n_ismonster.value;
		
		$("#img_dialog").dialog( 'open' );
	}

}




function showCoords(c) {	
	document.forms['editcrop'].crop_x1.value = c.x;
	document.forms['editcrop'].crop_y1.value = c.y;
	document.forms['editcrop'].crop_x2.value = c.x2;
	document.forms['editcrop'].crop_y2.value = c.y2;
	
}

$("#img_dialog").dialog(
	{ 
		autoOpen: false, 
		bgiframe: true,
		modal: true,
		resizable: false,
		title: 'Choose portrait area',
		width: 700,
		buttons: { "Crop & Save": function() { document.forms['editcrop'].submit(); } }
	}
);
var api;

initGrid();
</script>
</body>
</html>