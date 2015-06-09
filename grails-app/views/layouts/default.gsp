<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

<title><g:layoutTitle default="Home" /></title>

<g:javascript src="jquery-1.11.2.min.js"></g:javascript>
<g:javascript src="bootstrap.min.js"></g:javascript>
<g:javascript src="jssor.slider.mini.js"></g:javascript>
<g:javascript src="layouts/default/common.js"></g:javascript>

<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'bootstrap.min.css')}"
	type="text/css">
<link rel="stylesheet"
	href="${resource(dir: 'css/layouts/default', file: 'layout.css')}"
	type="text/css">
<style type="text/css">
span.web-name {
	font-size: 22px;
	color: blue;
	font-weight: bold;
	margin-left: 15px;
	display: block;
}

span.slogan {
	font-size: 16px;
	color: purple;
	margin-top: -5px;
	margin-left: 10px;
	display: block;
}
</style>

<g:layoutHead />
</head>
<body>
	<div id="t-wrapper">
		<div class="row">
			<div class="col-md-4">
				<span class="web-name"></span> <span class="slogan"></span>
			</div>
		</div>
		<div id="t-slider"
			style="position: relative; top: 0px; left: 0px; width: 1000px; height: 350px;">
			<div u="slides"
				style="cursor: move; position: absolute; overflow: hidden; left: 0px; top: 0px; width: 1000px; height: 350px;">
				<div>
					<img u="image"
						src="${resource(dir: 'images/main-slider', file: 'building-1.jpg')}" />
				</div>
				<div>
					<img u="image"
						src="${resource(dir: 'images/main-slider', file: 'building-2.jpg')}" />
				</div>
			</div>
			<div u="navigator" class="jssorb10"
				style="position: absolute; bottom: 16px; right: 16px;">
				<div u="prototype"
					style="position: absolute; width: 11px; height: 11px;"></div>
			</div>
		</div>
		<div id="t-mainMenu">
			<ul class="menuList">
				<li class="menuItem ${(activePage == 'home')?'active':''}"><a
					href="${createLink(controller: 'home', action: 'index')}"
					style="color: #fff;">Home</a></li>
				<li class="menuItem ${(activePage == 'product')?'active':''}">
					<a href="${createLink(controller: 'product', action: 'index')}"
					style="color: #fff;">Apartment</a>
				</li>
				<li class="menuItem ${(activePage == 'aboutus')?'active':''}">
					<a href="${createLink(controller: 'aboutus', action: 'index')}"
					style="color: #fff;">About Us</a>
				</li>
			</ul>
		</div>
		<div id="t-mainBody">
			<div id="t-additionInfo">
				<div id="userAuthInfo" class="infoSection">
					<div class="infoSectionHeader">Login</div>
					<div class="infoSectionContent">
						<div class="alert alert-danger login_message hidden" role="alert"></div>
						<g:if test="${currentUser}">
							<form action="j_spring_security_logout" method="POST">
								You are logging as <a
									href="${createLink(controller: 'account', action: 'edit', params: [id: currentUser.id])}">
									${currentUser.username}
								</a> <br /> <input class="btn btn-primary" type="submit"
									value="Logout">
							</form>
						</g:if>
						<g:else>
							<form action='${createLink(controller: 'login', action: 'auth')}'
								method='POST' id='loginForm' autocomplete='off'>
								<p>
									<label for='username'><g:message
											code="springSecurity.login.username.label" />:</label> <input
										class="form-control input-sm" type='text' class='text_'
										name='j_username' id='username' required />
								</p>
								<p>
									<label for='password'><g:message
											code="springSecurity.login.password.label" />:</label> <input
										class="form-control input-sm" type='password' class='text_'
										name='j_password' id='password' required />
								</p>
								<p id="remember_me_holder">
									<input type='checkbox' class='chk'
										name='${rememberMeParameter}' id='remember_me'
										<g:if test='${hasCookie}'>checked='checked'</g:if> /> <label
										for='remember_me'><g:message
											code="springSecurity.login.remember.me.label" /></label>
								</p>
								<p>
									<a class="btn btn-success"
										href="${createLink(controller: 'account', action: 'create')}">Create
										Account</a> <input class="btn btn-primary" type='submit'
										id="submit"
										value='${message(code: "springSecurity.login.button")}' />
								</p>
							</form>
						</g:else>
					</div>
				</div>
				<div class="infoSection">
					<div class="infoSectionHeader">Project Advisory</div>
					<div class="infoSectionContent"
						style="background-color: #DFF0D8; margin: 10px 0;">
						<h3 class='ceoPhone'></h3>
						<p>
							<span class="ceoName"></span> <br /> <span class="ceoPhone"></span>
						</p>
					</div>
				</div>
				<div class="infoSection">
					<div class="infoSectionHeader">Distribution Center</div>
					<div class="infoSectionContent">
						<img u="image" src="${resource(dir: 'images', file: 'logo.png')}" />
					</div>
				</div>
				<div class="infoSection">
					<div class="infoSectionHeader">Facility and Furniture</div>
					<div class="infoSectionContent">
						<div id="furnitureSlider"
							style="position: relative; top: 0px; left: 0px; width: 229px; height: 120px;">
							<div u="slides"
								style="cursor: move; position: absolute; overflow: hidden; left: 0px; top: 0px; width: 229px; height: 120px;">
								<div>
									<img u="image"
										src="${resource(dir: 'images/furniture-slider', file: 'furniture-1.jpg')}" />
								</div>
								<div>
									<img u="image"
										src="${resource(dir: 'images/furniture-slider', file: 'furniture-2.jpg')}" />
								</div>
								<div>
									<img u="image"
										src="${resource(dir: 'images/furniture-slider', file: 'furniture-3.jpg')}" />
								</div>
								<div>
									<img u="image"
										src="${resource(dir: 'images/furniture-slider', file: 'furniture-4.jpg')}" />
								</div>
								<div>
									<img u="image"
										src="${resource(dir: 'images/furniture-slider', file: 'furniture-5.jpg')}" />
								</div>
								<div>
									<img u="image"
										src="${resource(dir: 'images/furniture-slider', file: 'furniture-6.jpg')}" />
								</div>
								<div>
									<img u="image"
										src="${resource(dir: 'images/furniture-slider', file: 'furniture-7.jpg')}" />
								</div>
								<div>
									<img u="image"
										src="${resource(dir: 'images/furniture-slider', file: 'furniture-8.jpg')}" />
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="t-mainContent">
				<g:layoutBody />
			</div>
			<div class="t-shim"></div>
		</div>
		<div id="t-footer">
			Copyright © <span class="company"></span> 2015. All rights reserved.
		</div>
	</div>
	<div id="loading-status" class="hidden">
		<img width="60" height="64" alt="Please wait..."
			src="${resource(dir: 'images', file: 'loading-status.gif')}">
	</div>
	<script>
		$(document).ready(function(){
			var loginForm = $('#loginForm');
			loginForm.on('click', 'input[type=submit]', function(submitEvent){
				submitEvent.preventDefault();
				ajaxLogin(getLoginFormParams());
			});

			loadCategory();
			loadPreference();
			
			function ajaxLogin(params){
				$.ajax({
					url: '/j_spring_security_check',
					data: params,
					type: 'POST',
					beforeSend: function(){
						showLoadingStatus();
					},
					success: function(data, status, jqXHR){
						if(data["error"] != null){
							$('.login_message').removeClass('hidden').html("Wrong username or password");
						} else {
							location.reload();
						}
					},
					error: function(jqXHR, status, error){
					}, 
					complete: function(jqXHR, status){
						hideLoadingStatus();
					}
				});
			}
			function getLoginFormParams() {
				var params = {};
				params["j_username"] = $.trim(loginForm.find('input[name=j_username]').val());
				params["j_password"] = $.trim(loginForm.find('input[name=j_password]').val());
				return params;
			}

			function loadCategory(){
				$.ajax({
					url:'${createLink(controller:'category',action:'showAllCatNewJson')}',
					type:'POST',
					dataType : 'JSON',
					beforeSend: function(){
						showLoadingStatus();
					},
					success: function(data, status, jqXHR){
						var active = "";
						$.each(data,function(key,value){
							var active = "";
							if(value.shortName === '${activePage}'){
								active="active";
							}
							else{
								active= "";
							}
							$("ul.menuList").append(
								"<li class='menuItem "+ active +"' ><a href='/news/getCat/"+value.id+"' style='color:#fff;' >" + value.name + "</a> </li>"
							);
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

			function loadPreference(){
				$.ajax({
					url:'${createLink(controller:'preference',action:'currentPreferenceJson')}',
					type:'POST',
					dataType : 'JSON',
					beforeSend: function(){
						showLoadingStatus();
					},
					success: function(data, status, jqXHR){
						$("span.web-name").text(data.name);
						$("span.slogan").text(data.slogan);
						$("h3.ceoPhone").text(data.phone);
						$("span.ceoName").text("Mr. "+data.ceo);
						$("span.company").text(data.company);
						$("span.ceoPhone").text(data.phone);
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