<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<meta name="layout" content="default" />
<title>Home</title>
<script
	src="http://maps.googleapis.com/maps/api/js?key=AIzaSyD8CmzeCN0zgID6zEFXYUusXE7Svlm-_8E"></script>
</head>
<body>
	<div class="mainContent-heading">
		<h1>Introduction</h1>
	</div>
	<div class="mainContent-body"></div>
	<div class="mainContent-heading">
		<h1>Location</h1>
		<div id="map" style="height: 512px;">
			<noscript>
				<!-- http://code.google.com/apis/maps/documentation/staticmaps/ -->
				<img
					src="http://maps.google.com/maps/api/staticmap?center=1%20infinite%20loop%20cupertino%20ca%2095014&amp;zoom=16&amp;size=512x512&amp;maptype=roadmap&amp;sensor=false" />
			</noscript>
		</div>
	</div>
	<script>
  	$(document).ready(function() {
		loadPreference();
		function loadPreference(){
			//Create a new geocoder
			var geocoder = new google.maps.Geocoder();
			$.ajax({
				url:'${createLink(controller:'preference',action:'currentPreferenceJson')}',
				type:'POST',
				dataType : 'JSON',
				beforeSend: function(){
					showLoadingStatus();
				},
				success: function(data, status, jqXHR){
					$(".mainContent-body").html(data.features);
					var address = data.address;
					//Locate the address using geocoder
					geocoder.geocode({'address':address},function(results,status){
						//If the geocoder was successful
						if(status ==  google.maps.GeocoderStatus.OK){
							// Create a Google Map at the latitude/longitude returned by the Geocoder.
						    var myOptions = {
						      zoom: 16,
						      center: results[0].geometry.location,
						      mapTypeId: google.maps.MapTypeId.ROADMAP
						    };
						    // Get map form div id map
						    var map = new google.maps.Map(document.getElementById("map"), myOptions);

							//Add the marker
						    var marker = new google.maps.Marker({
						        map: map,
						        position: results[0].geometry.location
						      });
						}
						else{
							try {
							console.error("Geocode was not successful for the following reason: " + status);
							} catch(e) {}
						}
					});
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
  	<%--
	  	var sellingApartmentLatLng = new google.maps.LatLng(16.031944,108.220556);
		function initialize() {
			var mapProp = {
		    	center: sellingApartmentLatLng,
		    	zoom: 16,
		    	mapTypeId: google.maps.MapTypeId.ROADMAP
		  	};
		  	var map = new google.maps.Map(document.getElementById("googleMap"),mapProp);
		  	var marker = new google.maps.Marker({
			      position: sellingApartmentLatLng,
			      map: map,
			      title: 'Selling Apartment'
			});
		}
		google.maps.event.addDomListener(window, 'load', initialize);
  	--%>
  	</script>
</body>
</html>