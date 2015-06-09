<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<meta name="layout" content="admin" />
<title>Manage Category</title>
<g:javascript src="jquery.dataTables.js"></g:javascript>
<g:javascript src="dataTables.bootstrap.js"></g:javascript>
<g:javascript src="jquery.validate.min.js"></g:javascript>
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'dataTables.bootstrap.css')}"
	type="text/css">
<style type="text/css">
#categoryTableContainer, #categoryFormContainer {
	float: left;
	padding: 10px;
}

#categoryTableContainer {
	width: 75%;
}

#categoryFormContainer {
	width: 25%;
}
</style>
</head>
<body>
	<div id="categoryTableContainer">
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
						<td class="category-shortname">
							${categoryItem.shortName}
						</td>
						<td class="category-edit"><a href="#">Edit</a></td>
						<td class="category-delete"><a href="#">Delete</a></td>
					</tr>
				</g:each>
			</tbody>
		</table>
	</div>

	<div id="categoryFormContainer">
		<g:if test="${status}">
			<div id="category-inform-message" class="alert alert-success"
				style="display: none;" role="alert">
				${message}
			</div>
		</g:if>
		<g:else>
			<div id="category-inform-message" class="alert"
				style="display: none;" role="alert"></div>
		</g:else>
		<div id="categoryFormFolder">
			<form id="category-form">
				<p>
					<label for="name">Name:</label> <input
						class="form-control input-sm" type="text" name="name" />
				</p>
				<p>
					<label for="description">Description:</label> <input
						class="form-control input-sm" type="text" name="description" />
				</p>
				<p>
					<label for="description">Type:</label><br /> <select
						id="selectType"
						style="width: 100%; height: 30px; border-radius: 3px">
						<option value="news">News</option>
						<option value="others">Others</option>
					</select>
				</p>
				<p>
					<label for="description">Short Name:</label> <input
						class="form-control input-sm" type="text" name="shortName" />
				</p>
				<p>
					<input id="createButton" class="btn btn-primary" type='submit'
						value="Create" />
				</p>
			</form>
		</div>
	</div>
	<div class="shim"></div>
	<div class="modal fade" id="delete-modal" tabindex="-1" role="dialog"
		aria-labelledby="delete-modal-title" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="delete-modal-title">Confirmation</h4>
				</div>
				<div class="modal-body">
					Do you want to delete category <strong class="item-id hidden"></strong>
					<strong class="item-name"></strong>?
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">No</button>
					<button id="delete-modal-agree" type="button"
						class="btn btn-primary">Yes</button>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function(){
			//initialize data table
			var table = $('#category-list').DataTable();
			if($('#category-inform-message').html() != ''){
				$('#category-inform-message').slideDown('fast')
				.delay(5000)
				.slideUp('slow');
			}
		});
		//validation
		$('#category-form').validate({
			rules: {
				name: { required: true },
				description : { required: true },
				shortName : { required: true }
				},
			messages: {
				name: "Please input name",
				description: "Please input description",
				shortName: "Please input short name"
				},
			});
		//handle click create
		$('#category-form').on('click', '#createButton', function(event){
			event.preventDefault();
				if($('#category-form').valid()){
				var categoryForm = $('#category-form');
				var categoryParams = getCategoryParameters(categoryForm);
				createCategory(categoryParams);
			}
		});
		function getCategoryParameters(form){
			var parameters = {}
			parameters['name'] = $.trim(form.find('input[name=name]').val());
			parameters['description'] = $.trim(form.find('input[name=description]').val());
			parameters['type'] = $.trim(form.find('#selectType').val());
			parameters['shortName'] =$.trim(form.find('input[name=shortName]').val());
			return parameters;
		}
		function createCategory(parameters){
			$.ajax({
				url: '${createLink(controller:'category', action:'create')}',
				data: parameters,
				type: 'POST',
				beforeSend: function(){
					showLoadingStatus();
				},
				success: function(data, status, jqXHR){
					if(data != 'fail'){
						$('#categoryTableContainer').html(data);
						table = $('#category-list').DataTable();
						$('#category-inform-message').slideDown('fast')
						.removeClass(function(index, css) {
							return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
						})
						.addClass('alert-success')
						.html('Create category '+parameters['name']+' successfully.')
						.delay(5000)
						.slideUp('slow');
					}
					else{
						$('#category-inform-message').slideDown('fast')
						.removeClass(function(index, css) {
							return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
						})
						.addClass('alert-danger')
						.html('Fail to create category '+parameters['name']+'.')
						.delay(5000)
						.slideUp('slow');
					}
				},
				error: function(jqXHR, status, error){
					$('#category-inform-message').slideDown('fast')
					.removeClass(function(index, css) {
						return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
					})
					.addClass('alert-danger')
					.html('Fail to create category '+parameters['name']+'.')
					.delay(5000)
					.slideUp('slow');
				}, 
				complete: function(jqXHR, status){
					hideLoadingStatus();
					$('#category-form input[name=name]').val('');
					$('#category-form input[name=description]').val('');
					$('#category-form input[name=shortName]').val('');
				}
			});
		}
		//handle click edit category
		$('#categoryTableContainer').on('click', '.category-edit', function(event){
			event.preventDefault();
			var selectedCategoryId = getCategoryIdForEditing($(this));
			var selectedCategoryName = getCategoryNameForEditing($(this));
			editCategory(selectedCategoryId, selectedCategoryName);
		});
		function getCategoryIdForEditing(information){
			return parseInt($.trim(information.parent().attr('id').split(/category-/g)[1]));
		}
		function getCategoryNameForEditing(information){
			return $.trim(information.parent().find('.category-name').html());
		}
		function editCategory(categoryId, categoryName){
			$.ajax({
				url: '${createLink(controller:'category', action:'edit')}',
				data: {'id': categoryId},
				type: 'GET',
				beforeSend: function(){
					showLoadingStatus();
				},
				success: function(data, status, jqXHR){
					$('#categoryFormFolder').html(data);
				},
				error: function(jqXHR, status, error){
					$('#category-inform-message').slideDown('fast')
					.removeClass(function(index, css) {
						return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
					})
					.addClass('alert-danger')
					.html('Category ' + categoryName + ' is not available.')
					.delay(5000)
					.slideUp('slow');
				},
				complete: function(){
					hideLoadingStatus();
				}
			});
		}
		
		//handle click delete category
		$('#categoryTableContainer').on('click', '.category-delete', function(event){
			event.preventDefault();
			var selectedCategoryId = getCategoryIdForEditing($(this));
			var selectedCategoryName = getCategoryNameForEditing($(this));
			showConfirmation(selectedCategoryId, selectedCategoryName);
		});
		function showConfirmation(categoryId, categoryName){
			$('#delete-modal .modal-body .item-name').html($.trim(categoryName));
			$('#delete-modal .modal-body .item-id').html($.trim(categoryId));
			$('#delete-modal').modal('show');
		}
		$('#delete-modal-agree').on('click', function(){
			var selectedCategoryId = $.trim($('#delete-modal .modal-body .item-id').html());
			var selectedCategoryName = $.trim($('#delete-modal .modal-body .item-name').html());
			$.ajax({
				url: '${createLink(controller:'category', action:'delete')}',
				data: {'id': selectedCategoryId, 'name': selectedCategoryName},
				type: 'POST',
				success: function(data, status, jqXHR){
					if(data != 'fail'){
						$('#categoryTableContainer').html(data);
						table = $('#category-list').DataTable();
						$('#category-inform-message').slideDown('fast')
						.removeClass(function(index, css) {
							return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
						})
						.addClass('alert-success')
						.html('Delete category ' + selectedCategoryName + ' successfully.')
						.delay(5000)
						.slideUp('slow');
					}
					else{
						$('#category-inform-message').slideDown('fast')
						.removeClass(function(index, css) {
							return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
						})
						.addClass('alert-danger')
						.html('Fail to delete category ' + selectedCategoryName + '.')
						.delay(5000)
						.slideUp('slow');
					}
				},
				error: function(jqXHR, status, error){
					$('#category-inform-message').slideDown('fast')
					.removeClass(function(index, css) {
						return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
					})
					.addClass('alert-danger')
					.html('Fail to delete ' + selectedCategoryName + ' category.')
					.delay(5000)
					.slideUp('slow');
				}, 
				complete: function(jqXHR, status){
					$('#delete-modal').modal('hide');
				}
			});
		});
		//Centering bootstrap modal
		$('.modal').on('show.bs.modal', centerModal);
		$(window).on("resize", function () {
		    $('.modal:visible').each(centerModal);
		});
		function centerModal() {
		    $(this).css('display', 'block');
		    var $dialog = $(this).find(".modal-dialog");
		    var offset = ($(window).height() - $dialog.height()) / 2;
		    // Center modal vertically in window
		    $dialog.css("margin-top", offset);
		}
	</script>
</body>
</html>