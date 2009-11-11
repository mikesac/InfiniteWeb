<#include "common/macro.ftl" >
<html>
<head>

<title>Welcome</title>
</head>
<body>


<table cellspacing="10px" cellpadding="10px">
	<tr>
		<td>
			<@panel title="Play Game" icon="person" url="${base}${pages.PAGE_CHARACTER}${pages.PAGE_EXT}" img="imgs/web/home/play.gif" alt="Play" width="250px" height="205px" img_w=200 img_h=200 />
		</td>
		<td>
			<@panel title="Expand World" icon="image" url="${base}${pages.ADMIN_HOME}${pages.PAGE_EXT}" img="imgs/web/home/expand.gif" alt="Expand" width="250px" height="205px" img_w=200 img_h=200 />
		</td>
		</tr>
	<tr>
		<td>
			<@panel title="Register" icon="home" url="${base}${pages.PAGE_REGISTER}${pages.PAGE_EXT}" img="imgs/web/home/register.gif" alt="Register" width="250px" height="205px" img_w=200 img_h=200 />
		</td>		
		<td>
			<@panel title="Contribute to Project" icon="lightbulb" url="http://github.com/mikesac/InfiniteWeb" img="imgs/web/home/logo.gif" alt="home" width="250px" height="205px" img_w=200 img_h=200 />
		</td>
	</tr>
</table>

</body>
</html>