<table id="facility-list" class="table table-striped table-bordered"
	cellspacing="0" width="100%">
	<thead>
		<tr>
			<td>Name</td>
			<td>Description</td>
			<td>Type</td>
			<td>Edit</td>
			<td>Delete</td>
		</tr>
	</thead>
	<tbody>
		<g:each in="${facilities}" var="facilityItem">
			<tr id="facility-${facilityItem.id}">
				<td class="facility-name">
					${facilityItem.name}
				</td>
				<td class="facility-description">
					${facilityItem.description}
				</td>
				<td class="facility-type">
					${facilityItem.type}
				</td>
				<td class="facility-edit"><a href="#">Edit</a></td>
				<td class="facility-delete"><a href="#">Delete</a></td>
			</tr>
		</g:each>
	</tbody>
</table>