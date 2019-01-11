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
				var coordinates = [];
				var map;
				// Default latitude and longitude for the center of the map
				var center = {lat: 41.49212083968779, lng: -99.415283203125};

				function colorControl(controlDiv) {
					console.log('color control panel was called!'); // Print on the log
					// Set CSS for the control border.
					var colorUI = document.createElement('div');
					colorUI.style.backgroundColor = '#fff';
					colorUI.style.border = '2px solid #fff';
					colorUI.style.borderRadius = '2px';
					colorUI.style.boxShadow = '0 2px 6px rgba(0,0,0,.3)';
					colorUI.style.cursor = 'pointer';
					colorUI.style.width = '200px';
					colorUI.style.marginTop = '5px';
					colorUI.style.marginBottom = '15px';
					colorUI.title = 'Color panel';
					colorUI.id = 'panel';
					colorUI.appendChild(controlDiv);

					// Set CSS for the control interior.
					var colorPalette = document.createElement('div');
					colorPalette.style.clear = 'both';
					colorPalette.id = 'color-palette';
					colorUI.appendChild(colorPalette);
				}

				
				function Delete_Button(deleteDiv) {
					// Set CSS for the control border.
					var deleteUI = document.createElement('div');
					deleteUI.style.backgroundColor = '#fff';
					deleteUI.style.border = '2px solid #fff';
					deleteUI.style.borderRadius = '2px';
					deleteUI.style.boxShadow = '0 2px 6px rgba(0,0,0,.3)';
					deleteUI.style.cursor = 'pointer';
					deleteUI.style.marginTop = '5px';
					deleteUI.style.marginBottom = '15px';
					deleteUI.style.textAlign = 'center';
					deleteUI.title = 'delete shape';
					deleteUI.id = 'delete-button';
					deleteDiv.appendChild(deleteUI);

					// Set CSS for the control interior.
					var deleteText = document.createElement('div');
					deleteText.style.color = 'rgb(25,25,25)';
					deleteText.style.fontFamily = 'Roboto,Arial,sans-serif';
					deleteText.style.fontSize = '12px';
					deleteText.style.lineHeight = '21px';
					deleteText.style.paddingLeft = '5px';
					deleteText.style.paddingRight = '5px';
					deleteText.innerHTML = 'Delete selected shape';
					deleteUI.appendChild(deleteText);

					// Setup the click event listeners: simply set the map to Chicago.
					deleteUI.addEventListener('click', function() {
						deleteSelectedShape();
						coordinates.length = 0;
						console.log(coordinates); // Print on the log
					});
				}

				
				/* This function converts 'X' degrees to radians.*/
				/* function toRadians(x) {
					return (x * Math.PI / 180);
				}
				function distance_calculator(lat1,lng1,lat2,lng2) {
					var R = 6371e3; // metres
					var φ1 = toRadians(lat1);
					var φ2 = toRadians(lat2);
					var Δφ = toRadians((lat2-lat1));
					var Δλ = toRadians((lng2-lng1));

					var a = Math.sin(Δφ/2) * Math.sin(Δφ/2) +
							Math.cos(φ1) * Math.cos(φ2) *
							Math.sin(Δλ/2) * Math.sin(Δλ/2);
					var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));

					return R * c;
				} */

				/* function Circle_Coordinate_Generator(center_lat, center_lng, radius){
					var coordinates = [];
					var lat1 = toRadians(center_lat); 	// Convert to radian
					var lng1 = toRadians(center_lng); 	// convert to radian
					var R = radius/(3956*1609.344);		// Convert the radius to radian
					var lat, lng, dlng;
					for(var tc=0; tc <= 360; tc++){
						var tcRadian = toRadians(tc);
						// Starting from North
						// Condition for North
						if(tcRadian == 0){
							lat = lat1 + R;
						}
						// Condition for South
						else if (tcRadian == Math.PI) {
							lat = lat1 - R;
						}
						// Condition for East and West
						else if (tcRadian == (Math.PI/2) || tcRadian == (3 * Math.PI/2)){
							lat = Math.asin(Math.sin(lat1) * Math.cos(R));
						}
						// Condition for other cases
						else{
							lat = Math.asin(Math.sin(lat1) * Math.cos(R) + Math.cos(lat1) * Math.sin(R) * Math.cos(tcRadian));
						}

						if(Math.cos(lat) == 0){
							lng = lng1;
						}
						else{
							dlng = Math.atan2(Math.sin(tcRadian) * Math.sin(R) * Math.cos(lat1), Math.cos(R) - Math.sin(lat1) * Math.sin(lat));
							lng = ((lng1-dlng + Math.PI) % (2 * Math.PI)) - Math.PI;
						}
						var point = [lng * 57.2958, lat * 57.2958];
						coordinates.push(point);
					}
					return coordinates;
				} */

				var selectedShape;
				var drawingManager;
				var colors = ['#00edff', '#FF1493', '#32CD32', '#FF8C00', '#4B0082'];
				var selectedColor;
				var colorButtons = {};

				function clearSelection () {
					if (selectedShape) {
						if (selectedShape.type !== 'marker') {
							selectedShape.setEditable(false);
						}
						selectedShape = null;
					}
				}
				function setSelection (shape) {
					if (shape.type !== 'marker') {
						clearSelection();
						shape.setEditable(true);
						selectColor(shape.get('fillColor') || shape.get('strokeColor'));
					}
					selectedShape = shape;
				}
				function deleteSelectedShape () {
					if (selectedShape) {
						selectedShape.setMap(null);
					}
				}

				function selectColor (color) {
					selectedColor = color;
					for (var i = 0; i < colors.length; ++i) {
						var currColor = colors[i];
						colorButtons[currColor].style.border = currColor == color ? '2px solid #789' : '2px solid #fff';
					}

					// Retrieves the current options from the drawing manager and replaces the
					// stroke or fill color as appropriate.
					var polylineOptions = drawingManager.get('polylineOptions');
					polylineOptions.strokeColor = color;
					drawingManager.set('polylineOptions', polylineOptions);

					var rectangleOptions = drawingManager.get('rectangleOptions');
					rectangleOptions.fillColor = color;
					drawingManager.set('rectangleOptions', rectangleOptions);

					var circleOptions = drawingManager.get('circleOptions');
					circleOptions.fillColor = color;
					drawingManager.set('circleOptions', circleOptions);

					var polygonOptions = drawingManager.get('polygonOptions');
					polygonOptions.fillColor = color;
					drawingManager.set('polygonOptions', polygonOptions);
				}
				
				function setSelectedShapeColor (color) {
					if (selectedShape) {
						selectedShape.set('fillColor', color);
						if (selectedShape.type == google.maps.drawing.OverlayType.POLYLINE) {
							selectedShape.set('strokeColor', color);
						} else {
							selectedShape.set('fillColor', color);
						} 
					}
				}

				function makeColorButton (color) {
					var button = document.createElement('span');
					button.className = 'color-button';
					button.style.backgroundColor = color;
					google.maps.event.addDomListener(button, 'click', function () {
						selectColor(color);
						setSelectedShapeColor(color);
					});

					return button;
				}

				function buildColorPalette () {
					var colorPalette = document.getElementById('color-palette');
					for (var i = 0; i < colors.length; ++i) {
						var currColor = colors[i];
						var colorButton = makeColorButton(currColor);
						colorPalette.appendChild(colorButton);
						colorButtons[currColor] = colorButton;
					}
					selectColor(colors[0]);
				}

				
				window.initMap = function(){
//					var directionsService = new google.maps.DirectionsService();
//					directionsDisplay = new google.maps.DirectionsRenderer();

					map = new google.maps.Map(document.getElementById('map-canvas'), {
						mapTypeControlOptions: {style:google.maps.MapTypeControlStyle.DROPDOWN_MENU},
						center: center,
						mapTypeId: google.maps.MapTypeId.MAP,
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

						if (places.length == 0) {
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

					// Create the DIV to hold the control and call the Delete_Button()
					// constructor passing in this DIV.
					var deleteButtonDiv = document.createElement('div');
					var deleteButton = new Delete_Button(deleteButtonDiv);

					deleteButtonDiv.index = 1;
					map.controls[google.maps.ControlPosition.TOP_RIGHT].push(deleteButtonDiv);

					
					var colorPaletteDiv = document.createElement('div');
					var colorPalette = new colorControl(colorPaletteDiv);

					colorPaletteDiv.index = 1;
					map.controls[google.maps.ControlPosition.TOP_RIGHT].push(colorPaletteDiv);

					// Shapes options for drawing manager
					var polyOptions = {
						fillColor: '#00edff',
						strokeColor: '#0043ff',
						strokeWeight: 3,
						fillOpacity: 0.55,
						/* clickable: true,
						draggable: true,
						editable: true, */
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
						
						// Switch back to non-drawing mode after drawing a shape.
						drawingManager.setDrawingMode(null);
						// shape type rectangle
						if (newShape.type === 'rectangle') {
							coordinates.length = 0;
							console.log('rectangle');
							var rectangle = event.overlay;
							var bounds = rectangle.getBounds();
							var NE = bounds.getNorthEast();
							var SW = bounds.getSouthWest();
							var NW = new google.maps.LatLng(NE.lat(), SW.lng());
							var SE = new google.maps.LatLng(SW.lat(), NE.lng());
							coordinates.push(NE.toUrlValue(20));
							coordinates.push(NW.toUrlValue(20));
							coordinates.push(SW.toUrlValue(20));
							coordinates.push(SE.toUrlValue(20));
							
							var stringCoordinates = coordinatesToString(coordinates);
							sendData(stringCoordinates);
							
							swal({
								  title: '',
								  text: "Do you want to generate MLPQ input text?",
								  type: 'question',
								  showCancelButton: true,
								  confirmButtonColor: '#3085d6',
								  cancelButtonColor: '#d28900',
								  confirmButtonText: 'Yes',
								  cancelButtonText: 'Cancel',
								  buttonsStyling: true,
		                          focusConfirm: true,
								  allowOutsideClick: false
							}).then(function (result) {
								if (result) {
									window.location = "http://localhost:8080/Geotag_App/MLPQresult/MLPQresult.html";
							  	} 
							},function(dismiss){
								console.log("It is canceled!");
							  	newShape.setMap(null);
							});
						}
						// Shape type polygon
						if (event.type === 'polygon'){
							coordinates.length = 0;
							console.log('polygon');
							var polygon = event.overlay;
							var len = polygon.getPath().getLength();

							for (var i = 0; i < len; i++) {
								coordinates.push(polygon.getPath().getAt(i).toUrlValue(20));
							}
							
							var stringCoordinates = coordinatesToString(coordinates);
							sendData(stringCoordinates);
							/* swal({
					        	  title: 'Generating the MLPQ ...',
					        	  text: '',
					        	  timer: 5000,
					        	  onOpen: function () {
					        	    swal.showLoading();
					        	  }
					        	}).then(
					        		  function () {
					        			  
					        		  },
						        	  // handling the promise rejection
						        	  function (dismiss) {
						        	    if (dismiss === 'timer') {
						        	      console.log('I was closed by the timer')
						        	    }
					        	  }); */
			        			  swal({
								  title: '',
								  text: "Do you want to generate MLPQ input text?",
								  type: 'question',
								  showCancelButton: true,
								  confirmButtonColor: '#3085d6',
								  cancelButtonColor: '#d28900',
								  confirmButtonText: 'Yes',
								  cancelButtonText: 'Cancel',
								  buttonsStyling: true,
		                          focusConfirm: true,
								  allowOutsideClick: false
								}).then(function (result) {
									if (result) {
										window.location = "http://localhost:8080/Geotag_App/MLPQresult/MLPQresult.html";
								  	} 
								},function(dismiss){
									console.log("It is canceled!");
								  	newShape.setMap(null);
								});
					        		
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
								/* if (newShape.type === google.maps.drawing.OverlayType.POLYLINE) {
									path = newShape.getPath();
									path.removeAt(event.vertex);
									if (path.length < 2) {
										newShape.setMap(null);
									}
								} */
							}
							setSelection(newShape);
						});
						setSelection(newShape);
					});
					
					// Clear the current selection when the drawing mode is changed, or when the
					// map is clicked.
					google.maps.event.addListener(drawingManager, 'drawingmode_changed', clearSelection);
					google.maps.event.addListener(map, 'click', clearSelection);

					//buildColorPalette();
				 }
				
				function sendData(Coordinates){
					$.ajax({
					    url: './MLPQgenerator',
					    data: {
					        "coordinates": Coordinates
					    },
					    type: 'POST',
					    success: function () {
					    		console.log("Success!");
					    }
					});
				}
				
				function coordinatesToString(coordinates){
					var len = coordinates.length;
					var result = coordinates[0];
					for (var i = 1; i < len; i++) {
							result = result + ": " + coordinates[i];
						}
					return result;
				}
				</script>
				<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC-2uqBhq1_iCmt0OFu7eLEbZlHIVl2Ckk&libraries=drawing,places&callback=initMap"></script>	
				<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
				<script src="https://cdnjs.cloudflare.com/ajax/libs/core-js/2.4.1/core.js"></script>
			</div>
			<div class="">
				<div id="panel">
					<div id="color-palette"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
