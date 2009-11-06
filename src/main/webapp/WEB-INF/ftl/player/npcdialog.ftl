<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Talk to ${npc.name}></title>
</head>
<body>

<div style="width: 1020px;">
	<div style="padding: 1% 1% 1% 1%; margin-bottom: 30px;">
		<table>
			<tr>
				<td>
					<p>${dialog.sentence}</p>
					<table>
					<#list dialog.answers as answer>
						<#if character.level &gt;= answer.reqLevel >
							<#if answer.redirectUrl?exists && answer.redirectUrl!="">
							<a href="${answer.redirectUrl}">
							<#else>
							<a href="${rc.getContextPath()+pages.PAGE_NPCDIALOG}?id=${answer.dialogId}">
							</#if>
								${answer.answer}
							</a>	
						</#if>
					</#list>		
					</table>
				</td>
				<td width="420px">
					<img src="${pages.IMG_NPC_PATH_BIG +  npc.image + pages.IMG_NPC_EXT}" />
				</td>
			</tr>
		</table>
	</div>
</div>

</body>
</html>