<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Talk to ${npc.name}></title>
</head>
<body>

<div style="width: 1020px;">
	<div style="padding: 1% 1% 1% 1%; margin-bottom: 30px;">
		<table width="100%">
			<tr>
				<td valign="top" style="padding:2% 2% 2% 2%;background-image:url(../imgs/web/dialog/paper.jpg);border: 3px double #945205;">
					<h3>${dialog.sentence}</h3>
					<ul>
					<#list answers as answer>
						<li>						
							<#if answer.redirectUrl?exists && answer.redirectUrl!="">
							<a href="${rc.getContextPath()+answer.redirectUrl}">
							<#else>
							<a href="${rc.getContextPath()+pages.PAGE_NPCDIALOG+pages.PAGE_EXT}?id=${answer.dialogId}">
							</#if>
								${answer.answer}
							</a>	
							</li><br/>
					</#list>		
					</ul>
				</td>
				<td width="420px" >
					<img src="${pic}" style="border: 3px double lightgray;">
				</td>
			</tr>
		</table>
	</div>
</div>

</body>
</html>