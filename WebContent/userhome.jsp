<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>GeoTag</title>
	<jsp:include page="header.jsp" />
	<jsp:useBean id="nameBean" type="models.User" scope="session" />
</head>
<body>		
	<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle Navigation</span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#">GeoTag</a>
		</div>

		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<!-- <form class="navbar-form navbar-right">
	            <div class="form-group">
	              <input type="text" placeholder="Email" class="form-control">
	            </div>
	            <div class="form-group">
	              <input type="password" placeholder="Password" class="form-control">
	            </div>
	            <button type="submit" class="btn btn-success">Login</button>
          	</form> -->
			<ul class="nav navbar-nav">
				<li><a href="userhome.jsp" >
					<span class="glyphicon glyphicon-home"></span> Home</a>
				</li>
				<li><a href="TagPlace.jsp" >
					<span class="glyphicon glyphicon-map-marker"></span> Tag a Place</a>
				</li>
				<li><a href="MLPQ.jsp">
					<span class="glyphicon glyphicon-pencil"></span> MLPQ</a>
				</li>
				<li><a href="UserPlaces">
					<span class="glyphicon glyphicon-globe"></span> Your Places</a>
				</li>
				<li><a href="about.jsp">
					<span class="glyphicon glyphicon-question-sign"></span> About</a>
				</li>
			</ul>

			<ul class="nav navbar-nav navbar-right">
				<li><a href=""> Welcome back, 
						<jsp:getProperty name="nameBean" property="firstname" />
						<jsp:getProperty name="nameBean" property="lastname" />
					</a>
				</li>
				<li><a href="settings.jsp" >
					<span class="glyphicon glyphicon-cog"></span> Settings</a>
				</li>
				<li><a href="SignOut" >
					<span class="glyphicon glyphicon-log-out"></span> Sign Out</a>
				</li>
			</ul>
		</div>
	</div>
	</nav>
	<div>
		<div class="row">
			<div class="col-md-12" style="position: relative; top:50px;">
				<input id="pac-input" class="controls" type="text" placeholder="Search Box">
				<div id="map-canvas"></div>
				<script>
					var markers = [];
					var map;

					window.initMap = function(){
						//var directionsService = new google.maps.DirectionsService();
						//directionsDisplay = new google.maps.DirectionsRenderer();
						var center= {lat: 41.49212083968779, lng: -99.415283203125};
						
						/* if(navigator.geolocation){
							var latitude, longitude;
							navigator.geolocation.getCurrentPosition(function (location){
								latitude = location.coords.latitude;
								longitude = location.coords.longitude;
								alert(latitude, longitude);
							});
							center={lat: latitude, lng: longitude};
						} */
						
						map = new google.maps.Map(document.getElementById('map-canvas'), {
							mapTypeControlOptions: {style:google.maps.MapTypeControlStyle.DROPDOWN_MENU},
							center: center,
							mapTypeId: 'roadmap',
							scaleControl: true,
							mapTypeControl: true,
							streetViewControl: false,
							zoom: 7,
							minZoom: 4
						});
						
						// Create the search box and link it to the UI element.
						var input = document.getElementById('pac-input');
						var searchBox = new google.maps.places.SearchBox(input);
						map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

						// Bias the SearchBox results towards current map's viewport.
						map.addListener('bounds_changed', function() {
							searchBox.setBounds(map.getBounds());
						});

						/* var markers = []; */
						// Listen for the event fired when the user selects a prediction and retrieve
						// more details for that place.
						searchBox.addListener('places_changed', function() {
							var places = searchBox.getPlaces();

							if (places.length === 0) {
								return;
							}

							// Clear out the old markers.
							markers.forEach(function(marker) {
								marker.setMap(null);
							});
							markers = [];

							// For each place, get the icon, name and location.
							var bounds = new google.maps.LatLngBounds();
							places.forEach(function(place) {
								if (!place.geometry) {
						              console.log("Returned place contains no geometry");
						              return;
						            }
								var icon = {
									url: place.icon,
									size: new google.maps.Size(71, 71),
									origin: new google.maps.Point(0, 0),
									anchor: new google.maps.Point(17, 34),
									scaledSize: new google.maps.Size(25, 25)
								};

								// Create a marker for each place.
								markers.push(new google.maps.Marker({
									map: map,
									icon: icon,
									title: place.name,
									position: place.geometry.location
								}));

								if (place.geometry.viewport) {
									// Only geocodes have viewport.
									bounds.union(place.geometry.viewport);
								} else {
									bounds.extend(place.geometry.location);
								}
							});
							map.fitBounds(bounds);
						});
						
						google.maps.event.addListener(map, 'bounds_changed', function() {
							var userplaces = [];
							userplaces.length = 0;
							var BoundingBox = "";
							var bounds = map.getBounds();
							
							var NE = bounds.getNorthEast();
							var SW = bounds.getSouthWest();
							
							BoundingBox = NE.toUrlValue(20).toString() + "," +
										  SW.toUrlValue(20).toString();
							$.ajax({
							    url: './UserPlaces',
							    data: {
							        "BoundingBox": BoundingBox
							    },
							    type: 'GET',
							    xhrFields: {withCredentials: true},
	                            	accept: 'application/text',
	                            	dataType: 'text',
							    success: function () {
							    		<c:set var="length" value="${0}" />
									<c:forEach var="place" items="${userplaces}">
										<c:set var="length" value="${length + 1}" />
									</c:forEach>
									<c:choose>
										<c:when test="${length == '0'}">
											userplaces = []
										</c:when>
										<c:otherwise>
											<c:forEach var="place" items="${userplaces}">
												var obj={
														position: new google.maps.LatLng(<c:out value="${place[1]}"/>, <c:out value="${place[2]}"/>),
														icon: '<c:out value="${place[5]}"/>'
													};
												userplaces.push(obj);
											</c:forEach>
										</c:otherwise>
									</c:choose>
									
									console.log(userplaces);
									userplaces.forEach(function(place) {
								          var marker = new google.maps.Marker({
								            position: place.position,
								            icon: place.icon,
								            map: map
								          });
								    });
								}
							});
						});
					}
				</script>
				<script async defer src="https://maps.googleapis.com/maps/api/js?key=<api_key>&libraries=drawing,places&callback=initMap"></script>	
			</div>
		</div>
	</div>
</body>
</html>
