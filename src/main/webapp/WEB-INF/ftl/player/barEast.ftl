<div>
<table width="100%">
	<tr>
		<td>
		<table border="0" cellpadding="2" cellspacing="2" width="100%">
			<tr>
				<td>
					<a href="${rc.getContextPath()}${pages.PAGE_MAP}${pages.PAGE_EXT}" >
						<img width="80px" src="${pages.IMG_WEB_PATH}admin/maps.gif" alt="Map" title="Map" border="0">
					</a>
				</td>
				<td>
					<a href="${rc.getContextPath()}${pages.PAGE_EQUIP}${pages.PAGE_EXT}" >
						<img width="80px" src="${pages.IMG_WEB_PATH}menu/armor.gif" alt="Equipmen" title="Equipmen" border="0">
					</a>
				</td>
				
			</tr>
			<tr>
				<td>
					<a href="${rc.getContextPath()}${pages.PAGE_SPELL}${pages.PAGE_EXT}" >
						<img width="80px" src="${pages.IMG_WEB_PATH}admin/spells.gif" alt="Spell Book" title="Spell Book" border="0">
					</a>
				</td>
				<td>
					<a href="${rc.getContextPath()}${pages.PAGE_BATTLEPLAN}${pages.PAGE_EXT}" >
						<img width="80px" src="${pages.IMG_WEB_PATH}menu/battle.gif" alt="Battle Plan" title="Battle Plan" border="0">
					</a>
				</td>

			</tr>
			<tr>
			
				<td>
					<a href="${rc.getContextPath()}${pages.PAGE_STATUS}${pages.PAGE_EXT}" >
						<img width="80px" src="${pages.IMG_WEB_PATH}menu/status.gif" alt="Status" title="Status" border="0">
					</a>
				</td>
				<td>
					<a href="javascript:alert('TODO')" >
						<img width="80px" src="${pages.IMG_WEB_PATH}admin/quests.gif" alt="Quests" title="Quests" border="0">
					</a>
				</td>
				
			</tr>
			<tr>
				<td>
					<a href="javascript:alert('TODO')" >
						<img width="80px" src="${pages.IMG_WEB_PATH}menu/messages.gif" alt="Messages" title="Messages" border="0">
					</a>
				</td>
				<td></td>
			</tr>

		</table>
		</td>
	</tr>

	<tr>
		<td align="center">
			
			<div class="ui-dialog ui-widget ui-widget-content ui-corner-all" style="width:150px;">
				<div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix" >
					<span class="ui-dialog-title">${Session.map.areaName}</span>
				</div>
				<div class="ui-dialog-content ui-widget-content" style="font-size: x-small; background-color:white; color:black;font-style: italic;">
					<span >${Session.map.areaDesc}</span>
				</div>
			</div>		
		</td>
	</tr>
	
</table>


</div>