<%@page import="java.lang.Integer"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<meta name="layout" content="admin" />
<title>Manage News</title>
<style type="text/css">
</style>
<g:javascript src="jquery.dataTables.js"></g:javascript>
<g:javascript src="dataTables.bootstrap.js"></g:javascript>
<g:javascript src="editor.js"></g:javascript>
<g:javascript src="jquery.validate.min.js"></g:javascript>
</head>
<body>
	<g:if test="${status}">
		<div id="news-inform-message" class="alert alert-success"
			style="display: none;" role="alert">
			${message}
		</div>
	</g:if>
	<g:else>
		<div id="news-inform-message" class="alert"
			style="display: none;" role="alert"></div>
	</g:else>
	<div class="row" style="padding: 15px;">
		<button onclick="initButton()" style="margin-bottom: 15px;" class="btn btn-primary"
			data-toggle="modal" data-target="#newsUpdate">Create
			News</button>
		<div id="newsTableContainer">
			<table id="news-list" class="table table-striped table-bordered"
				cellspacing="0" width="100%">
				<thead>
					<tr>
						<td>Title</td>
						<td>Description</td>
						<td>Content</td>
						<td>Tag</td>
						<td>Category</td>
						<td>Author</td>
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
	<div class="modal fade" id="newsUpdate" tabindex="-1"
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
				<form id="newsForm">
					<span class='hide value-category'></span>
					<div class="modal-body">
						<span id="newsId" class="hide">0</span>
						<div class="form-group">
							<label for="txtTitle">Title</label> <input type="text" name="title"
								class="form-control" id="txtTitle" placeholder="Title">
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
							<label for="txtRoomNo">Tag</label> <input type="text"
								name="tag" class="form-control" id="tag"
								placeholder="Tag">
						</div>
						<div class="form-group">
							<label for="selectCategory">Select Category</label> <br /> <select
								id="selectCategory">
								<g:each in="${categories}" var="item">
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
			var categoryArray = getArrayCategory();
			$("textarea[name='content']").trumbowyg();
			$("textarea[name='description']").trumbowyg();
			loadAllNews();

			$('#newsForm').validate({
				rules: {
					title: { required: true },
					description : { required: true },
					content : { required: true },
					tag : { required: true },
					},
				messages: {
					name: "Please input name",
					description: "Please input description",
					content : "Please input c",
					tag: "Invalid Tag",
					},
				});

			$("#newsForm").on('click','#createButton',function(event){
				event.preventDefault();
				if($("#newsForm").valid()){
					var newsForm = $("#newsForm");
					var newsParams = getNewsParameters(newsForm);
					createNews(newsParams);
				}
			});

			function getNewsParameters(form){
				var parameters = {}
				var id = $("#newsId").html();
				if(id != 0){
					parameters['id'] = id;
				}
				parameters['title'] = $.trim(form.find('input[name=title]').val());
				parameters['description'] = $.trim(form.find('textarea[name=description]').trumbowyg('html'));
				parameters['content'] = $.trim(form.find('textarea[name=content]').trumbowyg('html'));
				parameters['tag'] = $.trim(form.find('input[name=tag]').val());
				parameters['catId'] = $.trim(form.find('#selectCategory').val());
				return parameters;
			}

			function loadAllNews(){
				$.when(
						$.ajax({
							url:'${createLink(controller:'news',action:'showAllAsJson')}',
							type:'GET',
							beforeSend:function(){
								showLoadingStatus();
							},
							success: function(data, status, jqXHR){
								$("#news-list tbody").empty();
								$.each(data,function(key,value){
									var title = truncate(value.title.replace(/(<([^>]+)>)/ig,""),50);
									var description = truncate(value.description.replace(/(<([^>]+)>)/ig,""),50);
									var content = truncate(value.content.replace(/(<([^>]+)>)/ig,""),50);
									$("#news-list tbody").append(
										"<tr id='news-"+value.id+"'> "
									+	"<td class='news-title'>" + title + "</td>"
									+	"<td class='news-description'>" + description + "</td>"
									+	"<td class='news-content'>" + content + "</td>"
									+	"<td class='news-tag'>" + value.tag + "</td>"
									+	"<td class='news-category'>" + getCategoryName(value.category.id,categoryArray) + "</td>"
									+	"<td class='news-author'>" + value.author.id + "</td>"
									+	"<td class='news-edit' > <a href='#' onclick='viewNews("+ value.id +")' > Edit </a></td>"
									+	"<td class='news-delete' ><a href='#' onclick='showDeleteModal("+ value.id +")' > Delete </a></td>"
									+ 	"</tr>"
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
					$('#news-list').DataTable();
				});
			}

			function getArrayCategory(){
				var array;
				$.ajax({
					url:'${createLink(controller:'category',action:'showAllCatNewJson')}',
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

			function getCategoryName(categoryId,array){
				var name;
				$.each(array,function(key,value){
					if(value.id === categoryId){
						name = value.name;
					}
				});
				return name;
			}

			function createNews(parameters){
				$.when(
						$.ajax({
							url: '${createLink(controller:'news', action:'create')}',
							data: parameters,
							type: 'POST',
							beforeSend: function(){
								showLoadingStatus();
							},
							success: function(data, status, jqXHR){
								if(data != 'fail'){
									$('#news-inform-message').slideDown('fast')
									.removeClass(function(index, css) {
										return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
									})
									.addClass('alert-success')
									.html('Create news '+parameters['title']+' successfully.')
									.delay(5000)
									.slideUp('slow');
								}
								else{
									$('#news-inform-message').slideDown('fast')
									.removeClass(function(index, css) {
										return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
									})
									.addClass('alert-danger')
									.html('Fail to create news '+parameters['title']+'.')
									.delay(5000)
									.slideUp('slow');
								}
							},
							error: function(jqXHR, status, error){
								$('#news-inform-message').slideDown('fast')
								.removeClass(function(index, css) {
									return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
								})
								.addClass('alert-danger')
								.html('Fail to create news '+parameters['title']+'.')
								.delay(5000)
								.slideUp('slow');
							}, 
							complete: function(jqXHR, status){
								hideLoadingStatus();
								$('#newsForm input[name=title]').val('');
								$('#newsForm textarea[name=description]').trumbowyg('html','');
								$('#newsForm textarea[name=content]').trumbowyg('html','');
								$('#newsForm input[name=tag]').val('');
								$("#newsUpdate").modal('hide');
							}
						})
				)
				.then(function(data){
					loadAllNews();
				});
			}

			$("#deleteModal").on('click','#delete-modal-agree',function(event){
				var newsId = $("#deleteModal .delete-id").html();
				deleteNews(newsId);
			});

			$("#newsUpdate").on('click','#updateButton',function(){
				var newsForm = $("#newsForm");
				var newsParams = getNewsParameters(newsForm);
				editNews(newsParams);
			});

			function editNews(parameters){
				$.when(
						$.ajax({
							url: '${createLink(controller:'news', action:'update')}',
							data : parameters,
							type: 'POST',
							beforeSend: function(){
								showLoadingStatus();
							},
							success: function(data, status, jqXHR){
								console.log("Update successfully");
							},
							error: function(jqXHR, status, error){
								console.log("Fail to update this news");
							}, 
							complete: function(jqXHR, status){
								hideLoadingStatus();
								$("#newsUpdate").modal('hide');
							}
						})
				).then(function(data){
					loadAllNews();
				});
			}

			function deleteNews(id){
				$.when(
						$.ajax({
							url: '${createLink(controller:'news', action:'delete')}',
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
								$('#news-inform-message').slideDown('fast')
								.removeClass(function(index, css) {
									return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
								})
								.addClass('alert-danger')
								.html('Fail to delete news' + '.')
								.delay(5000)
								.slideUp('slow');
							}, 
							complete: function(jqXHR, status){
								hideLoadingStatus();
							}
						})
				)
				.then(function(data){
					loadAllNews();
				});
			}

		});

		function initButton(){
			$('#updateButton').hide();
			$('#createButton').show();
			$('#newsForm input[name=title]').val('');
			$('#newsForm textarea[name=description]').trumbowyg('html',' ');
			$('#newsForm textarea[name=content]').trumbowyg('html',' ');
			$('#newsForm input[name=price]').val('');
			$('#newsForm input[name=roomNo]').val('');
		};

		function showDeleteModal(id){
			$("#deleteModal").modal('show');
			$("#deleteModal .delete-id").html(id);
		}


		function viewNews(id){
			$('#updateButton').show();
			$('#createButton').hide();
			$.ajax({
				url: '${createLink(controller:'news', action:'getNewsByIdJson')}',
				data: {
					id : id
				},
				type: 'GET',
				beforeSend: function(){
					showLoadingStatus();
				},
				success: function(data, status, jqXHR){
					$("span.value-category").html(data.category.id);
					$("#newsId").html(data.id);
					$('#newsForm input[name=title]').val(data.title);
					$('#newsForm textarea[name=description]').trumbowyg('html',data.description);
					$('#newsForm textarea[name=content]').trumbowyg('html',data.content);
					$('#newsForm input[name=tag]').val(data.tag);
					var optionCategory = $("#selectCategory option");
					$.each(optionCategory,function(key,value){
						if($(value).val() == data.category.id ){
							$(value).attr("selected","selected");
						}
					});

				},
				error: function(jqXHR, status, error){
					console.log("Fail to load data from database");	
				}, 
				complete: function(jqXHR, status){
					hideLoadingStatus();
					$("#newsUpdate").modal('show');
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