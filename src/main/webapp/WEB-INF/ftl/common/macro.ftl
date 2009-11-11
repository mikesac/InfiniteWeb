<#macro panel title icon url img alt width height img_w img_h>
<div class="ui-dialog ui-widget ui-widget-content ui-corner-all" style="width:${width}">
	<div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
		<span id="ui-dialog-title-dialog" class="ui-dialog-title">${title}</span>
		<span class="ui-dialog-titlebar-close ui-corner-all">
			<span class="ui-icon ui-icon-${icon}">${icon}</span>
		</span>
	</div>
	<div style="height: ${height};text-align:center;" class="ui-dialog-content ui-widget-content" id="dialog">
	<a href="${url}">
	<img border=0 src="${img}" width="${img_w}px" height="${img_h}px" alt="${alt}" title="${alt}" />
	</a>
</div>
</div>
</#macro>


<#macro nestedpanel title icon width height >
<div class="ui-dialog ui-widget ui-widget-content ui-corner-all" style="width:${width}">
	<div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
		<span id="ui-dialog-title-dialog" class="ui-dialog-title">${title}</span>
		<span class="ui-dialog-titlebar-close ui-corner-all">
			<span class="ui-icon ui-icon-${icon}">${icon}</span>
		</span>
	</div>
	<div style="height: ${height};text-align:center;" class="ui-dialog-content ui-widget-content" id="dialog">
	<#nested>
</div>
</div>
</#macro>
