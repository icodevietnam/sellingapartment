<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<meta name="layout" content="default" />
<title>Apartment</title>
<style type="text/css">
.showApartment {
	margin: 5px;
}

.apartment {
	border: 1px dashed silver;
	margin-left: 30px;
	margin-top: 2px;
	margin-right: 5px;
	margin-bot: 5px;
	cursor: pointer;
	margin-top: 10px;
	cursor: pointer;
	height: 350px;
}

.apartment span.name {
	margin-top: 10px;
	display: block;
	color: blue;
	font-weight: bold;
	text-align: center;
	font-size: 12px;
	height: 60px;
	display: block;
}

.apartment div.description {
	width: 100%;
	text-align: center;
	overflow: auto;
}

div.show-floor {
	font-weight: bold;
	color: blue;
	display: inline;
	float: left;
}

div.show-price {
	font-weight: bold;
	color: blue;
	display: inline;
	float: right;
}

.show-price .price {
	font-weight: bold;
	color: red;
	margin-left: 5px;
	float: right;
}

.show-price h6 {
	color: red;
	display: inline;
}

.form-action {
	margin-top: 15px;
	padding-left: 95px;
	margin-bottom: 10px;
}

span.error {
	color: red;
	font-size: 12px;
}

.form-action #orderBtn {
	
}

#apartmentDetail span.name {
	font-weight: bold;
	font-family: "Times New Roman", Georgia, Serif;
	font-size: 18px;
	color: blue;
}

#apartmentDetail .description {
	font-weight: 400;
	font-family: "Times New Roman", Georgia, Serif;
	font-size: 12px;
	color: black;
}

#apartmentDetail .content {
	font-weight: lighter;
	font-family: "Times New Roman", Georgia, Serif;
	font-size: 12px;
	color: black;
}

#apartmentDetail span.floor {
	margin-left: 10px;
	display: bold;
	font-weight: lighter;
	font-family: "Times New Roman", Georgia, Serif;
	font-size: 16px;
	color: black;
}

#apartmentDetail span.roomNo {
	margin-left: 10px;
	display: bold;
	font-weight: 400;
	font-family: "Times New Roman", Georgia, Serif;
	font-size: 16px;
	color: blue;
}

#apartmentDetail span.price {
	margin-left: 10px;
	display: block;
	font-weight: bold;
	font-family: "Times New Roman", Georgia, Serif;
	font-size: 16px;
	color: red;
	display: block;
}

#apartmentDetail modal-content {
	overflow: auto;
}
</style>
</head>
<body>
	<div class="mainContent-heading">
		<h3>Search Apartment</h3>
		<form id="searchForm" class="form-inline">
			<div class="form-group">
				<select class="form-control" id="selectFloor">
					<option value="0">Select Floor...</option>
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
				<select class="form-control" id="selectFacility">
					<option value="0">Select Facility...</option>
					<g:each in="${facilities}" var="item">
						<option value="${item.id}">
							${item.name}
						</option>
					</g:each>
				</select>
			</div>
			<div class="form-group">
				<input type="number"
					onkeypress='return event.charCode >= 48 && event.charCode <= 57'
					class="form-control" id="txtFromPrice" value='0' name="fromPrice"
					placeholder="From Price">
			</div>
			<div class="form-group">
				<input value='0' type="number"
					onkeypress='return event.charCode >= 48 && event.charCode <= 57'
					class="form-control" id="txtToPrice" name="toPrice"
					placeholder="To Price">
			</div>
			<br />
			<button style="margin-top: 10px;" id='searchBtn'
				class="btn btn-primary">Search Apartment</button>
		</form>
		<span class='error'></span>
		<hr />
	</div>
	<div class="mainContent-body">
		<div class="row showApartment">
			<h3>Apartment</h3>

		</div>
	</div>
	<!--  Display Modal Detail -->
	<div class="modal fade" id="apartmentDetail" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Apartment Details</h4>
				</div>
				<div class="modal-body">
					<span class="hide" id="apartmentId">0</span> <span class='name'>Test Data</span><br />
					<div class='description'>Test Data</div>
					<div class='content'>Test Data</div>
					<span class='roomNo'>Test Data</span><br /> <span class='floor'>Test
						Data</span><br /> <span class='price'>Test Data</span><br />
				</div>
			</div>
		</div>
	</div>


	<!--  Display Modal Detail -->
	<div class="modal fade" id="orderModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Order Infomation</h4>
				</div>
				<div class="modal-body">
					<span class="hide" id="emailApartmentId">0</span> 
					Do you want to orders this apartment ? 
					<span class='name'>Test Data</span>
					<div class='description'>Test Data</div>
					<span class='roomNo'>Test Data</span><br /> 
					<span class='floor'>Test
						Data</span><br /> 
					<span class='price'>Test Data</span><br />
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-warning" id="orderBtn">Order
						And Send Email</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function(){
			loadAllApartment();
			var $searchForm = $('#searchForm');
			$("#orderModal").on('click','#orderBtn',function(){
				event.preventDefault();
				var toEmail = '${currentUser.email}';
				var name = 'Dear ${currentUser.firstName} ${currentUser.lastName}';
				var apartmentName = $("#orderModal span.name").html();
				var apartmentRoomNo= $("#orderModal span.roomNo").html();
				var apartmentFloor = $("#orderModal span.floor").html();
				var apartmentPrice = $("#orderModal span.price").html();
				var subject = "Orders " + apartmentName;
				var content = " Dear "+ name + ",\n You ordered 1 apartment from us. Selling Apartment.com\n"
							+ " Detail your order:\n"
							+ "Apartment name :" + apartmentName +"\n"
							+ "Apartment Room No :" + apartmentRoomNo +"\n"
							+ "Apartment Floor :" + apartmentFloor +"\n"
							+ "Apartment Price :" + apartmentPrice +"\n"
				
				$.ajax({
					url:'${createLink(controller:'mail',action:'testMail')}',
					type:'GET',
					data : {
						to : toEmail,
						subject : subject,
						content:content
					},
					beforeSend:function(){
						showLoadingStatus();
					},
					success: function(data, status, jqXHR){
						if(data == 'true'){
							alert("Email send successfully");
						}
						else{
							alert("Email send failed");
						}
						$("#orderModal").modal("hide");
					},
					error: function(jqXHR, status, error){
						console.log("Can't not load all department");
					},
					complete:function(jqXHR, status){
						hideLoadingStatus();
					}
				})
				
			});
			
			$searchForm.on('click','#searchBtn',function(event){
				event.preventDefault();
				var floor = $('#selectFloor').val();
				var facility = $('#selectFacility').val();
				var fromPrice = $('#searchForm input[name = fromPrice]').val();
				var toPrice = $('#searchForm input[name = toPrice]').val();
				if(floor == 0 && facility != 0 && fromPrice == 0 && toPrice ==0){
					$('span.error').html('');
					$(".showApartment").empty();
					$.each(dataLoading,function(key,value){
						if(value.facility.id == facility){
							$(".showApartment").append(
									"<div class='col-md-5 apartment'>"
								+	"<span class='name' onclick='showDetail("+value.id+");'>" + value.name + "</span>"
								+	"<div class='description' onclick='showDetail("+value.id+");'> " + value.description + "</div>"
								+	"<div class='show-floor'>Floor:<span class='floor'>" + value.floor + "</span></div>"
								+	"<div class='show-price'>Price:<span class='price'>" + value.price + "<h6> USD </h6></span></div>"
								+	"<div class='form-action'><button onclick='showOrder("+value.id+");'style='margin-top:20px;' class='btn btn-primary'> Orders </button></div>"
								+	"</div>"
								);
						}
					});
				}
				else if(floor == 0 && facility != 0 && fromPrice != 0 && toPrice !=0 ){
					$('span.error').html('');
					$(".showApartment").empty();
					$.each(dataLoading,function(key,value){
						if(value.facility.id == facility && value.price >= fromPrice && value.price <= toPrice ){
							$(".showApartment").append(
									"<div class='col-md-5 apartment'>"
								+	"<span class='name' onclick='showDetail("+value.id+");'>" + value.name + "</span>"
								+	"<div class='description' onclick='showDetail("+value.id+");'> " + value.description + "</div>"
								+	"<div class='show-floor'>Floor:<span class='floor'>" + value.floor + "</span></div>"
								+	"<div class='show-price'>Price:<span class='price'>" + value.price + "<h6> USD </h6></span></div>"
								+	"<div class='form-action'><button onclick='showOrder("+value.id+");'style='margin-top:20px;' class='btn btn-primary'> Orders </button></div>"
								+	"</div>"
								);
						}
					});
				}
				if(floor != 0 && facility == 0 && fromPrice == 0 && toPrice ==0){
					$('span.error').html('');
					$(".showApartment").empty();
					$.each(dataLoading,function(key,value){
						if(value.floor == floor){
							$(".showApartment").append(
									"<div class='col-md-5 apartment'>"
								+	"<span class='name' onclick='showDetail("+value.id+");'>" + value.name + "</span>"
								+	"<div class='description' onclick='showDetail("+value.id+");'> " + value.description + "</div>"
								+	"<div class='show-floor'>Floor:<span class='floor'>" + value.floor + "</span></div>"
								+	"<div class='show-price'>Price:<span class='price'>" + value.price + "<h6> USD </h6></span></div>"
								+	"<div class='form-action'><button onclick='showOrder("+value.id+");'style='margin-top:20px;' class='btn btn-primary'> Orders </button></div>"
								+	"</div>"
								);
						}
					});
				}
				else if(floor != 0 && facility == 0 && fromPrice != 0 && toPrice !=0 ){
					$('span.error').html('');
					$(".showApartment").empty();
					$.each(dataLoading,function(key,value){
						if(value.floor == floor && value.price >= fromPrice && value.price <= toPrice ){
							$(".showApartment").append(
									"<div class='col-md-5 apartment'>"
								+	"<span class='name' onclick='showDetail("+value.id+");'>" + value.name + "</span>"
								+	"<div class='description' onclick='showDetail("+value.id+");'> " + value.description + "</div>"
								+	"<div class='show-floor'>Floor:<span class='floor'>" + value.floor + "</span></div>"
								+	"<div class='show-price'>Price:<span class='price'>" + value.price + "<h6> USD </h6></span></div>"
								+	"<div class='form-action'><button onclick='showOrder("+value.id+");'style='margin-top:20px;' class='btn btn-primary'> Orders </button></div>"
								+	"</div>"
								);
						}
					});
				}
				if(floor == 0 && facility == 0 && fromPrice == 0 && toPrice == 0){
					$('span.error').html('');
					$(".showApartment").empty();
					$.each(dataLoading,function(key,value){
							$(".showApartment").append(
									"<div class='col-md-5 apartment'>"
								+	"<span class='name' onclick='showDetail("+value.id+");'>" + value.name + "</span>"
								+	"<div class='description' onclick='showDetail("+value.id+");'> " + value.description + "</div>"
								+	"<div class='show-floor'>Floor:<span class='floor'>" + value.floor + "</span></div>"
								+	"<div class='show-price'>Price:<span class='price'>" + value.price + "<h6> USD </h6></span></div>"
								+	"<div class='form-action'><button onclick='showOrder("+value.id+");'style='margin-top:20px;' class='btn btn-primary'> Orders </button></div>"
								+	"</div>"
								);
					});
				}else if(floor == 0 && facility == 0 && fromPrice != 0 && toPrice !=0){
					$('span.error').html('');
					$(".showApartment").empty();
					$.each(dataLoading,function(key,value){
							if(value.price >= fromPrice && value.price <= toPrice){
								$(".showApartment").append(
										"<div class='col-md-5 apartment'>"
									+	"<span class='name' onclick='showDetail("+value.id+");'>" + value.name + "</span>"
									+	"<div class='description' onclick='showDetail("+value.id+");'> " + value.description + "</div>"
									+	"<div class='show-floor'>Floor:<span class='floor'>" + value.floor + "</span></div>"
									+	"<div class='show-price'>Price:<span class='price'>" + value.price + "<h6> USD </h6></span></div>"
									+	"<div class='form-action'><button onclick='showOrder("+value.id+");'style='margin-top:20px;' class='btn btn-primary'> Orders </button></div>"
									+	"</div>"
								);
							}
					});
				}else if(floor != 0 && facility != 0 && fromPrice != 0 && toPrice !=0){
					$('span.error').html('');
					$(".showApartment").empty();
					$.each(dataLoading,function(key,value){
							if(value.floor == floor && value.facility.id == facility && value.price >= fromPrice && value.price <= toPrice){
								$(".showApartment").append(
										"<div class='col-md-5 apartment'>"
									+	"<span class='name' onclick='showDetail("+value.id+");'>" + value.name + "</span>"
									+	"<div class='description' onclick='showDetail("+value.id+");'> " + value.description + "</div>"
									+	"<div class='show-floor'>Floor:<span class='floor'>" + value.floor + "</span></div>"
									+	"<div class='show-price'>Price:<span class='price'>" + value.price + "<h6> USD </h6></span></div>"
									+	"<div class='form-action'><button onclick='showOrder("+value.id+");' style='margin-top:20px;' class='btn btn-primary'> Orders </button></div>"
									+	"</div>"
								);
							}
					});
				}
				if(fromPrice == '' && toPrice != ''|| fromPrice != '' && toPrice == ''){
					$('span.error').html('From Price and To Price can not have single value');
				}
				if(fromPrice > toPrice){
					$('span.error').html('From Price can not bigger than To Price ');
				}
			});
		});

		var dataLoading;
		
		function showDetail(id){
			$('#apartmentId').html(id);
			
			$('#apartmentDetail').modal('show');
			$.ajax({
				url:'${createLink(controller:'apartment',action:'getAppartmentByIdJson')}',
				type:'GET',
				async :false,
				cache:false,
				data : {
					id : id,
				},
				beforeSend:function(){
					showLoadingStatus();
				},
				success: function(data, status, jqXHR){
					$("#apartmentDetail span.name").html(data.name);
					$("#apartmentDetail div.description").html(data.description);
					$("#apartmentDetail div.content").html(data.content);
					$("#apartmentDetail span.roomNo").html("Room No:"+ data.roomNo);
					$("#apartmentDetail span.floor").html("Floor:" + data.floor);
					$("#apartmentDetail span.price").html("Price:"+ data.price);
					
				},
				error: function(jqXHR, status, error){
					console.log("Can't not loađ all department");
				},
				complete:function(jqXHR, status){
					hideLoadingStatus();
				}
			})
		}

		function showOrder(id){
			$('#emailApartmentId').html(id);
			$("#orderModal").modal("show");

			$.ajax({
				url:'${createLink(controller:'apartment',action:'getAppartmentByIdJson')}',
				type:'GET',
				async :false,
				cache:false,
				data : {
					id : id,
				},
				beforeSend:function(){
					showLoadingStatus();
				},
				success: function(data, status, jqXHR){
					$("#orderModal span.name").html(data.name);
					$("#orderModal div.description").html(data.description);
					$("#orderModal span.roomNo").html("Room No:"+ data.roomNo);
					$("#orderModal span.floor").html("Floor:" + data.floor);
					$("#orderModal span.price").html("Price:"+ data.price);
				},
				error: function(jqXHR, status, error){
					console.log("Can't not loađ all department");
				},
				complete:function(jqXHR, status){
					hideLoadingStatus();
				}
			})
			
		}

		function showApartments(data){
			$(".showApartment").empty();
			$.each(data,function(key,value){
				$(".showApartment").append(
					"<div class='col-md-5 apartment'>"
				+	"<span class='name' onclick='showDetail("+value.id+");'>" + value.name + "</span>"
				+	"<div class='description' onclick='showDetail("+value.id+");'> " + value.description + "</div>"
				+	"<div class='show-floor'>Floor:<span class='floor'>" + value.floor + "</span></div>"
				+	"<div class='show-price'>Price:<span class='price'>" + value.price + "<h6> USD </h6></span></div>"
				+	"<div class='form-action'><button onclick='showOrder("+value.id+");' style='margin-top:20px;' class='btn btn-primary'> Orders </button></div>"
				+	"</div>"
				);
			});
		}
		
		function loadAllApartment(){
			$.ajax({
				url:'${createLink(controller:'apartment',action:'showAllAsJson')}',
				type:'GET',
				async :false,
				cache:false,
				beforeSend:function(){
					showLoadingStatus();
				},
				success: function(data, status, jqXHR){
					dataLoading = data;
					showApartments(data);
				},
				error: function(jqXHR, status, error){
					console.log("Can't not loađ all department");
				},
				complete:function(jqXHR, status){
					hideLoadingStatus();
				}
			})
		}

	</script>
</body>
</html>