<g:form id="${apartment.id}" method="POST" controller="apartment" action="update" name="apartmentForm">
	<p>
		<label for="name">Name:</label> 
		<g:textField class="form-control input-sm" type="text" name="name" value="${apartment.name}"/>
	</p>
	<p>
		<label for="code">Code:</label> 
		<g:textField class="form-control input-sm" type="text" name="code" value="${apartment.code}"/>
	</p>
	<p>
		<label for="description">Description:</label>
		<g:textField class="form-control input-sm" type="text" name="description" value="${apartment.description}"/>
	</p>
	<p>
		<label for="address">Address:</label> 
		<g:textField class="form-control input-sm" type="text" name="address" value="${apartment.address}"/>
	</p>
	<p>
		<label for="location">Location:</label> 
		<g:textField class="form-control input-sm hidden" type="text" name="location" value="${apartment.location}"/>
	</p>
	<div id="googleMap" style="width:490px;height:380px;margin:0 auto;"></div>
	<p>
		<label for="price">Price:</label> 
		<g:textField class="form-control input-sm" type="text" name="price" value="${apartment.price}"/>
	</p>
	<p>
		<select class="facilityPicker" name="facilities" multiple title='Choose facilities...'>
			<g:each in="${facilities}" var="facility">
				<option value="${facility.id}">${facility.name}</option>
			</g:each>
		</select>
	</p>
	<p>
		<input class="btn btn-primary chooseFileButton" type='button' value="Upload Image" />
	</p>
	<div class="imageListContainer">
		<ul class="imageList">
			<g:if test="${apartment != null && apartment.images != null}">
				<g:each in="${apartment.images}" var="image">
					<li class="imageItem">
						<g:link controller="image" action="downloadFile" id="${image.code}" params='[fileName: "${image.fileName}", apartmentId: "${apartment.id}"]'>
							${image.fileName}
						</g:link>
					</li>
				</g:each>
			</g:if>
		</ul>
	</div>
	<p>
		<g:submitButton class="btn btn-primary" name="update" value="Update"  />
		<a class="btn btn-default" href="${createLink(controller: 'apartment', action: 'index')}">Cancel</a>
	</p>
</g:form>
<script>
	var selectedFacilities = ${apartmentFacilities};
	$('.facilityPicker').selectpicker();
	$('.facilityPicker').selectpicker('val', selectedFacilities);
</script>