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
			<@panel title="Manage Map" icon="person" url="${base + pages.ADMIN_MAP + pages.PAGE_EXT}" img="${pages.IMG_WEB_PATH}admin/maps.gif" alt="Maps" width="200px" height="120px" img_w=100 img_h=100 />
		</td>
		<td>
			<@panel title="Manage Map Areas" icon="person" url="${base + pages.ADMIN_AREAITEMS + pages.PAGE_EXT}?areaid=1" img="${pages.IMG_WEB_PATH}/admin/areas.gif" alt="" width="200px" height="120px" img_w=100 img_h=100 />
		</td>
		<td>
			<@panel title="Manage Items" icon="person" url="${base + pages.ADMIN_ITEM + pages.PAGE_EXT}" img="${pages.IMG_WEB_PATH}/admin/items.gif" alt="" width="200px" height="120px" img_w=100 img_h=100 />
		</td>
		<td>
			<@panel title="Manage Spells" icon="person" url="${base + pages.ADMIN_SPELL + pages.PAGE_EXT}" img="${pages.IMG_WEB_PATH}/admin/spells.gif" alt="" width="200px" height="120px" img_w=100 img_h=100 />
		</td>
	</tr>
	<tr>
		<td>
			<@panel title="Manage Monsters/NPCs" icon="person" url="${base + pages.ADMIN_NPC + pages.PAGE_EXT}" img="${pages.IMG_WEB_PATH}/admin/monsters.gif" alt="" width="200px" height="120px" img_w=100 img_h=100 />
		</td>
		<td>
			<@panel title="Manage Dialogs" icon="person" url="${base + pages.ADMIN_DIALOG + pages.PAGE_EXT}" img="${pages.IMG_WEB_PATH}/admin/dialogs.gif" alt="" width="200px" height="120px" img_w=100 img_h=100 />
		</td>
		<td>
			<@panel title="Manage Quests" icon="person" url="javascript:alert('ToDo')" img="${pages.IMG_WEB_PATH}/admin/quests.gif" alt="" width="200px" height="120px" img_w=100 img_h=100 />
		</td>
		<td>			
		</td>
	</tr>
</table>

<a href="${base + pages.PAGE_ROOT + pages.PAGE_EXT}">[ HOME ]</a>

</body>
</html>