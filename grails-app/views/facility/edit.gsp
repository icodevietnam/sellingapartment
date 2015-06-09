<g:javascript src="jquery.validate.min.js"></g:javascript>
<form id='facility-update' method="POST" action="/facility/update">
	<p>
		<g:hiddenField name="id" value="${facility.id}" />
		<label for="name">Name:</label>
		<g:textField class="form-control input-sm" name="name" 
			value="${facility.name}" />
	</p>
	<p>
		<label for="description">Description:</label>
		<g:textField class="form-control input-sm" name="description" 
			value="${facility.description}" />
	</p>
	<p>
		<label for="type">Type:</label>
		<select id="selectType" name="type"
			style="width: 100%; height: 30px; border-radius: 3px">
			<option value="apartment">Apartment</option>
			<option value="supermarket">Super market</option>
			<option value="bank">Bank</option>
			<option value="preschool">Pre school</option>
			<option value="englishcentre">English Centre</option>
		</select>
	</p>
	<p>
		<button class="btn btn-primary" id="btnUpdate">Update</button>
		<a class="btn btn-default"
			href="${createLink(controller: 'facility', action: 'index')}">Cancel</a>
	</p>
</form>
<span id="typeFacility" class="hide">${facility.type}</span>
<script>
	$(document).ready(function(){
		var type = $("#typeFacility").html();
		var valOption = $("#selectType option");
		$.each(valOption,function(key,value){
			if($(value).val() == type ){
				$(value).attr("selected","selected");
			}
		});

		$('#facility-update').on('click','#btnUpdate',function(e){
			e.preventDefault();
			if($('#facility-update').valid()){
				$('#facility-update').submit();
			}
		});

		$('#facility-update').validate({
			rules: {
				name: { required: true },
				description : { required: true }
				},
			messages: {
				name: "Please input name",
				description: "Please input description"
				}
			});


	});
</script>