<%@page import="java.lang.Integer"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<meta name="layout" content="admin" />
<title>Manage Apartment</title>
<style type="text/css">
</style>
<g:javascript src="jquery.dataTables.js"></g:javascript>
<g:javascript src="dataTables.bootstrap.js"></g:javascript>
<g:javascript src="editor.js"></g:javascript>
<g:javascript src="jquery.validate.min.js"></g:javascript>
</head>
<body>
	<g:if test="${status}">
		<div id="apartment-inform-message" class="alert alert-success"
			style="display: none;" role="alert">
			${message}
		</div>
	</g:if>
	<g:else>
		<div id="apartment-inform-message" class="alert"
			style="display: none;" role="alert"></div>
	</g:else>
	<div class="row" style="padding: 15px;">
		<button onclick="initButton()" style="margin-bottom: 15px;" class="btn btn-primary"
			data-toggle="modal" data-target="#apartmentUpdate">Create
			Apartment</button>
		<div id="apartmentTableContainer">
			<table id="apartment-list" class="table table-striped table-bordered"
				cellspacing="0" width="100%">
				<thead>
					<tr>
						<td>Name</td>
						<td>Description</td>
						<td>Content</td>
						<td>Type</td>
						<td>Room No</td>
						<td>Floor</td>
						<td>Price</td>
						<td>Edit</td>
						<td>Delete</td>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="apartmentUpdate" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Save / Update</h4>
				</div>
				<form id="apartmentForm">
					<span class='hide value-floor'></span>
					<span class='hide value-facility'></span>
					<div class="modal-body">
						<span id="aparmentId" class="hide">0</span>
						<div class="form-group">
							<label for="txtName">Name</label> <input type="text" name="name"
								class="form-control" id="txtName" placeholder="Name">
						</div>
						<div class="form-group">
							<label for="textDescription">Description</label>
							<textarea id="textDescription" name="description"
								class="form-control" placeholder="Description" required></textarea>
						</div>
						<div class="form-group">
							<label for="textContent">Content</label>
							<textarea id="textContent" name="content" class="form-control"
								placeholder="Content" required></textarea>
						</div>
						<div class="form-group">
							<label for="txtRoomNo">Room No</label> <input type="text"
								name="roomNo" class="form-control" id="txtRoomNo"
								placeholder="Room No">
						</div>
						<div class="form-group">
							<label for="selectFloor">Select Floor</label> <br /> <select
								id="selectFloor">
								<%i=0%>
								<g:while test="${i < floorNumber}">
									<%i++ %>
									<option value="${i}">
										${i}
									</option>
								</g:while>
							</select>
						</div>
						<div class="form-group">
							<label for="txtPrice">Price</label> <input type="number"
								name="price" class="form-control" id="txtPrice" onkeypress='return event.charCode >= 48 && event.charCode <= 57'
								placeholder="Price">
						</div>
						<div class="form-group">
							<label for="selectFacility">Select Facility</label> <br /> <select
								id="selectFacility">
								<g:each in="${facilities}" var="item">
									<option value="${item.id}">
										${item.name}
									</option>
								</g:each>
							</select>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" id="createButton">Save
							changes</button>
						<button type="button" class="btn btn-warning" id="updateButton">Update</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog"
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
					<span class="hide delete-id">0</span> Do you want to delete
					category <strong class="item-id hidden"></strong> <strong
						class="item-name"></strong>?
				</div>
				<div class="modal-footer">
					<button id="delete-modal-agree" type="button"
						class="btn btn-primary">Yes</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">No</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			var facilityArray = getArrayFacility();
			$("textarea[name='content']").trumbowyg();
			$("textarea[name='description']").trumbowyg();
			loadAllApartment();

			//validation
			$('#apartmentForm').validate({
				rules: {
					name: { required: true },
					description : { required: true },
					content : { required: true },
					roomNo : { required: true },
					price : { required: true, number: true }
					},
				messages: {
					name: "Please input name",
					description: "Please input description",
					content : "Please input content",
					roomNo: "Invalid Room No",
					price: "Invalid price"
					}
				});

			$("#apartmentForm").on('click','#createButton',function(event){
				event.preventDefault();
				if($("#apartmentForm").valid()){
					var apartmentForm = $("#apartmentForm");
					var apartmentParams = getApartmentParameters(apartmentForm);
					createApartment(apartmentParams);
				}
			});

			function getApartmentParameters(form){
				var parameters = {}
				var id = $("#aparmentId").html();
				if(id != 0){
					parameters['id'] = id;
				}
				parameters['name'] = $.trim(form.find('input[name=name]').val());
				parameters['description'] = $.trim(form.find('textarea[name=description]').trumbowyg('html'));
				parameters['content'] = $.trim(form.find('textarea[name=content]').trumbowyg('html'));
				parameters['floor'] = $.trim(form.find('#selectFloor').val());
				parameters['roomNo'] = $.trim(form.find('input[name=roomNo]').val());
				parameters['price'] = $.trim(form.find('input[name=price]').val());
				parameters['facilityId'] = $.trim(form.find('#selectFacility').val());
				return parameters;
			}


			function loadAllApartment(){
				$.when(
						$.ajax({
							url:'${createLink(controller:'apartment',action:'showAllAsJson')}',
							type:'GET',
							beforeSend:function(){
								showLoadingStatus();
							},
							success: function(data, status, jqXHR){
								$("#apartment-list tbody").empty();
								$.each(data,function(key,value){
									var name =truncate(value.name.replace(/(<([^>]+)>)/ig,""),50);
									var description = truncate(value.description.replace(/(<([^>]+)>)/ig,""),50);
									var content = truncate(value.content.replace(/(<([^>]+)>)/ig,""),50);
									$("#apartment-list tbody").append(
										"<tr id='apartment-"+value.id+"'> "
									+	"<td class='apartment-name'>" + name + "</td>"
									+	"<td class='apartment-description'>" + description + "</td>"
									+	"<td class='apartment-content'>" + content + "</td>"
									+	"<td class='apartment-facility'>" + getFacilityName(value.facility.id,facilityArray) + "</td>"
									+	"<td class='apartment-roomno'>" + value.roomNo + "</td>"
									+	"<td class='apartment-floor'>" + value.floor + "</td>"
									+	"<td class='apartment-price'>" + value.price + "</td>"
									+	"<td class='apartment-edit' > <a href='#' onclick='viewApartment("+ value.id +")' > Edit </a></td>"
									+	"<td class='apartment-delete' ><a href='#' onclick='showDeleteModal("+ value.id +")' > Delete </a></td>"
									+	"</tr>"
									);
								});
							},
							error: function(jqXHR, status, error){
								console.log("Can't not loađ all department");
							},
							complete:function(jqXHR, status){
								hideLoadingStatus();
							}
						})
				)
				.then(function(data){
					$('#apartment-list').DataTable();
				});
			}

			function getArrayFacility(){
				var array;
				$.ajax({
					url:'${createLink(controller:'facility',action:'getAllFacilityJson')}',
					type:'GET',
					async :false,
					cache :false,
					beforeSend:function(){
						showLoadingStatus();
					},
					success: function(data, status, jqXHR){
						array = data;
					},
					error: function(jqXHR, status, error){
					},
					complete:function(jqXHR, status){
						hideLoadingStatus();
					}
				});
				return array;
			}

			function getFacilityName(facilityId,array){
				var name;
				$.each(array,function(key,value){
					if(value.id === facilityId){
						name = value.name;
					}
				});
				return name;
			}

			function createApartment(parameters){
				$.when(
						$.ajax({
							url: '${createLink(controller:'apartment', action:'create')}',
							data: parameters,
							type: 'POST',
							beforeSend: function(){
								showLoadingStatus();
							},
							success: function(data, status, jqXHR){
								if(data != 'fail'){
									$('#apartment-inform-message').slideDown('fast')
									.removeClass(function(index, css) {
										return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
									})
									.addClass('alert-success')
									.html('Create apartment '+parameters['name']+' successfully.')
									.delay(5000)
									.slideUp('slow');
								}
								else{
									$('#apartment-inform-message').slideDown('fast')
									.removeClass(function(index, css) {
										return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
									})
									.addClass('alert-danger')
									.html('Fail to create apartment '+parameters['name']+'.')
									.delay(5000)
									.slideUp('slow');
								}
							},
							error: function(jqXHR, status, error){
								$('#apartment-inform-message').slideDown('fast')
								.removeClass(function(index, css) {
									return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
								})
								.addClass('alert-danger')
								.html('Fail to create apartment '+parameters['name']+'.')
								.delay(5000)
								.slideUp('slow');
							}, 
							complete: function(jqXHR, status){
								hideLoadingStatus();
								$('#apartmentForm input[name=name]').val('');
								$('#apartmentForm textarea[name=description]').trumbowyg('html','');
								$('#apartmentForm textarea[name=content]').trumbowyg('html','');
								$('#apartmentForm input[name=price]').val('');
								$('#apartmentForm input[name=roomNo]').val('');
								$("#apartmentUpdate").modal('hide');
							}
						})
				)
				.then(function(data){
					loadAllApartment();
				});
			}

			$("#deleteModal").on('click','#delete-modal-agree',function(event){
				var apartmentId = $("#deleteModal .delete-id").html();
				deleteApartment(apartmentId);
			});

			$("#apartmentUpdate").on('click','#updateButton',function(){
				var apartmentForm = $("#apartmentForm");
				var apartmentParams = getApartmentParameters(apartmentForm);
				editApartment(apartmentParams);
			});

			function editApartment(parameters){
				$.when(
						$.ajax({
							url: '${createLink(controller:'apartment', action:'update')}',
							data : parameters,
							type: 'POST',
							beforeSend: function(){
								showLoadingStatus();
							},
							success: function(data, status, jqXHR){
								console.log("Update successfully");
							},
							error: function(jqXHR, status, error){
								console.log("Fail to update this apartment");
							}, 
							complete: function(jqXHR, status){
								hideLoadingStatus();
								$("#apartmentUpdate").modal('hide');
							}
						})
				).then(function(data){
					loadAllApartment();
				});
			}

			function deleteApartment(id){
				$.when(
						$.ajax({
							url: '${createLink(controller:'apartment', action:'delete')}',
							data: {
								id : id
							},
							type: 'POST',
							beforeSend: function(){
								showLoadingStatus();
							},
							success: function(data, status, jqXHR){
								$("#deleteModal").modal('hide');
								console.log("Delete successfully");
							},
							error: function(jqXHR, status, error){
								$('#apartment-inform-message').slideDown('fast')
								.removeClass(function(index, css) {
									return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
								})
								.addClass('alert-danger')
								.html('Fail to delete apartment' + '.')
								.delay(5000)
								.slideUp('slow');
							}, 
							complete: function(jqXHR, status){
								hideLoadingStatus();
							}
						})
				)
				.then(function(data){
					loadAllApartment();
				});
			}

		});

		function initButton(){
			$('#updateButton').hide();
			$('#createButton').show();
			$('#apartmentForm input[name=name]').val('');
			$('#apartmentForm textarea[name=description]').trumbowyg('html',' ');
			$('#apartmentForm textarea[name=content]').trumbowyg('html',' ');
			$('#apartmentForm input[name=price]').val('');
			$('#apartmentForm input[name=roomNo]').val('');
		};

		function showDeleteModal(id){
			$("#deleteModal").modal('show');
			$("#deleteModal .delete-id").html(id);
		}


		function viewApartment(id){
			$('#updateButton').show();
			$('#createButton').hide();
			$.ajax({
				url: '${createLink(controller:'apartment', action:'getAppartmentByIdJson')}',
				data: {
					id : id
				},
				type: 'GET',
				beforeSend: function(){
					showLoadingStatus();
				},
				success: function(data, status, jqXHR){
					$("span.value-facility").html(data.facility.id);
					$("#aparmentId").html(data.id);
					$('#apartmentForm input[name=name]').val(data.name);
					$('#apartmentForm textarea[name=description]').trumbowyg('html',data.description);
					$('#apartmentForm textarea[name=content]').trumbowyg('html',data.content);
					$('#apartmentForm input[name=price]').val(data.price);
					$('#apartmentForm input[name=roomNo]').val(data.roomNo);
					var optionFloor = $("#selectFloor option");
					$.each(optionFloor,function(key,value){
						if($(value).val() == data.floor ){
							$(value).attr("selected","selected");
						}
					});

					var optionFacility = $("#selectFacility option");
					$.each(optionFacility,function(key,value){
						if($(value).val()+"" == data.facility.id ){
							$(value).attr("selected","selected");
						}
					});
				},
				error: function(jqXHR, status, error){
					console.log("Fail to load data from database");	
				}, 
				complete: function(jqXHR, status){
					hideLoadingStatus();
					$("#apartmentUpdate").modal('show');
				}
			});
		}

		function truncate(str,size){
			if(str.length < size){
				return str;
			}
			else{
				return str.substring(0,size) + " ...";
			}
		}

		
	</script>
</body>
</html>