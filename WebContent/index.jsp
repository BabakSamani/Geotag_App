<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>GeoTag</title>
	<jsp:include page="header.jsp" />
</head>
<body>
	<div id="id01" class="modal">
	  <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">×</span>
	  <form class="modal-content animate" action="SignUp" method="post">
	    <div class="container1">
	    	  <label><b>First Name:</b></label>
	      <input class="popupInput" type="text" placeholder="Enter Your First Name" name="firstName" required>
	    	  
	    	  <label><b>Last Name:</b></label>
	      <input class="popupInput" type="text" placeholder="Enter Your Last Name" name="lastName" required>
	    	  
	      <label><b>Email:</b></label>
	      <input class="popupInput" type="email" placeholder="Enter Email" name="email" required>
	
	      <label><b>Password:</b></label>
	      <input class="popupInput" type="password" placeholder="Enter Password" name="psw" required>
	
	      <label><b>Repeat Password:</b></label>
	      <input class="popupInput" type="password" placeholder="Repeat Password" name="psw-repeat" required>

	      <div class="clearfix">
	        <button id="buttons" type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">Cancel</button>
	        <button id="buttons" type="submit" class="signupbtn">Sign Up</button>
	      </div>
	    </div>
	  </form>
	</div>
	 
	<div id="id02" class="modal">
	  <span onclick="document.getElementById('id02').style.display='none'" class="close" title="Close Modal">×</span>
	  <form class="modal-content animate" action="SignIn" method="post">
	    <div class="container1">
	      <label><b>Email:</b></label>
	      <input class="popupInput" type="email" placeholder="Enter Email" name="email" value="${cookie.Username.value}" required >
	
	      <label><b>Password:</b></label>
	      <input class="popupInput" type="password" placeholder="Enter Password" name="psw" value="${cookie.Password.value}" required >
		  <input type="checkbox" name="saveme" checked="checked"> Remember me
	      <div class="clearfix">
	        <button id="buttons" type="button" class="forgotbtn">Forgot Password?</button>
	        <button id="buttons" type="submit" class="signinbtn">Sign In</button>
	      </div>
	    </div>
	  </form>
	</div>
	
	 
	<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle Navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
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
				<!-- <li><a href="Index.jsp">Home</a></li> -->
				<li><a href="contact.jsp">Contact</a></li>
				<li><a href="about.jsp">About</a></li>
			</ul>
			
			<!-- <form class="navbar-form navbar-left" role="search">
			  <div class="form-group">
			    <input type="text" class="form-control" placeholder="Search for a location">
			  </div>
			  <button type="submit" class="btn btn-default">Submit</button>
			</form> -->
			
			<ul class="nav navbar-nav navbar-right">
				<li><a onclick="displaySignUp()" style="width:auto;" >
					<span class="glyphicon glyphicon-user"></span> Sign Up</a>
				</li>
				<li><a onclick="displaySignIn()" style="width:auto;" >
					<span class="glyphicon glyphicon-log-in"></span> Sign In</a>
				</li>
				
			    <c:if test="${not empty warningmessage}" >
				    <script>
					    swal(
					    		  'Sorry',
					    		  '<c:out value = "${warningmessage}"/>',
					    		  'warning'
					    		)
				    </script>
				</c:if>
				
				<c:if test="${not empty dangermessage}" >
				    <script>
					    swal(
					    		  'Opps',
					    		  '<c:out value = "${dangermessage}"/>',
					    		  'error'
					    		)
				    </script>
				</c:if>
				
				<!-- <li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">User
						first name and last name goes here<span class="caret"></span>
					</a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="/logout">Logout</a></li>
					</ul>
				</li> -->
			</ul>
			
		</div>
	</div>
	</nav>
	<div>
		<div class="row">
			<!-- <div class="container" style="position: relative; top:60px;"> -->
				<div class="col-md-12" style="position: relative; top:50px;" >
					<input id="pac-input" class="controls" type="text" placeholder="Search for a place on the map">
					<div id="map-canvas"></div>
					<script>
							var coordinates = [];
							var map;
	
							window.initMap = function(){
								var directionsService = new google.maps.DirectionsService();
								directionsDisplay = new google.maps.DirectionsRenderer();
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
									//mapTypeId: 'roadmap',
									//mapTypeId: 'satellite',
									mapTypeId: google.maps.MapTypeId.MAP,
									scaleControl: true,
									mapTypeControl: true,
									streetViewControl: true,
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
	
								var markers = [];
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
									//window.location.reload(); 
									var places = [];
									places.length = 0;
									var BoundingBox = "";
									var bounds = map.getBounds();
									
									var NE = bounds.getNorthEast();
									var SW = bounds.getSouthWest();
									
									BoundingBox = NE.toUrlValue(20).toString() + "," +
												  SW.toUrlValue(20).toString();
									//console.log(BoundingBox);
									$.ajax({
									    url: './AllPlaces',
									    crossOrigin: true,
									    data: {
									        "BoundingBox": BoundingBox
									    },
									    type: 'GET',
									    xhrFields: {withCredentials: true},
		                                	accept: 'application/text',
		                                	dataType: 'text',
									    success: function () {
									    		places.length = 0;
									    		<c:set var="length" value="${0}" />
											<c:forEach var="place" items="${allplaces}">
												<c:set var="length" value="${length + 1}" />
											</c:forEach>
											<c:choose>
												<c:when test="${length == '0'}">
													places = []
												</c:when>
												<c:otherwise>
													<c:forEach var="place" items="${allplaces}">
														var obj={
																position: new google.maps.LatLng(<c:out value="${place[1]}"/>, <c:out value="${place[2]}"/>),
																icon: '<c:out value="${place[5]}"/>'
															};
														places.push(obj);
													</c:forEach>
												</c:otherwise>
											</c:choose>
											
											console.log("Places: ", places);
											places.forEach(function(place) {
										          var marker = new google.maps.Marker({
										            position: place.position,
										            icon: place.icon,
										            map: map
										          });
										    });
									    }
									})
								});
							 }
					</script>
					<script async defer src="https://maps.googleapis.com/maps/api/js?key=<api_key>&libraries=drawing,places&callback=initMap"></script>
					<script type="text/javascript">
						// Get the modal
						var modal_1 = document.getElementById('id01');
						var modal_2 = document.getElementById('id02');
					
						// When the user clicks anywhere outside of the modal, close it
						window.onclick = function(event) {
						    if (event.target === modal_1) {
						        modal_1.style.display = "none";
						    }
						    if (event.target === modal_2) {
						    		modal_2.style.display = "none";
						    }
						}
						
						function displaySignUp(){
							document.getElementById('id01').style.display = 'block';
							document.getElementById('id02').style.display = 'none';
						}
						
						function displaySignIn() {
							document.getElementById('id01').style.display = 'none';
							document.getElementById('id02').style.display = 'block';
						} 
					</script>
				</div>
			<!-- </div> -->
		</div>
	</div>
</body>
</html>
