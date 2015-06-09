<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<meta name="layout" content="default" />
<title>${category.name}</title>
<style>
	.news{
		border-bottom: 1px dashed grey;
		margin: 15px;
	}
	.news span.title{
		font-weight: bold;
		font-family: "Times New Roman", Georgia, Serif;
		font-size: 18px;
		color: blue;
	}
	
	.news div.description{
		font-weight: 400;
		font-family: "Times New Roman", Georgia, Serif;
		font-size: 12px;
		color: black;
	}
	
	.news span.dateCreated{
		font-family: "Times New Roman", Georgia, Serif;
		font-size: 12px;
		color : black;
	}
	
	.news span.error{
		font-family: "Times New Roman", Georgia, Serif;
		font-size: 12px;
		color : red;
	}
	
	.news #readMoreBtn{
		margin-top: 10px;
		margin-bottom : 10px;
	}
	
	#newsDetail .title{
		font-weight: bold;
		font-family: "Times New Roman", Georgia, Serif;
		font-size: 18px;
		color: blue;
	}
	
	#newsDetail .description{
		font-weight: 400;
		font-family: "Times New Roman", Georgia, Serif;
		font-size: 12px;
		color: black;
	}
	
	#newsDetail .content{
		font-weight: lighter;
		font-family: "Times New Roman", Georgia, Serif;
		font-size: 12px;
		color: black;
	}
	
	#newsDetail .dateCreated{
		font-weight: lighter;
		font-family: "Times New Roman", Georgia, Serif;
		font-size: 12px;
		color: black;
	}
	
	#newsDetail .tag{
		font-weight: 400;
		font-family: "Times New Roman", Georgia, Serif;
		font-size: 12px;
		color: blue;
	}
	
</style>
<g:javascript src="moment.min.js"></g:javascript>
</head>
<body>
	<div class="mainContent-heading">
		<span class='hide' id='catId'>${category.id}</span>
		<h3>Show New In Category : ${category.name}</h3>
		<hr/>
	</div>
	<div class="mainContent-body">
		<div class='row showNews'>
		</div>
	</div>
	
	<!--  Display Modal Detail -->
	<div class="modal fade" id="newsDetail" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">News Deatails</h4>
				</div>
				<div class="modal-body">
					<span class='title'>abc</span><br/>
					<div class='description'>abc</div>
					<div class='content'>abc</div>
					<span class='dateCreated'>abc</span><br/>
					<span class='tag'>abc</span><br/>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function() {
			var catId = $('.mainContent-heading #catId').html();
			loadNews(catId);
		});

		function viewNews(id){
			$.ajax({
				url:"${createLink(controller:'news',action:'getNewsByIdJson')}",
				data:{
					id : id
				},
				async : false,
				cache :false,
				type: 'GET',
				beforeSend: function(){
					showLoadingStatus();
				},
				success: function(data, status, jqXHR){
					$('#newsDetail .title').html(data.title);
					$('#newsDetail .description').html(data.description);
					$('#newsDetail .content').html(data.content);
					$('#newsDetail .dateCreated').html(data.dateCreated);
					$('#newsDetail .tag').html(data.tag);
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

		function showModal(id){
			$("#newsDetail").modal('show');
			viewNews(id);
		}

		function loadNews(catId){
			$.ajax({
				url:"${createLink(controller:'news',action:'showNewByCategoryasJson')}",
				data:{
					catId : catId
				},
				async:false,
				cache:false,
				type: 'GET',
				beforeSend: function(){
					showLoadingStatus();
				},
				success: function(data, status, jqXHR){
					$('.showNews').empty();
					$.each(data,function(key,value){
						$('.showNews').append(
								"<div class='news col-md-12'>"
							+	"<span class='title'>" + value.title + "</span><br/>"
							+	"<div class='description'>" + value.description + "</div>"
							+	"<span class='dateCreated'>" + value.dateCreated + "</span><br/>"
							+	"<button id='readMoreBtn' class='btn btn-danger btn-xs' onclick='showModal("+value.id+")'>Read more ..</button>"
							+	"</div>"
						);
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
	</script>
</body>
</html>