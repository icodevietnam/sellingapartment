<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<meta name="layout" content="admin" />
<title>Manage Facility</title>
<g:javascript src="jquery.dataTables.js"></g:javascript>
<g:javascript src="dataTables.bootstrap.js"></g:javascript>
<g:javascript src="jquery.validate.min.js"></g:javascript>
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'dataTables.bootstrap.css')}"
	type="text/css">
<style type="text/css">
#facilityTableContainer, #facilityFormContainer {
	float: left;
	padding: 10px;
}

#facilityTableContainer {
	width: 75%;
}

#facilityFormContainer {
	width: 25%;
}
</style>
</head>
<body>
	<div id="facilityTableContainer">
		<table id="facility-list" class="table table-striped table-bordered"
			cellspacing="0" width="100%">
			<thead>
				<tr>
					<td>Name</td>
					<td>Description</td>
					<td>Type</td>
					<td>Delete</td>
					<td>Edit</td>
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
						<td class="facility-description">
							${facilityItem.type}
						</td>
						<td class="facility-edit"><a href="#">Edit</a></td>
						<td class="facility-delete"><a href="#">Delete</a></td>
					</tr>
				</g:each>
			</tbody>
		</table>
	</div>
	<div id="facilityFormContainer">
		<g:if test="${status}">
			<div id="facility-inform-message" class="alert alert-success"
				style="display: none;" role="alert">
				${message}
			</div>
		</g:if>
		<g:else>
			<div id="facility-inform-message" class="alert"
				style="display: none;" role="alert"></div>
		</g:else>
		<div id="facilityFormFolder">
			<form id="facility-form" >
				<p>
					<label for="name">Name:</label> <input
						class="form-control input-sm" type="text" name="name"  />
				</p>
				<p>
					<label for="description">Description:</label> <input
						class="form-control input-sm" type="text" name="description" />
				</p>
				<p>
					<label for="description">Type:</label> <select name="type"
						id="selectType"
						style="width: 100%; height: 30px; border-radius: 3px">
						<option value="apartment">Apartment</option>
						<option value="supermarket">Super market</option>
						<option value="bank">Bank</option>
						<option value="preschool">Pre school</option>
						<option value="englishcentre">English Centre</option>
					</select>
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
					Do you want to delete facility <strong class="item-id hidden"></strong>
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
			var table = $('#facility-list').DataTable();
			if($('#facility-inform-message').html() != ''){
				$('#facility-inform-message').slideDown('fast')
				.delay(5000)
				.slideUp('slow');
			}
			//validation
			$('#facility-form').validate({
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
		//handle click create
		$('#facility-form').on('click', '#createButton', function(event){
			event.preventDefault();
			if($('#facility-form').valid()){
				var facilityForm = $('#facility-form');
				var facilityParams = getFacilityParameters(facilityForm);
				createFacility(facilityParams);
			}
		});
		
		function getFacilityParameters(form){
			var parameters = {}
			parameters['name'] = $.trim(form.find('input[name=name]').val());
			parameters['description'] = $.trim(form.find('input[name=description]').val());
			parameters['type'] = $.trim(form.find('#selectType').val());
			return parameters;
		}
		function createFacility(parameters){
			$.ajax({
				url: '${createLink(controller:'facility', action:'create')}',
				data: parameters,
				type: 'POST',
				beforeSend: function(){
					showLoadingStatus();
				},
				success: function(data, status, jqXHR){
					if(data != 'fail'){
						$('#facilityTableContainer').html(data);
						table = $('#facility-list').DataTable();
						$('#facility-inform-message').slideDown('fast')
						.removeClass(function(index, css) {
							return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
						})
						.addClass('alert-success')
						.html('Create facility '+parameters['name']+' successfully.')
						.delay(5000)
						.slideUp('slow');
					}
					else{
						$('#facility-inform-message').slideDown('fast')
						.removeClass(function(index, css) {
							return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
						})
						.addClass('alert-danger')
						.html('Fail to create facility '+parameters['name']+'.')
						.delay(5000)
						.slideUp('slow');
					}
				},
				error: function(jqXHR, status, error){
					$('#facility-inform-message').slideDown('fast')
					.removeClass(function(index, css) {
						return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
					})
					.addClass('alert-danger')
					.html('Fail to create facility '+parameters['name']+'.')
					.delay(5000)
					.slideUp('slow');
				}, 
				complete: function(jqXHR, status){
					hideLoadingStatus();
					$('#facility-form input[name=name]').val('');
					$('#facility-form input[name=description]').val('');
				}
			});
		}
		//handle click edit facility
		$('#facilityTableContainer').on('click', '.facility-edit', function(event){
			event.preventDefault();
			var selectedFacilityId = getFacilityIdForEditing($(this));
			var selectedFacilityName = getFacilityNameForEditing($(this));
			editFacility(selectedFacilityId, selectedFacilityName);
		});
		function getFacilityIdForEditing(information){
			return parseInt($.trim(information.parent().attr('id').split(/facility-/g)[1]));
		}
		function getFacilityNameForEditing(information){
			return $.trim(information.parent().find('.facility-name').html());
		}
		function editFacility(facilityId, facilityName){
			$.ajax({
				url: '${createLink(controller:'facility', action:'edit')}',
				data: {'id': facilityId},
				type: 'GET',
				beforeSend: function(){
					showLoadingStatus();
				},
				success: function(data, status, jqXHR){
					$('#facilityFormFolder').html(data);
				},
				error: function(jqXHR, status, error){
					$('#facility-inform-message').slideDown('fast')
					.removeClass(function(index, css) {
						return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
					})
					.addClass('alert-danger')
					.html('Facility ' + facilityName + ' is not available.')
					.delay(5000)
					.slideUp('slow');
				},
				complete: function(){
					hideLoadingStatus();
				}
			});
		}
		
		//handle click delete facility
		$('#facilityTableContainer').on('click', '.facility-delete', function(event){
			event.preventDefault();
			var selectedFacilityId = getFacilityIdForEditing($(this));
			var selectedFacilityName = getFacilityNameForEditing($(this));
			showConfirmation(selectedFacilityId, selectedFacilityName);
		});
		function showConfirmation(facilityId, facilityName){
			$('#delete-modal .modal-body .item-name').html($.trim(facilityName));
			$('#delete-modal .modal-body .item-id').html($.trim(facilityId));
			$('#delete-modal').modal('show');
		}
		$('#delete-modal-agree').on('click', function(){
			var selectedFacilityId = $.trim($('#delete-modal .modal-body .item-id').html());
			var selectedFacilityName = $.trim($('#delete-modal .modal-body .item-name').html());
			$.ajax({
				url: '${createLink(controller:'facility', action:'delete')}',
				data: {'id': selectedFacilityId, 'name': selectedFacilityName},
				type: 'POST',
				success: function(data, status, jqXHR){
					if(data != 'fail'){
						$('#facilityTableContainer').html(data);
						table = $('#facility-list').DataTable();
						$('#facility-inform-message').slideDown('fast')
						.removeClass(function(index, css) {
							return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
						})
						.addClass('alert-success')
						.html('Delete facility ' + selectedFacilityName + ' successfully.')
						.delay(5000)
						.slideUp('slow');
					}
					else{
						$('#facility-inform-message').slideDown('fast')
						.removeClass(function(index, css) {
							return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
						})
						.addClass('alert-danger')
						.html('Fail to delete facility ' + selectedFacilityName + '.')
						.delay(5000)
						.slideUp('slow');
					}
				},
				error: function(jqXHR, status, error){
					$('#facility-inform-message').slideDown('fast')
					.removeClass(function(index, css) {
						return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
					})
					.addClass('alert-danger')
					.html('Fail to delete ' + selectedFacilityName + ' facility.')
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