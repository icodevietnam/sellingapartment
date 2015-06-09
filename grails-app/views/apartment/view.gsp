<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<meta name="layout" content="admin" />
<title>View Apartment</title>

<script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyD8CmzeCN0zgID6zEFXYUusXE7Svlm-_8E"></script>
<g:javascript src="jssor.slider.mini.js"></g:javascript>
<style type="text/css">
#mediaInfo, #details {
	float: left;
	width: 50%;
}

#apartmentImages img {
	width: 100%;
}

#apartmentFacilities ul {
	list-style: none;
	padding: 0;
	padding-left: 30px;
}

#details {
	padding-left: 20px;
}

#apartmentImages, #apartmentName {
	margin-bottom: 10px;
}
.jssorb10 div, .jssorb10 div:hover, .jssorb10 .av {
	background: url(/images/main-slider/b10.png) no-repeat;
	overflow: hidden;
	cursor: pointer;
}

.jssorb10 div {
	background-position: -10px -10px;
}

.jssorb10 div:hover, .jssorb10 .av:hover {
	background-position: -40px -10px;
}

.jssorb10 .av {
	background-position: -70px -10px;
}

.jssorb10 .dn, .jssorb10 .dn:hover {
	background-position: -100px -10px;
}
</style>
</head>
<body>
	<div id="apartmentViewContainer">
		<div id="mediaInfo">
			<div id="apartmentName">
				${apartment.name}
			</div>
			<div id="apartmentImages">
				<%@ page import="com.sellingapartment.Image" %>
				<div id="facilitiesSlider" style="position: relative; top: 0px; left: 0px; width: 490px; height: 300px;">
					<div u="slides" style="cursor: move; position: absolute; overflow: hidden; left: 0px; top: 0px; width: 490px; height: 300px;">
			        	<g:if test="${apartment.images != null && apartment.images.size() > 0}">
			        		<g:each in="${apartment.images}" var="image">
								<div><img u="image" src="${createLink(controller: 'image', action: 'get', id: image.code, params: [apartmentId: apartment.id, fileName: image.fileName])}"/></div>
			        		</g:each>
						</g:if>
			    	</div>
			    	<div u="navigator" class="jssorb10" style="position: absolute; bottom: 16px; right: 16px;">
			            <div u="prototype" style="position: absolute; width: 11px; height: 11px;"></div>
			        </div>
				</div>
			</div>
			<div id="apartmentMap" style="width:100%;height:380px;margin:0 auto;"></div>
		</div>
		<div id="details">
			<div style="visibility: hidden;margin-bottom: 10px;">
				${apartment.name}
			</div>
			<p id="apartmentCode">
				${apartment.code}
			</p>
			<p id="apartmentDescription">
				${apartment.description}
			</p>
			<div id="apartmentFacilities">
				<p>
					Facilities:
				</p>
				<ul>
					<g:if test="${apartmentFacilities != null && apartmentFacilities.size() > 0}">
						<g:each in="${apartmentFacilities}" var="facility">
							<li class="facility">
								${facility.name}							
							</li>
						</g:each>
					</g:if>
				</ul>
			</div>
			<p id="apartmentAddress">
				Address: ${apartment.address}
			</p>
			<p id="apartmentPrice">
				Price: ${apartment.price}
			</p>
		</div>
		<div class="shim"></div>
	</div>
	<script>
		var apartmentLatLng = getApartmentLocation("${apartment.location}");
		function initialize() {
			var mapProp = {
		    	center: apartmentLatLng,
		    	zoom: 16,
		    	mapTypeId: google.maps.MapTypeId.ROADMAP
		  	};
			var map = new google.maps.Map(document.getElementById("apartmentMap"),mapProp);
			var marker = new google.maps.Marker({
			      position: apartmentLatLng,
			      map: map,
			      title: "${apartment.name}"
			});
		}
		google.maps.event.addDomListener(window, 'load', initialize);
		function getApartmentLocation(locationString){
			var location = locationString.replace(/[()]/g,'');
			var latLng = location.split(", ");
			var latitudes = parseFloat(latLng[0]);
			var longitudes = parseFloat(latLng[1]);
			return new google.maps.LatLng(latitudes, longitudes);
		}
		$(document).ready(function (){
			var _SlideshowTransitions = [{ $Duration: 800, $Opacity: 2 }];
			var facilitiesSliderOptions = {
				$AutoPlay: true,                                   //[Optional] Whether to auto play, to enable slideshow, this option must be set to true, default value is false
		        $SlideDuration: 500,                                //[Optional] Specifies default duration (swipe) for slide in milliseconds, default value is 500
		        $BulletNavigatorOptions: {                                //[Optional] Options to specify and enable navigator or not
		            $Class: $JssorBulletNavigator$,                       //[Required] Class to create navigator instance
		            $ChanceToShow: 2,                               //[Required] 0 Never, 1 Mouse Over, 2 Always
		            $AutoCenter: 0,                                 //[Optional] Auto center navigator in parent container, 0 None, 1 Horizontal, 2 Vertical, 3 Both, default value is 0
		            $Steps: 1,                                      //[Optional] Steps to go for each navigation request, default value is 1
		            $Lanes: 1,                                      //[Optional] Specify lanes to arrange items, default value is 1
		            $SpacingX: 5,                                  //[Optional] Horizontal space between each item in pixel, default value is 0
		            $SpacingY: 10,                                  //[Optional] Vertical space between each item in pixel, default value is 0
		            $Orientation: 1                                 //[Optional] The orientation of the navigator, 1 horizontal, 2 vertical, default value is 1
		        },
		        $SlideshowOptions: {                                //[Optional] Options to specify and enable slideshow or not
		            $Class: $JssorSlideshowRunner$,                 //[Required] Class to create instance of slideshow
		            $Transitions: _SlideshowTransitions,            //[Required] An array of slideshow transitions to play slideshow
		            $TransitionsOrder: 1,                           //[Optional] The way to choose transition to play slide, 1 Sequence, 0 Random
		            $ShowLink: true                                    //[Optional] Whether to bring slide link on top of the slider when slideshow is running, default value is false
		        }
			};
			var facilitiesSlider = new $JssorSlider$('facilitiesSlider', facilitiesSliderOptions);
		});
	</script>
</body>
</html>