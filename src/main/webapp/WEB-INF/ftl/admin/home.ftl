<#include "../common/macro.ftl" >
<html>
<head>

<title>Admin Control Panel</title>
</head>
<body>
<h1>Admin Control Panel</h1>

<table width="95%" cellpadding=10 cellspacing=10 >
	<tr>
		<td>
			<@panel title="Manage Map" icon="person" url="${base + pages.ADMIN_MAP + pages.PAGE_EXT}" img="../imgs/web/admin/maps.gif" alt="Maps" width="200px" height="120px" img_w=100 img_h=100 />
		</td>
		<td>
			<@panel title="Manage Map Areas" icon="person" url="${base + pages.ADMIN_AREAITEMS + pages.PAGE_EXT}?areaid=0" img="../imgs/web/admin/areas.gif" alt="" width="200px" height="120px" img_w=100 img_h=100 />
		</td>
		<td>
			<@panel title="Manage Items" icon="person" url="" img="../imgs/web/admin/items.gif" alt="" width="200px" height="120px" img_w=100 img_h=100 />
		</td>
		<td>
			<@panel title="Manage Spells" icon="person" url="" img="../imgs/web/admin/spells.gif" alt="" width="200px" height="120px" img_w=100 img_h=100 />
		</td>
	</tr>
	<tr>
		<td>
			<@panel title="Manage Monsters" icon="person" url="" img="../imgs/web/admin/monsters.gif" alt="" width="200px" height="120px" img_w=100 img_h=100 />
		</td>
		<td>
			<@panel title="Manage NPCs" icon="person" url="" img="../imgs/web/admin/NPCs.gif" alt="" width="200px" height="120px" img_w=100 img_h=100 />
		</td>
		<td>
			<@panel title="Manage Dialogs" icon="person" url="${base + pages.ADMIN_DIALOG + pages.PAGE_EXT}" img="../imgs/web/admin/dialogs.gif" alt="" width="200px" height="120px" img_w=100 img_h=100 />
		</td>
		<td>
			<@panel title="Manage Quests" icon="person" url="" img="../imgs/web/admin/quests.gif" alt="" width="200px" height="120px" img_w=100 img_h=100 />
		</td>
	</tr>
</table>

<a href="${base + pages.PAGE_ROOT + pages.PAGE_EXT}">[ HOME ]</a>

</body>
</html>