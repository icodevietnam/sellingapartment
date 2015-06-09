<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<meta name="layout" content="admin" />
<title>Manage Apartment</title>
<script
	src="http://maps.googleapis.com/maps/api/js?key=AIzaSyD8CmzeCN0zgID6zEFXYUusXE7Svlm-_8E"></script>
<g:javascript src="bootstrap-select.min.js"></g:javascript>
<g:javascript src="jquery.dataTables.js"></g:javascript>
<g:javascript src="dataTables.bootstrap.js"></g:javascript>
<g:javascript src="editor.js"></g:javascript>
<g:javascript src="touchspin.min.js"></g:javascript>
<g:javascript src="jquery.validate.min.js"></g:javascript>
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'bootstrap-select.min.css')}"
	type="text/css">
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'touchspin.min.css')}"
	type="text/css">
<style type="text/css">
</style>
</head>
<body>
	<div id="preferenceFormFolder" class="row" style="padding: 15px;">
		<g:if test="${status == 'true'}">
			<div id="informMessage" class="alert alert-success"
				style="display: none;" role="alert">
				${message}
			</div>
		</g:if>
		<g:else>
			<div id="informMessage" class="alert alert-danger"
				style="display: none;" role="alert">
				${message}
			</div>
		</g:else>
		<form id="preferenceForm">
			<div class="form-group">
				<label for="name">Name</label> <input type="text"
					class="form-control" name="name" id="txtName" required="required"
					value="${preference.name}" placeholder="Name">
			</div>
			<div class="form-group">
				<label for="name">Address</label> <input type="text"
					class="form-control" name="address" id="txrAddress"
					required="required" value="${preference.address}"
					placeholder="Address">
			</div>
			<div class="form-group">
				<label for="name">Features</label>
				<textarea id="txtFeatures" name="features" class="form-control"
					required="required" placeholder="Features" required>
					${preference.features}
				</textarea>
			</div>
			<div class="form-group">
				<label for="name">Company</label> <input type="text"
					class="form-control" name="company" id="txtCompany"
					required="required" value="${preference.company}"
					placeholder="Company">
			</div>
			<div class="form-group">
				<label for="name">Country</label> <input type="text"
					class="form-control" name="country" id="txtCountry"
					required="required" value="${preference.country}"
					placeholder="Country">
			</div>
			<div class="form-group">
				<label for="name">Email</label> <input type="email"
					required="required" class="form-control" name="email" id="txtEmail"
					value="${preference.email}" placeholder="Email">
			</div>
			<div class="form-group">
				<label for="name">Phone</label> <input type="text"
					class="form-control" name="phone" id="txtPhone" required="required"
					value="${preference.phone}" placeholder="Phone">
			</div>
			<div class="form-group">
				<label for="name">Url</label> <input type="text"
					class="form-control" name="url" id="txtUrl" required="required"
					value="${preference.url}" placeholder="Url">
			</div>
			<div class="form-group">
				<label for="name">CEO</label> <input type="text"
					class="form-control" name="ceo" id="txtCeo" required="required"
					value="${preference.ceo}" placeholder="CEO">
			</div>
			<div class="form-group">
				<label for="name">Slogan</label> <input type="text"
					class="form-control" name="slogan" id="txtSlogan"
					required="required" value="${preference.slogan}"
					placeholder="Slogan">
			</div>
			<div class="form-group">
				<label for="name">Floor Number</label> <input type="number"
					class="form-control" name="floorNumber" id="txtFloorNumber"
					required="required" value="${preference.floorNumber}" onkeypress='return event.charCode >= 48 && event.charCode <= 57'
					placeholder="Floor Number">
			</div>
			<button id="createButton" class="btn btn-primary">Submit</button>
		</form>
	</div>
	<script type="text/javascript">

		$("input[name='floorNumber']").TouchSpin({
	      verticalbuttons: true,
	      verticalupclass: 'glyphicon glyphicon-plus',
	      verticaldownclass: 'glyphicon glyphicon-minus'
	    });

		$("textarea[name='features']").trumbowyg();
		$('#preferenceFormFolder').on('click', '.chooseFileButton', function() {
			$('#uploadForm input[name=file]').trigger("click");
		});

		//validation
		$('#preferenceForm').validate({
			rules: {
				name: { required: true },
				address : { required: true },
				features : { required: true },
				company : { required: true },
				country : { required: true },
				email : { required: true, email: true },
				phone : { required: true, digits: true },
				url : { required: true },
				ceo : { required: true },
				slogan : { required: true },
				floorNumber : { required: true }
				},
			messages: {
				name: "Please input name",
				address: "Please input address",
				features: "Please input features",
				company: "Please input company",
				country: "Please input country",
				email: "Invalid email",
				phone: "Please input phone",
				url: "Please input url",
				ceo: "Please input ceo",
				slogan: "Please input slogan",
				floorNumber: "Invalid floor number"
				}
			});

		// Handle button create
		$('#preferenceFormFolder').on('click', '#createButton', function(event){
			event.preventDefault();
			if($('#preferenceForm').valid()){
				var preferenceForm = $('#preferenceForm');
				var preferenceParams = getPreferenceParams(preferenceForm);
				updatePreference(preferenceParams);
			}
		});
		
		function getPreferenceParams(form){
			var parameters = {};
			//var images = [];
			parameters['name'] = $.trim(form.find('input[name=name]').val());
			parameters['address'] = $.trim(form.find('input[name=address]').val());
			parameters['features'] = $.trim(form.find('textarea[name=features]').val());
			parameters['company'] = $.trim(form.find('input[name=company]').val());
			parameters['country'] = $.trim(form.find('input[name=country]').val());
			parameters['email'] = $.trim(form.find('input[name=email]').val());
			parameters['phone'] = $.trim(form.find('input[name=phone]').val());
			parameters['url'] = $.trim(form.find('input[name=url]').val());
			parameters['ceo'] = $.trim(form.find('input[name=ceo]').val());
			parameters['slogan'] = $.trim(form.find('input[name=slogan]').val());
			parameters['floorNumber'] = $.trim(form.find('input[name=floorNumber]').val());
			//var count = 0;
			//form.find('input[name=images]').each(function (){
			//	images[count++] = $(this).val();
			//});
			//parameters['images'] = images;
			//console.log(images)
			return parameters;
		}
		
		function updatePreference(params){
			$.ajax({
				url: '${createLink(controller:'preference', action:'update')}',
				data: params,
				type: 'POST',
				beforeSend: function(){
					showLoadingStatus();
				},
				success: function(data, status, jqXHR){
					if(data != ''){
						$('#informMessage').slideDown('fast')
						.removeClass(function(index, css) {
							return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
						})
						.addClass('alert-success')
						.html('Create Preference '+params['name']+' successfully.')
						.delay(5000)
						.slideUp('slow');
					}
					else{
						$('#informMessage').slideDown('fast')
						.removeClass(function(index, css) {
							return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
						})
						.addClass('alert-danger')
						.html('Fail to create Preference '+params['name']+'.')
						.delay(5000)
						.slideUp('slow');
					}
				},
				error: function(jqXHR, status, error){
					$('#informMessage').slideDown('fast')
					.removeClass(function(index, css) {
						return (css.match(/(^|\s)alert-\S+/g) || []).join(' ');
					})
					.addClass('alert-danger')
					.html('Fail to create Preference '+params['name']+'.')
					.delay(5000)
					.slideUp('slow');
				}, 
				complete: function(jqXHR, status){
					hideLoadingStatus();
					//cleartPreferenceForm();
				}
			});
		}

		function cleartPreferenceForm() {
			$('#preferenceForm input[name=name]').val('');
			$('#preferenceForm input[name=address]').val('');
			$('#preferenceForm input[name=features]').val('');
			$('#preferenceForm input[name=email]').val('');
			$('#preferenceForm input[name=phone]').val('');
			$('#preferenceForm input[name=company]').val('');
			$('#preferenceForm input[name=country]').val('');
			$('#preferenceForm input[name=url]').val('');
			$('#preferenceForm input[name=ceo]').val('');
			$('#preferenceForm input[name=slogan]').val('');
			$('#preferenceForm input[name=floorNumber]').val('');
		}
	</script>
</body>
</html>