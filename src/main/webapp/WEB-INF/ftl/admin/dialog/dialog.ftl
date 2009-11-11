<#include "../../common/macro.ftl" >
<html>
<head>
	<title>Dialog Editor</title>
</head>
<body>
<script type="text/javascript" src="${base}/js/jquery/tree/jquery.tree.min.js"></script>
<link rel="stylesheet" type="text/css" href="${base}/js/jquery/tree/themes/default/style.css" />



<table width="99%">
	<tr>
		<td width="50%" valign="top">
			<@nestedpanel icon="person" title="Dialog Structure" width=400 height=450>
				<div id="mytree"></div>
			</@nestedpanel>
			<textarea id="json_txt" cols="40"></textarea>
			<button onclick="getJSON()">test</button>
		</td>
		<td width="50%">
			<@nestedpanel icon="person" title="Add Npc sentence" width=450 height=150>
				<form name="npcdialog">
					<table>
						<tr>
							<td>Id</td>
							<td>
								<input type="text" value="" name="npc_id" size="3" readonly="readonly" onchange="checkIdQuest(this)">
							</td>
						</tr>
						<tr>
							<td>Sentence</td>
							<td><textarea name="npc_sentence"></textarea></td>
						</tr>
					</table>
				</form>
				<button onclick="addNpcDialog()">Append new</button>
				<button onclick="editNpcDialog()" disabled="disabled" id="editQ">Edit Current</button>
			</@nestedpanel>
			
			<@nestedpanel icon="person" title="Add Player answer" width=450 height=300>	
				<form name="pc_answer">
					<table>
						<tr>
							<td>Id</td><td><input type="text" value="" name="answ_id" readonly="readonly" size="3"  onchange="checkIdAnsw(this)"></td>							
						</tr>
						<tr>								
							<td>Answer</td><td><textarea name="answ_answer"></textarea></td>							
						</tr>
						<tr>								
							<td>Required Level</td><td><input type="text"  value="0" name="answ_reqLevel" size="3"></td>							
						</tr>
						<tr>								
							<td>Required Quest</td><td><input type="text" value="0" name="answ_reqQuest" size="3"></td>							
						</tr>
						<tr>								
							<td nowrap="nowrap">Required Quest Status</td>
							<td>
								<select name="answ_reqQuestStatus">
									<option value = "0" selected="selected">UNASSIGNED</option>
									<option value = "1" >PENDING</option>
									<option value = "2" >EXECUTED</option>
									<option value = "3" >COMPLETED</option>
									<option value = "4" >ABORTED</option>
								</select>
							</td>							
						</tr>
						<tr>							
							<td>Next Dialog</td><td><select name="answ_dialogId" id="answ_dialogId"></select></td>							
						</tr>
						<tr>
							<td>Redirect Url</td><td><input type="text" value="" name="answ_redirectUrl"></td>							
						</tr>
					</table>
				</form>		
				<button onclick="addPcAnswer()">Append New</button>
				<button onclick="editPcAnswer()" disabled="disabled" id="editA">Edit Current</button>
			</@nestedpanel>

		</td>
	</tr>
</table>

<script>

var root = [{attributes:{id:"root"},data:{title:"Dialog",icon:"/Infinite/imgs/web/dialog/comments.gif"},type:{clickable	: false} }];

jQuery("#mytree").tree({
				data : { 
					type : "json",
					opts : {
						static : root
					}
				},
				callback : {
					onselect:selectNode
				}
			}
		);

var mytree =  jQuery.tree.reference("#mytree");

generateNextDialog();

function selectNode(node, tree){

	if(node.id!="root"){
		if( mytree.parent(mytree.selected)[0].id == "root"){
			document.forms['npcdialog'].npc_id.value = node.id;
			document.forms['npcdialog'].npc_sentence.value = tree.get_text(node);
			document.getElementById("editQ").disabled=false;
		}
		else{
			document.forms['pc_answer'].answ_id.value = node.id;
			document.forms['pc_answer'].answ_answer.value = tree.get_text(node);
			document.forms['pc_answer'].answ_reqLevel.value = node.attributes.rl.value;
			document.forms['pc_answer'].answ_reqQuest.value = node.attributes.rq.value;
			document.forms['pc_answer'].answ_reqQuestStatus.value = node.attributes.rqs.value;
			document.forms['pc_answer'].answ_dialogId.value = node.attributes.rid.value;
			document.forms['pc_answer'].answ_redirectUrl.value = node.attributes.rurl.value;
			document.getElementById("editA").disabled=false;
		}
	}
}

function addNpcDialog()
{
	var id =  mytree.children("#root").length
	saveNpcDialog(id);
}

function editNpcDialog()
{
	var id =  document.forms['npcdialog'].npc_id.value;
	saveNpcDialog(id);
}

function saveNpcDialog(id)
{
	var txt = document.forms['npcdialog'].npc_sentence.value;
	mytree.create( {data : {title:txt, icon:"/Infinite/imgs/web/dialog/comment_b.gif"},attributes:{id:id} } ,  "#root");
	generateNextDialog();
	document.forms['npcdialog'].reset();
	document.getElementById("editQ").disabled=true;
}

function addPcAnswer()
{
	
	
	if( mytree.selected && mytree.selected!="#root" && mytree.parent(mytree.selected)[0] && mytree.parent(mytree.selected)[0].id == mytree.get_node("#root")[0].id)
	{
		var id =  mytree.selected[0].id + "_" + mytree.children(mytree.selected).length;
		var txt = document.forms['pc_answer'].answ_answer.value;

		var rl = document.forms['pc_answer'].answ_reqLevel.value;
		var rq = document.forms['pc_answer'].answ_reqQuest.value;
		var rqs = document.forms['pc_answer'].answ_reqQuestStatus.value;
		var rid = document.forms['pc_answer'].answ_dialogId.value;
		var rurl = document.forms['pc_answer'].answ_redirectUrl.value;

		mytree.create( {
			data : {
				title:txt, 
				icon:"/Infinite/imgs/web/dialog/comment_y.gif"
			},
			attributes:{
				id:id,
				rl:rl,
				rq:rq,
				rqs:rqs,
				rid:rid,
				rurl:rurl
			} 
		});
		document.forms['pc_answer'].reset();
		document.getElementById("editA").disabled=false;
	}
	else{
		alert("You have to select a NPC sentence to add an answer!");
	}	
}


function generateNextDialog(){
	var dialogs = mytree.children("#root");
	var parent = document.getElementById("answ_dialogId");
	while(parent.hasChildNodes()){
		parent.removeChild(parent.firstChild);
	}
	
	for(var i=0;i<dialogs.length;i++){
		var opt = document.createElement("option");
		opt.value = dialogs[i].id;
		opt.innerHTML = mytree.get_text(dialogs[i]);
		parent.appendChild(opt);	
	}
}

function getJSON(){
	var json = '{"dialog" : [';
	var dialogs = mytree.children("#root");
	for(var i=0;i<dialogs.length;i++){

		if(i>0){
			json+=",";
		}
		
		json += '{"id":"'+dialogs[i].id+'","sentence":"'+mytree.get_text(dialogs[i])+'","answer":[';

			var answers =  mytree.children(dialogs[i]);
			for(var j=0;j<answers.length;j++){

				if(j>0){
					json+=",";
				}
				
				json += '{';
				json +=	'"answer":"'+mytree.get_text(answers[j])+'",';
				json +=	'"reqLevel":'+answers[j].attributes.rl.value+',';
				json +=	'"reqQuest":'+answers[j].attributes.rq.value+',';
				json +=	'"reqQuestStatus":'+answers[j].attributes.rqs.value+',';
				json +=	'"dialogId":"'+answers[j].attributes.rid.value+'",';
				json +=	'"redirectUrl":"'+answers[j].attributes.rurl.value+'"';
				json +=	'}';				
			}		
		json += ']}';
	}
	json += "]}";
	document.getElementById('json_txt').value = json;
	
}

</script>
</body>
</html>