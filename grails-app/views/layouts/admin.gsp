<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title><g:layoutTitle default="Home" /></title>

<g:javascript src="jquery-1.11.2.min.js"></g:javascript>
<g:javascript src="bootstrap.min.js"></g:javascript>
<g:javascript src="layouts/admin/common.js"></g:javascript>

<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'bootstrap.min.css')}"
	type="text/css">
<link rel="stylesheet"
	href="${resource(dir: 'css/layouts/admin', file: 'layout.css')}"
	type="text/css">
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'editor.css')}"
	type="text/css">
<style type="text/css">
.modal-open{
	padding-right: 0px!important;
}
</style>

<g:layoutHead />
</head>
<body>
	<div id="wrapper">
		<div id="header">
			<div id="logo">
				<a href="${createLink(controller: 'home', action: 'index')}"><img alt="Logo" src="${resource(dir: 'images', file: 'logo.png')}"></a>
			</div>
			<sec:access expression="hasAnyRole('ROLE_USER','ROLE_ADMIN')">
				<div id="menuContainer">
					<div id="mainMenu">
						<ul class="menuList">
							<li class="menuItem"><a href="${createLink(controller: 'apartment', action: 'index')}">Apartment</a></li>
							<li class="menuItem"><a href="${createLink(controller: 'facility', action: 'index')}">Facility</a></li>
							<li class="menuItem"><a href="${createLink(controller: 'preference', action: 'index')}">Preference</a></li>
							<li class="menuItem"><a href="${createLink(controller: 'category', action: 'index')}">Category</a></li>
							<li class="menuItem"><a href="${createLink(controller: 'news', action: 'index')}">News</a></li>
						</ul>
					</div>
					<div id="userMenu">
						<ul class="menuList">
							<li class="menuItem"><a title="<sec:username/>" href="${createLink(controller: 'account', action: 'edit', params: [id: sec.loggedInUserInfo(field: 'id')])}"><sec:username/></a></li>
							<li class="menuItem">
								<form action="j_spring_security_logout" method="POST">
									<input class="btn btn-primary" type="submit" value="Log out">
								</form>
							</li>
						</ul>
					</div>
				</div>
			</sec:access>
			<div class="shim"></div>
		</div>
		<div id="mainContent">
			<g:layoutBody/>
		</div>
		<div id="footer">
			Copyright © NhatQuang 2015. All rights reserved.
		</div>
	</div>
</body>
</html>