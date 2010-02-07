<#include "../../common/macro.ftl" >
<html>
<head>
	<title>Dialog Editor</title>
</head>
<body>
<script type="text/javascript" src="${base}/js/jquery/treeview/jquery.treeview.min.js"></script>
<link rel="stylesheet" type="text/css" href="${base}/js/jquery/treeview/jquery.treeview.css" />
<style>
	.treeview ul {background-color:transparent;}
	.filetree span.ask, .filetree span.answ , .filetree span.base { padding: 1px 0 1px 16px; display: block; text-align:left; }
	.filetree span.base { background: url(${base}/js/jquery/treeview/images/comments.gif) 0 0 no-repeat; }
	.filetree span.ask { background: url(${base}/js/jquery/treeview/images/comment_b.gif) 0 0 no-repeat; }
	.filetree span.answ { background: url(${base}/js/jquery/treeview/images/comment_y.gif) 0 0 no-repeat; }		
</style>


<table width="99%">
	<tr>
		<td width="50%" valign="top">
			
			<select id="dialogs_sel" onchange="loadDialog()">
				<option value="new" selected="selected">New Dialog</option>
				<#list dialogs as dialog>
					<option value="${dialog}" >${dialog}</option>
				</#list>
			</select>
			
			<input type="text" id="filename" value="">
			<button onclick="saveDialog()">Save</button>
			<@nestedpanel icon="person" title="Dialog Structure" width=400 height=450>
				<ul id="browser" class="filetree">
					<li>
						<span class="base" id="base">Dialogs Structure</span>
						<ul id="base_ul"></ul>					
					</li>
				</ul>
			</@nestedpanel>
			
			<textarea id="json_txt" cols="40" style="display:none"></textarea>
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
				<button onclick="delNpcDialog()" disabled="disabled" id="delQ">Delete Current</button>
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
							<td>Required Level</td>
							<td>
								<input type="text" value="0" name="answ_reqLevel" size="3">
								<select name="answ_strict">
									<option value="false">Keep if higher</option>
									<option value="true">Hide if higher</option>
								</select>	
							</td>							
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
							<td>Next Dialog</td><td><select style="width:200px" name="answ_dialogId" id="answ_dialogId"></select></td>							
						</tr>
						<tr>
							<td>Redirect Url</td>
							<td>
								<select name="answ_redirectUrl">
									<option value="" selected="selected">No Redirect</option>
									<option value="${pages.PAGE_MAP + pages.PAGE_EXT}">Back to Map</option>
									<option value="${pages.PAGE_QUEST_ACTION + pages.PAGE_EXT}?act=0">Accept Quest</option>
									<option value="${pages.PAGE_QUEST_ACTION + pages.PAGE_EXT}?act=2">Get Reward</option>
									<option value="${pages.PAGE_SHOP + pages.PAGE_EXT}">Enter Item Shop</option>
									<option value="${pages.PAGE_SSHOP + pages.PAGE_EXT}">Enter Spell Shop</option>
									<option value="${pages.PAGE_MAPFIGHT + pages.PAGE_EXT}">Fight</option>
								</select>
							</td>							
						</tr>
					</table>
				</form>		
				<button onclick="addPcAnswer()">Append New</button>
				<button onclick="editPcAnswer()" disabled="disabled" id="editA">Edit Current</button>
				<button onclick="delPcAnswer()" disabled="disabled" id="delA">Delete Current</button>
			</@nestedpanel>

		</td>
	</tr>
</table>

<script>

var nAsk = 0;
var nAnsw = 0;

$(document).ready(function(){
 $("#browser").treeview({animated:"fast"});   			 
	initEvents();
	}
);

document.getElementById("editQ").disabled=true;
document.getElementById("delQ").disabled=true;
document.getElementById("editA").disabled=true;
document.getElementById("delA").disabled=true;


function delPcAnswer(){
	var del_id = document.forms['pc_answer'].answ_id.value;
	$(document.getElementById(del_id).parentNode).remove();
	$("#browser").treeview();
}


function addPcAnswer(){
	var add_id = document.forms['npcdialog'].npc_id.value;
	
	if(add_id=="base" || add_id.indexOf("_")!=-1){
		alert("Cannot add an answer here!");
	} 				
	else
	{
		var nodeId = add_id + "_" + nAnsw;		
		nAnsw++;
	
		if( add_id!="" && document.getElementById(add_id)){
			
			var txt = document.forms['pc_answer'].answ_answer.value;
			var rl = document.forms['pc_answer'].answ_reqLevel.value;
			var str = document.forms['pc_answer'].answ_strict.value;
			var rq = document.forms['pc_answer'].answ_reqQuest.value;
			var rqs = document.forms['pc_answer'].answ_reqQuestStatus.value;
			var rid = document.forms['pc_answer'].answ_dialogId.value;
			var rurl = document.forms['pc_answer'].answ_redirectUrl.value;
			
	
			addPcNode(nodeId,rl,str,rq,rqs,rid,rurl,txt,add_id);
	
			document.forms['pc_answer'].reset();
			document.getElementById("editA").disabled=false;
			document.getElementById("delA").disabled=false;
		}
		else{
			alert("Please,select a sentence to add an answer!");
		}	
	}
	initEvents();
}

function addPcNode(nodeId,rl,str,rq,rqs,rid,rurl,txt,add_id){
	var add_id = document.getElementById(add_id).parentNode;
	console.log(str)
	var topbranch = $("<li><span class='answ' id='"+nodeId+"' rl='"+rl+"' str='"+str+"' rq='"+rq+"' rqs='"+rqs+"' rid='"+rid+"' rurl='"+rurl+"'>"+txt+"</span></li>").appendTo(add_id);
	$("#browser").treeview();
}

function editPcAnswer(){
	var nodeId = document.forms['pc_answer'].answ_id.value;			
	var txt = document.forms['pc_answer'].answ_answer.value;
	var rl = document.forms['pc_answer'].answ_reqLevel.value;
	var str = document.forms['pc_answer'].answ_strict.value;
	var rq = document.forms['pc_answer'].answ_reqQuest.value;
	var rqs = document.forms['pc_answer'].answ_reqQuestStatus.value;
	var rid = document.forms['pc_answer'].answ_dialogId.value;
	var rurl = document.forms['pc_answer'].answ_redirectUrl.value;
	
	var oldNode = document.getElementById(nodeId)
	var parent = oldNode.parentNode;
	
	var newNode = document.createElement("span");
	newNode.innerHTML = txt;
	newNode.id = nodeId;
	newNode.setAttribute("rl",rl);
	newNode.setAttribute("str",str);
	newNode.setAttribute("rq",rq);
	newNode.setAttribute("rqs",rqs);
	newNode.setAttribute("rid",rid);
	newNode.setAttribute("rurl",rurl);
	newNode.className = "answ";
	
	parent.replaceChild(newNode,oldNode);
			
	$("#browser").treeview();

	document.forms['pc_answer'].reset();
	document.getElementById("editA").disabled=false;
	document.getElementById("delA").disabled=false;		
	initEvents();
}



function addNpcDialog(){
			
	var nodeId = nAsk;
	nAsk++;
	var txt = document.forms['npcdialog'].npc_sentence.value;				
				
	addNpcNode(nodeId,txt);
	initEvents();
	document.forms['npcdialog'].reset();
	document.getElementById("editQ").disabled=true;
	document.getElementById("delQ").disabled=true;
	updateDialogCombo();
}

function addNpcNode(nodeId,txt){
	var ask = $("<li><span class='ask' id='"+nodeId+"'>"+txt+"</span></li>").appendTo("#base_ul");
	$("#browser").treeview({add:ask});
}

function editNpcDialog()
{
	var id =  document.forms['npcdialog'].npc_id.value;
	var txt = document.forms['npcdialog'].npc_sentence.value;
	document.getElementById(id).innerHTML = txt;
	document.forms['npcdialog'].reset();
	document.getElementById("editQ").disabled=true;
	document.getElementById("delQ").disabled=true;
	updateDialogCombo();
}

function delNpcDialog(){
	var del_id = document.forms['npcdialog'].npc_id.value;
	$(document.getElementById(del_id).parentNode).remove();
	$("#browser").treeview();
	document.forms['npcdialog'].reset();
	document.getElementById("editQ").disabled=true;
	document.getElementById("delQ").disabled=true;
	updateDialogCombo();
}





function initEvents(){
	var list = document.getElementsByTagName("span");
	for(var i=0;i<list.length;i++){
		list[i].setAttribute('onclick', 'selectNode(this.id)');
	} 
}


function selectNode(id){

	if(id=="base"){return}


		if( id.indexOf("_")==-1){
			document.forms['npcdialog'].npc_id.value = id;
			document.forms['npcdialog'].npc_sentence.value = document.getElementById(id).innerHTML;
			document.getElementById("editQ").disabled=false;
			document.getElementById("delQ").disabled=false;
		}
		else{
			document.forms['pc_answer'].answ_id.value = id;
			document.forms['pc_answer'].answ_answer.value = document.getElementById(id).innerHTML;
			document.forms['pc_answer'].answ_reqLevel.value = document.getElementById(id).getAttribute('rl');
			document.forms['pc_answer'].answ_strict.value = document.getElementById(id).getAttribute('str');
			document.forms['pc_answer'].answ_reqQuest.value = document.getElementById(id).getAttribute('rq');
			document.forms['pc_answer'].answ_reqQuestStatus.value = document.getElementById(id).getAttribute('rqs');
			document.forms['pc_answer'].answ_dialogId.value = document.getElementById(id).getAttribute('rid');
			document.forms['pc_answer'].answ_redirectUrl.value = document.getElementById(id).getAttribute('rurl');
			document.getElementById("editA").disabled=false;
			document.getElementById("delA").disabled=false;
		}
	
}

function saveDialog(){

	if( confirm("Are you sure you want to save? Existing dialogs will be overwritten.") )
	{
	getJSON();
	
	$.ajax({
			type: 'post',
			url: "${rc.getContextPath()+pages.ADMIN_DIALOG}.json",
		  	data: ({filename : document.getElementById('filename').value, data:document.getElementById('json_txt').value}),		  
		  	error: function(XMLHttpRequest, textStatus, errorThrown){
		    	alert("Error saving dialog:"+textStatus+" "+errorThrown)
		  	},
		  	success:function(XMLHttpRequest, textStatus, errorThrown){
		    	alert("Dialog saved");
		    	document.location = document.location;
		  	}
		});
	}

}

function loadDialog(){

	var el = document.getElementById('dialogs_sel');

	if(el.selectedIndex==0){
		document.getElementById('filename').value = "";
		nAsk = 0;
		nAnsw = 0;
		document.getElementById("base_ul").innerHTML="";
		return;
	}
	var dialog = el.options[el.selectedIndex].value;
	
	document.getElementById('filename').value = dialog;
	
	$.getJSON("${rc.getContextPath()+pages.ADMIN_DIALOG}.json", 
		{ name: dialog },
		function(json){
			nAsk = 0;
			nAnsw = 0;
			document.getElementById("base_ul").innerHTML="";
			for(var i=0;i<json.dialog.length;i++)
			{
				addNpcNode(json.dialog[i].id,json.dialog[i].sentence);
				nAsk++;
				for(var j=0;j<json.dialog[i].answers.length;j++)
				{
					var n = json.dialog[i].answers[j];					
					addPcNode(json.dialog[i].id+"_"+j,n.reqLevel,n.strict,n.reqQuest,n.reqQuestStatus,n.dialogId,n.redirectUrl,n.answer,json.dialog[i].id);
					nAnsw++;
				}
			}
			initEvents();
			updateDialogCombo();
		}
	);	
	
}


function getJSON(){
	var json = '{"dialog" : [';
	
	var asks = $('.ask');
	for(var i=0;i<asks.length;i++){
	
		if(i>0){ json+=",";	}	
		json += '{"id":' + asks[i].id + ',"sentence":"' + asks[i].innerHTML + '","answers":[';
		
		var node = asks[i].nextSibling
		while(node){
			
			answ = node.childNodes[0]
			
			json += '{';
				json +=	'"answer":"'+answ.innerHTML+'",';
				json +=	'"reqLevel":'+answ.getAttribute("rl")+',';
				json +=	'"strict":'+answ.getAttribute("str")+',';
				json +=	'"reqQuest":'+answ.getAttribute("rq")+',';
				json +=	'"reqQuestStatus":'+answ.getAttribute("rqs")+',';
				json +=	'"dialogId":'+answ.getAttribute("rid")+',';
				json +=	'"redirectUrl":"'+answ.getAttribute("rurl")+'"';
				json +=	'}';
			
			node = node.nextSibling
			
			if(node){ json +=","; }
		}
		
		
		json += ']}';
	}
	json += "]}";
	
	document.getElementById('json_txt').value = json;
	
}

function updateDialogCombo(){
	var el = document.getElementById("answ_dialogId");
	el.innerHTML="";
	
	var op = document.createElement("option");
	op.value = -1;
	op.innerHTML = "None";
	el.appendChild(op);
	
	var asks = $('.ask');
	for(var i=0;i<asks.length;i++){
		var op = document.createElement("option");
		op.value = asks[i].id;
		op.innerHTML = asks[i].innerHTML;
		el.appendChild(op);
	}
}

</script>
</body>
</html>