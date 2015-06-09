<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<meta name="layout" content="default" />
<title>About us</title>
</head>
<body>
	<div class="mainContent-heading">
		<h1>About Us</h1>
	</div>
	<div class="mainContent-body">
		<p>
			Hotline: <span class="hotline"></span> <br /> Address: <span class="address"></span> <br /> Phone Number: <span class="phone"></span> <br />
			Website:<span class="url"></span>
			<br/>
			Country: <span class="country"></span>
		</p>
	</div>
	<script>
		$(document).ready(function() {

			loadPreference();

			function loadPreference(){
				$.ajax({
					url:'${createLink(controller:'preference',action:'currentPreferenceJson')}',
					type:'POST',
					dataType : 'JSON',
					beforeSend: function(){
						showLoadingStatus();
					},
					success: function(data, status, jqXHR){
						$("span.hotline").html(data.phone);
						$("span.address").html(data.address);
						$("span.phone").html(data.phone);
						$("span.url").html(data.url);
						$("span.country").html(data.country);
					},
					error: function(jqXHR, status, error){
						alert("Error:"+error);
					}, 
					complete: function(jqXHR, status){
						hideLoadingStatus();
					}
				});
			}
		});
	</script>
</body>
</html>