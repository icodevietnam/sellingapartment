<g:javascript src="jquery.validate.min.js"></g:javascript>
<form id="category-update" method="POST" action="/category/update">
	<p>
		<g:hiddenField name="id" value="${category.id}" />
		<label for="name">Name:</label>
		<g:textField class="form-control input-sm" name="name" value="${category.name}" />
	</p>
	<p>
		<label for="description">Description:</label>
		<g:textField class="form-control input-sm" name="description" value="${category.description}" />
	</p>
	<p>
		<label for="description">Type:</label><br/>
		<select name="type" id="selectType" style="width:100%;height:30px;border-radius:3px">
			<option value="news" > News</option>
			<option value="others" > Others</option>
		</select>
	</p>
	<p>
		<label for="description">Short Name:</label>
		<g:textField class="form-control input-sm" name="shortName" value="${category.shortName}" />
	</p>
	<p>
		<button  id="btnUpdate" class="btn btn-primary" >Update</button>
		<a class="btn btn-default" href="${createLink(controller: 'category', action: 'index')}">Cancel</a>
	</p>
</form>
<span id="typeCategory" class="hide">${category.type}</span>
<script>
	$(document).ready(function(){
		var type = $("#typeCategory").html();
		var valOption = $("#selectType option");
		$.each(valOption,function(key,value){
			if($(value).val() == type ){
				$(value).attr("selected","selected");
			}
		});

		$('#category-update').on('click','#btnUpdate',function(e){
			e.preventDefault();
			if($('#category-update').valid()){
				$('#category-update').submit();
			}
		});

		$('#category-update').validate({
			rules: {
				name: { required: true },
				description : { required: true },
				shortName : {required : true}
				},
			messages: {
				name: "Please input name",
				description: "Please input description",
				shortName : "Please input short name"
				}
			});
	});
</script>