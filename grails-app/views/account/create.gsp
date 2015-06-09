<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<meta name="layout" content="admin" />
<title>Register Account</title>
<g:javascript src="bootstrap-select.min.js"></g:javascript>
<g:javascript src="moment.min.js"></g:javascript>
<g:javascript src="bootstrap-datetimepicker.min.js"></g:javascript>
<g:javascript src="jquery.validate.min.js"></g:javascript>

<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'bootstrap-select.min.css')}"
	type="text/css">
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'bootstrap-datetimepicker.min.css')}"
	type="text/css">

<style type="text/css">
#registerForm {
	width: 400px;
	margin: 0 auto;
}
</style>
</head>
<body>
	<div id="registerForm">
		<form action='${createLink(controller: 'account', action: 'save')}'
			method='POST' autocomplete='off'>
			<fieldset>
				<legend>Account</legend>
				<g:if test="${message!=null}">
					<div class="alert alert-danger" role="alert">${message}</div>
				</g:if>
				<p>
					<label for='firstName'>First Name: </label> <input
						class="form-control input-sm" type="text" name='firstName' required="required" /> <label
						for='lastName'>Last Name: </label> <input
						class="form-control input-sm" type="text" name='lastName' required="required"/>
				</p>
				<p>
					<label for='email'>Email: </label> <input
						class="form-control input-sm" type="email" name='email' required="required"/>
				</p>
				<label for='dateOfBirth'>Date of Birth: </label>
				<div class="form-group">
					<div class='input-group date' id='datetimepicker'>
						<input type='text' name='dateOfBirth' class="form-control" /> <span
							class="input-group-addon"><span
							class="glyphicon glyphicon-calendar"></span> </span>
					</div>
				</div>
				<p>
					<label for='gender'>Gender: </label> <select class="form-control"
						id="selectpicker" name="gender">
						<option value="Male">Male</option>
						<option value="Female">Female</option>
						<option value="Other">Other</option>
					</select>
				</p>
				<p>
					<label for='address'>Address: </label> <input
						class="form-control input-sm" type="text" name='address' required="required" />
				</p>
				<p>
					<label for='phoneNumber'>Phone Number: </label> <input
						class="form-control input-sm" type="text" name='phoneNumber' required="required" />
				</p>
				<p>
					<label for='username'>Username<span style="color:red;font-size: 16px;">*</span>: </label> <input
						class="form-control input-sm" type="text" name='username' required="required" />
				</p>
				<p>
					<label for='password'>Password<span style="color:red;font-size: 16px;">*</span>: </label> <input
						class="form-control input-sm" type="password" name='password' required="required"/>
				</p>
				<p>
					<label for='password'>Reenter Password<span style="color:red;font-size: 16px;">*</span>: </label> <input
						class="form-control input-sm" type="password" required="required"/>
				</p>
				<p>
					<input class="btn btn-primary" type='submit' id="submit"
						value='Register' />
					<a class="btn btn-default" href="${createLink(controller: 'home', action: 'index')}">Cancel</a>
				</p>
			</fieldset>
		</form>
	</div>
	<script>
		$('#datetimepicker').datetimepicker({
			format: 'DD/MM/YYYY'
		});
		$('#selectpicker').selectpicker();
		$('#dateTimePicker').datetimepicker({
			icons : {
				time : "fa fa-clock-o",
				date : "fa fa-calendar",
				up : "fa fa-arrow-up",
				down : "fa fa-arrow-down"
			}
		});
		$('#formEdit').validate({
			rules : {
				firstName : {
					required : true
				},
				lastName : {
					required : true
				},
				email : {
					required : true,
					email : true
				},
				dateOfBirth : {
					required : true,
					date : true
				},
				address : {
					required : true
				},
				phoneNumber : {
					required : true,
					digits: true
				},
				username : {
					required : true
				},
				password : {
					required : true
				},
				confirmPassword : {
					equalTo : "#password"
				},
			},
			messages: {
				firstName : "Please input First name",
				lastName : "Please input Last name",
				email : "Email is invalid",
				dateOfBirth : "Date of birth is invalid",
				address : "Please input address",
				phoneNumber : "Please input Phone number",
				username : "Please input username",
				password : "Please input password",
				confirmPassword : "Confirm password does not match",
				
				}
		});
	</script>
</body>
</html>