<table id="category-list" class="table table-striped table-bordered"
	cellspacing="0" width="100%">
	<thead>
		<tr>
			<td>Name</td>
			<td>Description</td>
			<td>Type</td>
			<td>Short Name</td>
			<td>Edit</td>
			<td>Delete</td>
		</tr>
	</thead>
	<tbody>
		<g:each in="${categories}" var="categoryItem">
			<tr id="category-${categoryItem.id}">
				<td class="category-name">
					${categoryItem.name}
				</td>
				<td class="category-description">
					${categoryItem.description}
				</td>
				<td class="category-type">
					${categoryItem.type}
				</td>
				<td class="category-shortName">
					${categoryItem.shortName}
				</td>
				<td class="category-edit"><a href="#">Edit</a></td>
				<td class="category-delete"><a href="#">Delete</a></td>
			</tr>
		</g:each>
	</tbody>
</table>