<html>
<head>

<title>Admin Control Panel</title>
</head>
<body>
<h1>Admin Control Panel</h1>

<table width="95%" cellpadding=10 cellspacing=10 >
	<tr>
		<td>
			<@panel title="Manage Map" icon="person" url="" img="../imgs/web/admin/maps.gif" alt="Maps" width="200px" height="120px" />
		</td>
		<td>
			<@panel title="Manage Map Areas" icon="person" url="" img="../imgs/web/admin/areas.gif" alt="" width="200px" height="120px" />
		</td>
		<td>
			<@panel title="Manage Items" icon="person" url="" img="../imgs/web/admin/items.gif" alt="" width="200px" height="120px" />
		</td>
		<td>
			<@panel title="Manage Spells" icon="person" url="" img="../imgs/web/admin/spells.gif" alt="" width="200px" height="120px" />
		</td>
	</tr>
	<tr>
		<td>
			<@panel title="Manage Monsters" icon="person" url="" img="../imgs/web/admin/monsters.gif" alt="" width="200px" height="120px" />
		</td>
		<td>
			<@panel title="Manage NPCs" icon="person" url="" img="../imgs/web/admin/NPCs.gif" alt="" width="200px" height="120px" />
		</td>
		<td>
			<@panel title="Manage Dialogs" icon="person" url="" img="../imgs/web/admin/dialogs.gif" alt="" width="200px" height="120px" />
		</td>
		<td>
			<@panel title="Manage Quests" icon="person" url="" img="../imgs/web/admin/quests.gif" alt="" width="200px" height="120px" />
		</td>
	</tr>
</table>

<a href="${base + pages.PAGE_ROOT + pages.PAGE_EXT}">[ HOME ]</a>

</body>
</html>

<#macro panel title icon url img alt width height >
<div class="ui-dialog ui-widget ui-widget-content ui-corner-all" style="width:${width}">
	<div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
		<span id="ui-dialog-title-dialog" class="ui-dialog-title">${title}</span>
		<span class="ui-dialog-titlebar-close ui-corner-all">
			<span class="ui-icon ui-icon-person">${icon}</span>
		</span>
	</div>
	<div style="height: ${height};text-align:center;" class="ui-dialog-content ui-widget-content" id="dialog">
	<a href="${url}">
	<img border=0 src="${img}" width="100px" height="100px" alt="${alt}" title="${alt}" />
	</a>
</div>
</div>
</#macro>