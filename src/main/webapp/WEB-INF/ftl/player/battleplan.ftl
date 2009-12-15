<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Battle Strategy</title>
</head>
<body>

<style>
#battleplan { list-style-type: none; margin: 0; padding: 0; }
li{margin-top:3px;}
.rem{width:30px;background-image: url("${pages.IMG_WEB_PATH}btl/remove.png");background-repeat:no-repeat;background-position: center;}
.nobut{width:30px;}
</style>

<div style="width: 1020px;">

<table>
	<tr>
		<td width="80px">
		<center><img src="${pages.IMG_WEB_PATH}btl/sword.png" /></center>
		</td>
		<td style="width: 200px;" valign="middle">
		<center>

		<table style="height:100%" class="ui-widget ui-widget-content ui-corner-all" >
			<tr>
				<td align="center" class="ui-state-highlight ui-corner-all" >Equipped weapon</td>
			</tr>
			<tr>
				<td align="center">
				<div class="equipped">
					<#if right?exists >
						<div class="iconlarge" style="background-image: url(${pages.IMG_ITEM_PATH +  right.item.image + pages.IMG_ITEM_EXT});">
							<div class="tile" ></div>
						</div>
					</#if>
				</div>
				</td>
			</tr>
			<tr>
				<td align="center">
					<#if right?exists >
						<button onclick="addAttack('${right.id}','${right.item.name}','${right.item.image}')">Add &gt;&gt;</button>
						<br/><br/>
					</#if>
				</td>
			</tr>

			<tr>
				<td align="center" class="ui-state-highlight ui-corner-all">Prepared spells</td>
			</tr>
			<tr>
				<td align="center">
					<select id="spellsel" onchange="changeSpellImg(this)">
						<#list character.preparedSpells as pks>
							<option value="${pks.id}" value="${pks.id}" img="${pks.spell.image}" >
								${pks.spell.name}
							</option>
						</#list>
					</select>
				</td>
			</tr>
			<tr>
				<td align="center">
				<div class="equipped">
					<#if character.preparedSpells?size != 0 >
						<div id="spell_ico" class="iconlarge" style="background-image: url(${ pages.IMG_SPELL_PATH + (character.preparedSpells?first).spell.image + pages.IMG_SPELL_EXT});">
							<div class="tile"/>
						</div>
					</#if>
				</div>
				</td>
			</tr>
			<tr>
				<td align="center">
				<button onclick="addSpell()">Add &gt;&gt;</button>
				<br/><br/>
				</td>
			</tr>
			<tr>
				<td align="center" class="ui-state-highlight ui-corner-all">Special Items</td>
			</tr>
			<tr>
				<td align="center"><select></select></td>
			</tr>
			<tr>
				<td align="center">
				<div class="equipped"></div>
				</td>
			</tr>
			<tr>
				<td align="center">
				<button>Add &gt;&gt;</button>
				</td>
			</tr>
			<tr>
				<td align="center">
					<input id="slots" type="text" size="2" readonly="readonly" value="${character.availableAttackSlot}"/> slots left
				</td>
			</tr>
			<tr>
				<td align="center">
					<button onclick="savePlan()">Save Plan</button>
				</td>
			</tr>
		</table>
		</center>
		</td>
		<td style="width: 700px;" valign="top">
			<center>
				<div class="ui-widget" >
					<div class="ui-state-highlight ui-corner-all" style="padding: 0pt 0.7em; margin-top: 20px;">
						<h2>Choose your attack strategy</h2>
						<p>One action will be performed on each round in the chosen order in a loop.<br />
						Action slots will increase leveling up.</p>
					</div>
				</div>
			
			</center>
			<br />
			<div style="width: 650px; height: 400px; overflow: auto;">
			<ul id="battleplan">
					<#list character.battlePlan as o >
					<li class="ui-state-default" id="<#if o.item?exists>A<#else>S</#if>${o.id}">
						<table width="600px" class="char">
							<tr>
								<td align="center"  width="50px">${character.battlePlan?seq_index_of(o)}</td>
								<td width="200px">${o.object.name}</td>			
								<td width="70px">
									<div class="iconlarge" style="background-image: 
									url(<#if o.item?exists>${pages.IMG_ITEM_PATH + o.object.image + pages.IMG_ITEM_EXT}<#else>${pages.IMG_SPELL_PATH + o.object.image + pages.IMG_SPELL_EXT}</#if>);">
										<div class="tile"/>
									</div>
								</td>
								<td onclick="remPlan(this)" class="<#if o.item?exists>nobut<#else>rem</#if>">&nbsp;</td>
						</tr>						
						</table>
					</li>
					</#list>
			</ul>			
			</div>
		</td>
		<td width="80px">
			<center><img src="${pages.IMG_WEB_PATH}btl/wand.png" /></center>
		</td>
	</tr>
</table>

</div>

<form method="POST" name="battleform" action="${rc.getContextPath() + pages.PAGE_BATTLEPLAN + pages.PAGE_EXT}">
	<input type="hidden" id="serialized" name="serialized" value="${character.dao.battle}" />
</form>

<script>

$('#battleplan').sortable({ axis:'y',placeholder:'ui-state-highlight',opacity:0.6  });

function savePlan(){
	getAllCodes();
	document.forms['battleform'].submit();
}

function changeSpellImg(el){
	var img = el.options[el.selectedIndex].getAttribute("img");
	document.getElementById("spell_ico").style.backgroundImage = "url(${pages.IMG_SPELL_PATH}"+img+"${pages.IMG_SPELL_EXT})";	
}

function remPlan(el){
	if(confirm("Remove this attack from the plan?")){
		document.getElementById("battleplan").removeChild(el.parentNode.parentNode.parentNode.parentNode);
		document.getElementById("slots").value = parseInt( document.getElementById("slots").value) + 1;
		getAllCodes();
	}
}

function addPlan(id,name,imag,type,path){

	if( ! checkSlots() ){
		alert("No more slots available");
		return;
	}
	
	var tab = document.createElement("table");
	tab.className="char";
	tab.style.width="600px";
	var tb = document.createElement("tbody");
	var tr = document.createElement("tr");
	var td1 = document.createElement("td");
	td1.style.width="50px";
	td1.style.align="center";
	td1.innerHTML = "N";
	var td2 = document.createElement("td");
	td2.style.width = "200px";
	td2.innerHTML = name;
	var td3 = document.createElement("td");
	td3.style.width="70";
	
	var inhtml = "<div style=\"background-image: url(";
	
	if(path=="item"){
		inhtml += "${pages.IMG_ITEM_PATH}"+imag+"${pages.IMG_ITEM_EXT}";
	}
	else {
		inhtml += "${pages.IMG_SPELL_PATH}"+imag+"${pages.IMG_SPELL_EXT}";
	}
	
	inhtml += ");\" class=\"iconlarge\"><div class=\"tile\"></div>";
	
	td3.innerHTML = inhtml;
	var td6 = document.createElement("td");
	td6.className = "rem";
	td6.setAttribute("onclick","remPlan(this)");
	
	tr.appendChild(td1);
	tr.appendChild(td2);
	tr.appendChild(td3);
	
	tr.appendChild(td6);
	tb.appendChild(tr);
	tab.appendChild(tb);
	
	var li = document.createElement("li");
	li.id = type+id;
	li.className="ui-state-default"
	li.appendChild(tab);
	
	document.getElementById("battleplan").appendChild(li);
	getAllCodes();
}

function addAttack(id,name,imag){
	addPlan(id,name,imag,"A","item");
}

function addSpell(){

	var el = document.getElementById("spellsel");
	var id = el.options[el.selectedIndex].value;
	var name = el.options[el.selectedIndex].innerHTML;
	var imag = el.options[el.selectedIndex].getAttribute("img");
	addPlan(id,name,imag,"S","spell");
}

function getAllCodes(){
	$("#battleplan").sortable( 'refresh' );
	txt = ""+$("#battleplan").sortable( 'toArray' );
	console.log(txt);
	document.getElementById("serialized").value = txt;
}

function checkSlots(){
	var d = document.getElementById("battleplan");
	
	if( document.getElementById("slots").value > 0){
		document.getElementById("slots").value = ${character.availableAttackSlot} - d.getElementsByTagName("table").length
		return true;
	}
	else{
		return false;
	}
	
}

</script>
</body>
</html>