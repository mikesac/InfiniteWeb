<table>
	<tr>
		<td colspan="4">${spell.name}</td>
	</tr>
	<tr>
		<td><img src="${pages.IMG_SPELL_PATH +  spell.image + pages.IMG_SPELL_EXT}" /></td>
		<td colspan="3">${spell.description}</td>
	</tr>
	<tr>
		<td colspan="4">Details</td>
	</tr>
	<tr>
		<td>Mana Cost</td>
		<td>${spell.costMp}</td>
		<td><#if spell.spelltype == heal>Heal<#else>Damage</#if>
		</td>
		<td>${spell.damage}</td>
	</tr>
	<tr>
		<td>Duration</td>
		<td>${spell.duration / 1000}s</td>
		<td>Saving Throw</td>
		<td>${spell.savingthrow}</td>
	</tr>

	<tr>
		<td>Level</td>
		<td>${spell.level}</td>
		<td>Initiative</td>
		<td>${spell.initiative}</td>
	</tr>
	<tr>
		<td colspan="4">Required</td>
	</tr>
	<tr>
		<td>Strength</td>
		<td>${spell.reqStr}</td>
		<td>Intelligence</td>
		<td>${spell.reqInt}</td>
	</tr>
	<tr>
		<td>Dexterity</td>
		<td>${spell.reqDex}</td>
		<td>Charisma</td>
		<td>${spell.reqCha}</td>
	</tr>

	<tr>
		<td colspan="4">Modificators</td>
	</tr>
	<tr>
		<td>Strength</td>
		<td>${spell.modStr}</td>
		<td>Intelligence</td>
		<td>${spell.modInt}</td>
	</tr>
	<tr>
		<td>Dexterity</td>
		<td>${spell.modDex}</td>
		<td>Charisma</td>
		<td>${spell.modCha}</td>
	</tr>
</table>