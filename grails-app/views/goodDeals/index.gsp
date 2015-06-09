<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta name="layout" content="default"/>
<title>Good Deals</title>
<style type="text/css">
#apartmentListContainer, #apartmentFormContainer {
	float: left;
	width: 100%;
}

#apartmentListContainer {
	padding-right: 10px;
}

#apartmentList .list-group-item {
	border-top: none;
	border-left: none;
	border-right: none;
	border-bottom: 1px solid #ccc;
	border-radius: 0px;
	background: none;
}

#apartmentList .list-group-item:last-child {
	border: none;
}

#apartmentList .apartmentName {
	width: 325px;
	cursor: pointer;
	font-weight: bold;
	white-space: nowrap;
	text-overflow: ellipsis;
	overflow: hidden;
	display: inline-block;
}

#apartmentList .ellipsis {
	display: table-cell;
	vertical-align: middle;
}

#apartmentList .apartmentControls {
	display: table-cell;
	vertical-align: middle;
}

#apartmentList .apartmentInfo {
	margin-top: 10px;
}

#apartmentList .apartmentImages {
	float: left;
	width: 230px;
	height: 150px;
	background-color: aliceblue;
}

#apartmentList .apartmentDetails {
	float: left;
	width: 220px;
	padding-left: 10px;
}

#apartmentList .apartmentCode, #apartmentList .apartmentPrice {
	font-weight: bold;
	white-space: nowrap;
	text-overflow: ellipsis;
	width: 100%;
	overflow: hidden;
}

#apartmentList .apartmentDescription, #apartmentList .apartmentAddress,
	#apartmentList .apartmentAddress {
	word-wrap: break-word;
	width: 100%;
	overflow: hidden;
}

#apartmentList .apartmentAddress {
	font-weight: bold;
}

.documentList {
	list-style: none;
	padding: 0;
}

.imageList {
	list-style: none;
	padding: 0;
}
.apartmentImages img{
	width: 100%;
	height: 100%;
}
</style>
</head>
<body>
	<div class="mainContent-heading">
  		<h1>Good Deals</h1>
  	</div>
  	<div id="apartmentListContainer">
		<ul id="apartmentList" class="list-group">
			<g:each in="${apartments}" var="apartment">
				<li id="apartment-${apartment.id}" class="apartment list-group-item">
					<div class="controlPanel">
						<div class="ellipsis">
							<a class="apartmentName" href="${createLink(controller: 'apartment', action: 'view', id: apartment.id)}">
								${apartment.name}
							</a>
						</div>
						<div class="apartmentControls">
						</div>
					</div>
					<div class="apartmentInfo">
						<div class="apartmentImages">
							<g:if test="${apartment.images != null && apartment.images.size() > 0}">
								<img alt="apartment image" src="${createLink(controller: 'image', action: 'get', id: apartment.images[0].code, params: [apartmentId: apartment.id, fileName: apartment.images[0].fileName])}">
							</g:if>
						</div>
						<div class="apartmentDetails">
							<div class="apartmentCode">${apartment.code}</div>
							<div class="apartmentDescription">${apartment.description}</div>
							<div class="apartmentAddress">Address: ${apartment.address}</div>
							<div class="apartmentPrice">Price: ${apartment.price}</div>
						</div>
						<div class="t-shim"></div>
					</div>
				</li>
			</g:each>
		</ul>
	</div>
	<div class="t-shim"></div>
  	<script>
  	</script>
</body>
</html>