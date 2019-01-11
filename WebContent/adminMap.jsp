<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin map page</title>
<jsp:include page="header.jsp" />
<jsp:useBean id="nameBean" type="models.User" scope="session" />
</head>
<body>
    <div class="wrapper">
            <!-- Sidebar Holder -->
            <nav id="sidebar">
                <div class="sidebar-header">
                    <h3>GeoTag Admin Page</h3>
                    <strong>GA</strong>
                </div>

                <ul class="list-unstyled components">
                    <li>
                        <a href="adminhome.jsp" aria-expanded="false">
                            <i class="glyphicon glyphicon-home"></i>
                            Home
                        </a>
                        <!-- <ul class="collapse list-unstyled" id="homeSubmenu">
                            <li><a href="#">Home 1</a></li>
                            <li><a href="#">Home 2</a></li>
                            <li><a href="#">Home 3</a></li>
                        </ul> -->
                    </li>
                    <li class="active" >
                        <a href="adminMap.jsp">
                            <i class="glyphicon glyphicon-road"></i>
                            Map
                        </a>
                    </li>
                    <li>
                        <a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false">
                            <i class="glyphicon glyphicon-tags"></i>
                            Categories
                        </a>
                        <ul class="collapse list-unstyled" id="pageSubmenu">
                            <li><a onclick="location.href='./DisplayCategories';"><i class="glyphicon glyphicon-th-list"></i>All Categories</a></li>
                            <li><a href="addCategory.jsp"><i class="glyphicon glyphicon-cloud-upload"></i>Add Category</a></li>
                        </ul>
                    </li>
                    <li>
                        <a onclick="location.href='./DisplayUsers';">
                            <i class="glyphicon glyphicon-user"></i>
                            Users
                        </a>
                    </li>
                    <li>
                        <a onclick="location.href='./AllLocations';">
                            <i class="glyphicon glyphicon-map-marker"></i>
                            Locations
                        </a>
                    </li>
                    <li>
                        <a href="#pageSubmenu">
                            <i class="glyphicon glyphicon-list-alt"></i>
                            Manage
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="glyphicon glyphicon-link"></i>
                            Portfolio
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="glyphicon glyphicon-paperclip"></i>
                            FAQ
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="glyphicon glyphicon-send"></i>
                            Contact
                        </a>
                    </li>
                    <li>
                    		<a href="about.jsp">
                            <i class="glyphicon glyphicon-briefcase"></i>
                            About
                        </a>
                    </li>
                </ul>

                <ul class="list-unstyled CTAs">
                    <li><a href="https://bootstrapious.com/tutorial/files/sidebar.zip" class="download">Download source</a></li>
                    <li><a href="https://bootstrapious.com/p/bootstrap-sidebar" class="article">Back to article</a></li>
                </ul>
            </nav>

            <!-- Page Content Holder -->
            <div id="content">
                <nav class="navbar navbar-inverse" style="background-color: #2f2f2f;">
                    <div class="container-fluid">

                        <div class="navbar-header">
							<button type="button" class="navbar-toggle collapsed"
								data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
								<span class="sr-only">Toggle Navigation</span> 
								<span class="icon-bar"></span> 
								<span class="icon-bar"></span> 
								<span class="icon-bar"></span>
							</button>
                            <button type="button" id="sidebarCollapse" class="btn btn-defult navbar-btn">
								<i id="shrink-menu" class="glyphicon glyphicon-menu-left"></i>
                                <span>Toggle Sidebar</span>
                            </button>
                        </div>
                        <ul class="nav navbar-nav navbar-left">
                        		<c:choose>
								<c:when test="${not empty nameBean}">
									<li><a href="#" >
										<span class="glyphicon glyphicon-bullhorn"></span> Logged in as, 
											<jsp:getProperty name="nameBean" property="firstname" />
											<jsp:getProperty name="nameBean" property="lastname" />
										</a>
								   	</li>
								</c:when>
								<c:otherwise>
									<script>
										window.location.href = "/Geotag_App/Index.jsp";
									</script>
								</c:otherwise>
							</c:choose>
                            
					   </ul>
						
						<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        	<ul class="nav navbar-nav navbar-right">
								<li><a href="settings.jsp" >
									<span class="glyphicon glyphicon-cog"></span> Settings</a>
								</li>
								<li><a href="SignOut" >
									<span class="glyphicon glyphicon-log-out"></span> Sign Out</a>
								</li>
				
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
                <div class="col-lg-12">
					<h2>Find Places Within a Polygon or Rectangle:</h2>
					<p>I haven't decided what to put for this page, please give me your ideas about this page.</p>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
	            </div>
	            <div class="col-lg-12" style="position: relative; top:50px;" >
					<input id="pac-input" class="controls" type="text" placeholder="Search for a place on the map">
					<div id="map-canvas"></div>
					<script>
							var coordinates = [];
							var map;
							
							var center = navigator.geolocation.getCurrentPosition(function (location){
								latitude = location.coords.latitude;
								longitude = location.coords.longitude;
								return [latitude, longitude];
								
							});
							
							function displayLocationElevation(location, elevator, infowindow) {
								// Initiate the location request
								elevator.getElevationForLocations({
									'locations': [location]
								}, function(results, status) {
									infowindow.setPosition(location);
									if (status === 'OK') {
										// Retrieve the first result
										if (results[0]) {
											// Open the infowindow indicating the elevation at the clicked position.
											infowindow.setContent('The elevation at this point <br>is ' + results[0].elevation + ' meters.');
										} else {
											infowindow.setContent('No results found');
										}
									} else {
										infowindow.setContent('Elevation service failed due to: ' + status);
									}
								});
							}
	
							/* function Get_Elevation(location){
								console.log('The Get_Elevation function is being called!');
								var elevator = new google.maps.ElevationService;
								var elevations = new Array(1);
								elevations[0] = '0';
								// Initiate the location request
								elevator.getElevationForLocations({
									'locations': [location]
								}, function(results, status) {
									var elevation;
									if (status === 'OK') {
										// Retrieve the first result
										if (results[0]) {
											elevation = results[0].elevation;
										} else {
											elevation = 0;
										}
									} else {
										elevation = 0;
									}
									elevations[0] = elevation.toString();
								});
								for(var i=0; i<elevations.length; i++){
									console.log(elevations[i]); // Print on the log
								}
								return elevations;
							} */
	
							function Get_Elevation_Elevator(location){
								console.log('The Get_Elevation_Elevator function is being called!');
								var elevator = new google.maps.ElevationService;
								var elevation;
								// Initiate the location request
								if(elevator){
									elevator.getElevationForLocations({'locations': [location]}, function (results, status){
										if(status === 'OK'){
											console.log('Line 131: The length is ' + results.length);
											elevation = results[0].elevation.toString();
										}
										else {
											console.log("Elevator is failed: " + status);
										}
										console.log(elevation); // prints out the elevation here
										/* document.getElementById("inputAlt").value = elevation; */
									});
								}
							}
	
							/* function Get_Eleveation_Geocoder(location){
								console.log('The Get_Eleveation_Geocoder function is being called!');
								var geocoder = new google.maps.Geocoder();
								if (geocoder) {
									geocoder.geocode({ 'location': location }, function (results, status) {
										if (status === google.maps.GeocoderStatus.OK) {
											console.log(results[0]);
										}
										else {
											console.log("Geocoding failed: " + status);
										}
									});
								}
							} */
	
							window.initMap = function(){
								
								//var directionsService = new google.maps.DirectionsService();
								//directionsDisplay = new google.maps.DirectionsRenderer();
								var center= {lat: 41.49212083968779, lng: -99.415283203125};
								
								map = new google.maps.Map(document.getElementById('map-canvas'), {
									mapTypeControlOptions: {style:google.maps.MapTypeControlStyle.DROPDOWN_MENU},
									center: center,
									mapTypeId: 'roadmap',
									//mapTypeId: 'satellite',
									//mapTypeId: google.maps.MapTypeId.MAP,
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
	
								
								
								/* var elevator = new google.maps.ElevationService;
								var infowindow = new google.maps.InfoWindow({map: map});
	
								google.maps.event.addListener(map, "click", function(event) {
									displayLocationElevation(event.latLng, elevator, infowindow);
								});
	
								//Add listener
								google.maps.event.addListener(map, "click", function (event) {
	
									var latitude = event.latLng.lat();
									var longitude = event.latLng.lng();
	
									fieldCoordinate.push([{"lat":latitude, "lng":longitude}]);
									alert(fieldCoordinate[0][key]);
									console.log( fieldCoordinate[0] );
	
									radius = new google.maps.Circle({map: map,
										radius: 100,
										center: event.latLng,
										fillColor: '#17A589',
										fillOpacity: 0.5,
										strokeColor: '#AA0000',
										strokeOpacity: 0.8,
										strokeWeight: 2,
										draggable: true,    // Draggable
										editable: true      // Resizable
									});
	
									// Center of map
									map.panTo(new google.maps.LatLng(latitude,longitude));
								}); //end addListener */
	
								/* var field = new google.maps.Polyline({
									path: fieldCoordinate,
									geodesic: true,
									strokeColor: '#FF0000',
									strokeOpacity: 1.0,
									strokeWeight: 2
								});
	
								field.setMap(map); */
	
								// Shapes options for drawing manager
								var polyOptions = {
									/* fillColor: '#17A589',
									strokeColor: '#ffbf00', */
									strokeWeight: 3,
									fillOpacity: 0.55,
									clickable: true,
									draggable: true,
									editable: true,
									geodesic: true,
									zIndex: 1
								};
	
								// Drawing a shapes
								drawingManager = new google.maps.drawing.DrawingManager({
									// Default drawing mode
									drawingMode: google.maps.drawing.OverlayType.PAN,//MARKER,
									drawingControl: true,
									drawingControlOptions: {
										position: google.maps.ControlPosition.TOP_RIGHT,
										drawingModes: [
											google.maps.drawing.OverlayType.POLYGON,
											google.maps.drawing.OverlayType.RECTANGLE
										]
									},
									rectangleOptions: polyOptions,
									polygonOptions: polyOptions,
									map: map
								});
	
	
								google.maps.event.addListener(drawingManager, 'overlaycomplete', function (event) {
									var newShape = event.overlay;
									var path;
									newShape.type = event.type;
									//if(newShape.type !== google.maps.drawing.OverlayType.MARKER){
										// Switch back to non-drawing mode after drawing a shape.
										drawingManager.setDrawingMode(null);
	
										if (newShape.type === 'rectangle') {
											coordinates.length = 0;
											console.log('rectangle');
											var rectangle = event.overlay;
											var bounds = rectangle.getBounds();
											var NE = bounds.getNorthEast();
											var SW = bounds.getSouthWest();
											var NW = new google.maps.LatLng(NE.lat(), SW.lng());
											var SE = new google.maps.LatLng(SW.lat(), NE.lng());
											coordinates.push(NE.toUrlValue(14));
											coordinates.push(NW.toUrlValue(14));
											coordinates.push(SW.toUrlValue(14));
											coordinates.push(SE.toUrlValue(14));
										}
										if (event.type === 'polygon'){
											coordinates.length = 0;
											console.log('polygon');
											var polygon = event.overlay;
											var len = polygon.getPath().getLength();
	
											for (var i = 0; i < len; i++) {
											//console.log(polygon.getPath().getAt(i).toString());//toUrlValue(5));
												coordinates.push(polygon.getPath().getAt(i).toUrlValue(14));
											}
										}
										// Add an event listener that selects the newly-drawn shape when the user
										// mouses down on it.
										google.maps.event.addListener(newShape, 'click', function (event) {
											if (event.vertex !== undefined) {
												if (newShape.type === google.maps.drawing.OverlayType.POLYGON) {
													path = newShape.getPaths().getAt(event.path);
													path.removeAt(event.vertex);
													if (path.length < 3) {
														newShape.setMap(null);
													}
												}
												if (newShape.type === google.maps.drawing.OverlayType.POLYLINE) {
													path = newShape.getPath();
													path.removeAt(event.vertex);
													if (path.length < 2) {
														newShape.setMap(null);
													}
												}
											}
											//setSelection(newShape);
										});
										//setSelection(newShape);
									//}
									/* else{
										var lat, lng;
										var marker = event.overlay;
										coordinates.length = 0;
										lat = marker.position.lat().toString();
										lng = marker.position.lng().toString();
										coordinates.push(marker.position.toUrlValue(14));
										Get_Elevation_Elevator(marker.position);
	
										google.maps.event.addListener(newShape, 'click', function (event) {
											setSelection(newShape);
										});
										setSelection(newShape);
									} */
									
									console.log(coordinates);
								});
								
							 }
					</script>
					<script async defer src="https://maps.googleapis.com/maps/api/js?key=<api_key>&libraries=drawing,places&callback=initMap"></script>
				</div>
        </div>
	<!-- beginning of the footer -->

       <!-- <footer class="container" style="margin-top: 50px;">
         <nav class="footer-nav">
           <ul>
             <li><a href="">About</a></li>
             <li><a href="">Help</a></li>
             <li><a href="">Contact</a></li>
           </ul>
         </nav>

         <p class="copyright">Copyright 2016 Learned IT! LLC. All rights reserved.</p>

         <nav class="social-nav">
           <ul>
             <li>
               <a href="">
                 <i class="fa fa-google"></i>
               </a>
             </li>
             <li>
               <a href="">
                 <i class="fa fa-facebook"></i>
               </a>
             </li>
             <li>
               <a href="">
                 <i class="fa fa-twitter"></i>
               </a>
             </li>
             <li>
               <a href="">
                 <i class="fa fa-linkedin"></i>
               </a>
             </li>
           </ul>
         </nav>
       </footer> -->
    <!-- end of the footer -->
    </body>
    <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.nicescroll/3.6.8-fix/jquery.nicescroll.min.js"></script> -->
    <script type="text/javascript">
         $(document).ready(function () {
             $('#sidebarCollapse').on('click', function () {
                 $('#sidebar').toggleClass('active');
	 		  	 $('#shrink-menu').toggleClass('glyphicon-menu-right');
             });
          });
         
         /* function findLocation(){
        		var lat = '41.49212083968779', 
        			lng = '-99.415283203125';
	        	 if(navigator.geolocation){
					var latitude, longitude;
					navigator.geolocation.getCurrentPosition(function (location){
						latitude = location.coords.latitude;
						longitude = location.coords.longitude;
						return [latitude, longitude];
						alert(latitude, ", ", longitude);
					});
					center={lat: latitude, lng: longitude}; 
				}
         } */
      </script>
</html>