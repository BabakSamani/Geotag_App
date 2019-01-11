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
	<div id="id03" class="modal">
	  <span onclick="document.getElementById('id03').style.display='none'" class="close" title="Close Modal">x</span>
	  <form class="modal-content-tag animate" action="TagLocation" method="post">
	  	<div class="container1">
	  		<h4>Tag this location?</h4>
	    	  	<input type="hidden" id="latitude-input" name="inputLat" value="">	  
			<input type="hidden" id="longitude-input" name="inputLon" value="">	  
			<input type="hidden" id="elevation-input" name="inputAlt" value="">
			
		    <div class="form-group col-md-12">
			      <label><b>Location Name:</b></label>
			      <input type="text" class="form-control" id="inputLocation" name="locName" required>
		    </div>
		    <div class="form-group col-md-12">
				<label><b>Location Category:</b></label>
			  	<select id="inputCategory" name="category" class="form-control">
		        		<option selected>Choose...</option>
		        		<option>Restroom</option>
		        		<option>Restaurant</option>
		        		<option>Shower</option>
		        		<option>Car wash</option>
		        		<option>School</option>
		        		<option>Store</option>
		        		<option>Gym</option>
		        		<option>Library</option>
		        		<option>Coffeeshop</option>
		      	</select>
		    </div>
		    <div class="form-group">
		    		<label><b>Your rating:</b></label>
		    		<span id="count"> 0</span>
		        <div id="stars" class="starrr" ></div>
		        <input type="hidden" id="count-rating" name="inputRating" value="">
	        </div>
		    <div class="clearfix">
		        <button id="buttons" type="button" onclick="document.getElementById('id03').style.display='none'" class="nobtn">No</button>
		        <button id="buttons" type="submit" class="yesbtn">Yes</button>
		    </div>
	     </div>
	  </form>
	</div>
	
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
			<!-- <div class="container" style="position: relative; top:80px;"> -->
				<div class="col-md-12" style="position: relative; top:50px;">
					<input id="pac-input" class="controls" type="text" placeholder="Search Box">
					<div id="map-canvas"></div>
					<script>
							var gmarkers = [];
							var map;
							var chicago = {lat: 41.85, lng: -87.65};
							
							function tagPlace(tagDiv, map) {

						        // Set CSS for the control border.
						        var tagUI = document.createElement('div');
						        tagUI.style.backgroundColor = '#006699';
						        tagUI.style.border = '2px solid #fff';
						        tagUI.style.borderRadius = '3px';
						        tagUI.style.boxShadow = '0 2px 6px rgba(0,0,0,.3)';
						        tagUI.style.cursor = 'pointer';
						        tagUI.style.marginTop = '10px';
						        tagUI.style.marginRight = '10px';
						        tagUI.style.marginBottom = '25px';
						        tagUI.style.textAlign = 'center';
						        tagUI.title = 'Click to the location';
						        tagDiv.appendChild(tagUI);

						        // Set CSS for the control interior.
						        var controlText = document.createElement('div');
						        controlText.style.color = '#fff';
						        controlText.style.fontFamily = 'Roboto,Arial,sans-serif';
						        controlText.style.fontSize = '16px';
						        controlText.style.lineHeight = '38px';
						        controlText.style.paddingLeft = '5px';
						        controlText.style.paddingRight = '5px';
						        controlText.innerHTML = 'Tag it';
						        tagUI.appendChild(controlText);

						        // Setup the click event listeners to run the tag location form
						        tagUI.addEventListener('click', function(){
						        		if(gmarkers.length === 0){
						        			 swal(
					        					  'Oops!',
					        					  'Please click on the map first to tag a location!',
					        					  'warning'
						        				);
						        		}else{
						        			document.getElementById('id03').style.display = 'block';
						        		}
						        });
						      }
							
							/* function displayLocationElevation(location, elevator, infowindow) {
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
							} */
	
							function Get_Elevation_Elevator(location){
								//console.log('The Get_Elevation_Elevator function is being called!');
								var elevator = new google.maps.ElevationService;
								var elevation;
								// Initiate the location request
								if(elevator){
									elevator.getElevationForLocations({'locations': [location]}, function (results, status){
										if(status === 'OK'){
											//console.log('Line 131: The length is ' + results.length);
											elevation = results[0].elevation.toString();
										}
										else {
											console.log("Elevator is failed: " + status);
										}
										console.log(elevation); // prints out the elevation here
										document.getElementById("elevation-input").value = elevation;
									});
								}
							}
	
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
									//mapTypeId: 'hybrid',
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
								
								
								// Create the DIV to hold the control and call the CenterControl()
						        // constructor passing in this DIV.
						        var tagDiv = document.createElement('div');
						        var tagButton = new tagPlace(tagDiv, map);

						        tagDiv.index = 1;
						        map.controls[google.maps.ControlPosition.TOP_RIGHT].push(tagDiv);
								
								
								/* function placeMarker(map, location) {
									var lat, lng;
									/* var image = {
										    url: 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png',
										    // This marker is 20 pixels wide by 32 pixels high.
										    size: new google.maps.Size(20, 32),
										    // The origin for this image is (0, 0).
										    origin: new google.maps.Point(0, 0),
										    // The anchor for this image is the base of the flagpole at (0, 32).
										    anchor: new google.maps.Point(0, 32)
										  }; 
									// When the user clicks on div, open the popup
									var marker = new google.maps.Marker({
										  animation: google.maps.Animation.DROP,
										  /* clickable: true,
										  draggable: true,
										  editable:  true, 
										  position: location,
										  icon: "http://www.codeshare.co.uk/images/blue-pin.png",
										  /* icon: image, 
										  map: map
									 });
									
									lat = marker.position.lat().toString();
									lng = marker.position.lng().toString();
									//Get_Elevation_Elevator(marker.position);
									/* document.getElementById("inputLat").value = lat;
									document.getElementById("inputLon").value = lng; */
									/* coordinates.push(marker.position.toUrlValue(14)); 
									
									var popup = '<form class="popup" action="TagLocation" method="post">'
											  + '<h5>Tag this location?</h5>'
										      
											  + '<input type="hidden" id="latitude-input" name="inputLat" value="' + lat + '">'	  
											  + '<input type="hidden" id="longitude-input" name="inputLon" value="' + lng + '">'	  
											  + '<input type="hidden" id="elevation-input" name="inputAlt" value="">'

								    			  + '<div class="form-group">'
								      		  + '<input type="text" id="disabledTextInput" name="locName" class="form-control" placeholder="Enter location name">'
								    			  + '</div>'
								    			  + '<div class="form-group">'
								      		  + '<select id="disabledSelect" name="category" class="form-control">'
								       		  + '<option>Select a category</option>'
								       		  + '<option>Restroom</option>'
										      + '<option>Restarea</option>'
										      + '<option>Shower</option>'
										      + '<option>Carwash</option>'
								   			  + '</select>'
										      + '</div>'
										      
										      + '<div class="form-group">'
										      + '<div id="stars" class="starrr" data-rating=\'2\'></div>'
										      + '<input type="hidden" id="count-rating" name="inputRating" value="">'
										      + '<span id="count">2</span>'
										      + '</div>'
											  
										      + '<button style="width: 48%" type="button" class="btn btn-warning">No</button>'
										      + '<span>  </span>'
										      + '<button style="width: 48%" type="submit" class="btn btn-success">Yes</button>'
											  + '</form>';
								  	 var infowindow = new google.maps.InfoWindow({
								  		 content: popup,
								  		 shadowStyle: 1,
								  		 padding: 50,
								  		 backgroundColor: 'rgb(57,57,57)',
								  		 borderRadius: 5,
								  		 arrowSize: 10,
								  		 borderWidth: 1,
								  		 borderColor: '#2c2c2c',
								  		 disableAutoPan: true,
								  		 hideCloseButton: true,
								  		 arrowPosition: 30,
								  		 backgroundClassName: 'transparent',
								  		 arrowStyle: 2
								  	 });
								  	infowindow.open(map,marker);
								  	loadStars();
									Get_Elevation_Elevator(location);
									console.log("Elevation in infoWindow: ", document.getElementsByName("inputAlt").value);
									
								}
								
								google.maps.event.addListener(map, 'click', function(event) {
								    placeMarker(map, event.latLng);
								  });
								
								
								// Drawing a shapes
								/* drawingManager = new google.maps.drawing.DrawingManager({
									// Default drawing mode
									drawingControl: true,
									drawingControlOptions: {
										position: google.maps.ControlPosition.TOP_RIGHT,
										drawingModes: [ 
											google.maps.drawing.OverlayType.PAN, 
											google.maps.drawing.OverlayType.MARKER 
											]
									},
									markerOption:{
										animation: google.maps.Animation.DROP,
										clickable: true,
										draggable: true,
										editable:  true
									},
									map: map
								}); */
								
								// Drawing a shapes
								drawingManager = new google.maps.drawing.DrawingManager({
									// Default drawing mode
									drawingControl: false,
									drawingControlOptions: {
										position: google.maps.ControlPosition.TOP_RIGHT,
										drawingModes: [
											google.maps.drawing.OverlayType.MARKER
											/*google.maps.drawing.OverlayType.PAN,
											google.maps.drawing.OverlayType.CIRCLE,
											google.maps.drawing.OverlayType.POLYGON,
											google.maps.drawing.OverlayType.RECTANGLE,
											google.maps.drawing.OverlayType.POLYLINE */
										]
									},
									markerOption:{
										animation: google.maps.Animation.DROP,
										clickable: true,
										draggable: true,
										editable:  true
									},
									/* circleOptions: polyOptions,
									rectangleOptions: polyOptions,
									polygonOptions: polyOptions,
									polylineOptions: polyOptions, */
									map: map
								});
								
								google.maps.event.addListener(map, 'click', function(event) {
									removeMarkers();
									var location = event.latLng;
									var marker = new google.maps.Marker({
										  animation: google.maps.Animation.DROP,
										  position: location,
										  /* icon: {
							                  path: google.maps.SymbolPath.BACKWARD_CLOSED_ARROW,
							                  fillColor: '#db610a',
							                  fillOpacity: 0.9,
							                  scale: 5,
							                  strokeWeight:3,
							                  strokeColor:"#B40404"
							               }, */
										  icon: 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png',
										  //icon: "http://www.codeshare.co.uk/images/blue-pin.png",
										 map: map
									 });
									var lat, lng;
									
									lat = marker.position.lat().toString();
									lng = marker.position.lng().toString();
									document.getElementById("latitude-input").value = lat;
									document.getElementById("longitude-input").value = lng;
									Get_Elevation_Elevator(marker.position);
									//document.getElementById('id03').style.display = 'block';
									
									// Push your newly created marker into the array:
									gmarkers.push(marker);
								});
								
								function removeMarkers(){
								    for(i=0; i<gmarkers.length; i++){
								        gmarkers[i].setMap(null);
								    }
								}
								
								/* google.maps.event.addListener(drawingManager, 'overlaycomplete', function (event) {
									var lat, lng;
									var marker = event.overlay;
									lat = marker.position.lat().toString();
									lng = marker.position.lng().toString();
									document.getElementById("latitude-input").value = lat;
									document.getElementById("longitude-input").value = lng;
									Get_Elevation_Elevator(marker.position);
								}); */
								
								$('.nobtn').click(function(){
									for(i=0; i<gmarkers.length; i++){
								        gmarkers[i].setMap(null);
								    }
									gmarkers = [];
								});
							 }
					</script>
					<script async defer src="https://maps.googleapis.com/maps/api/js?key=<api_key>&libraries=drawing,places&callback=initMap"></script>
					<script type="text/javascript">
						// Get the modal
						var modal_3 = document.getElementById('id03');
					
						// When the user clicks anywhere outside of the modal, close it
						window.onclick = function(event) {
						    if (event.target === modal_3) {
						        modal_3.style.display = "none";
						    }
						}
						
						var __slice = [].slice;
						
						(function($, window) {
						  var Starrr;

						  Starrr = (function() {
						    Starrr.prototype.defaults = {
						      rating: void 0,
						      numStars: 5,
						      change: function(e, value) {}
						    };

						    function Starrr($el, options) {
						      var i, _, _ref,
						        _this = this;

						      this.options = $.extend({}, this.defaults, options);
						      this.$el = $el;
						      _ref = this.defaults;
						      for (i in _ref) {
						        _ = _ref[i];
						        if (this.$el.data(i) != null) {
						          this.options[i] = this.$el.data(i);
						        }
						      }
						      this.createStars();
						      this.syncRating();
						      this.$el.on('mouseover.starrr', 'span', function(e) {
						        return _this.syncRating(_this.$el.find('span').index(e.currentTarget) + 1);
						      });
						      this.$el.on('mouseout.starrr', function() {
						        return _this.syncRating();
						      });
						      this.$el.on('click.starrr', 'span', function(e) {
						        return _this.setRating(_this.$el.find('span').index(e.currentTarget) + 1);
						      });
						      this.$el.on('starrr:change', this.options.change);
						    }

						    Starrr.prototype.createStars = function() {
						      var _i, _ref, _results;

						      _results = [];
						      for (_i = 1, _ref = this.options.numStars; 1 <= _ref ? _i <= _ref : _i >= _ref; 1 <= _ref ? _i++ : _i--) {
						        _results.push(this.$el.append("<span class='glyphicon .glyphicon-star-empty'></span>"));
						      }
						      return _results;
						    };

						    Starrr.prototype.setRating = function(rating) {
						      if (this.options.rating === rating) {
						        rating = void 0;
						      }
						      this.options.rating = rating;
						      this.syncRating();
						      return this.$el.trigger('starrr:change', rating);
						    };

						    Starrr.prototype.syncRating = function(rating) {
						      var i, _i, _j, _ref;

						      rating || (rating = this.options.rating);
						      if (rating) {
						        for (i = _i = 0, _ref = rating - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
						          this.$el.find('span').eq(i).removeClass('glyphicon-star-empty').addClass('glyphicon-star');
						        }
						      }
						      if (rating && rating < 5) {
						        for (i = _j = rating; rating <= 4 ? _j <= 4 : _j >= 4; i = rating <= 4 ? ++_j : --_j) {
						          this.$el.find('span').eq(i).removeClass('glyphicon-star').addClass('glyphicon-star-empty');
						        }
						      }
						      if (!rating) {
						        return this.$el.find('span').removeClass('glyphicon-star').addClass('glyphicon-star-empty');
						      }
						    };

						    return Starrr;

						  })();
						  return $.fn.extend({
						    starrr: function() {
						      var args, option;

						      option = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
						      return this.each(function() {
						        var data;

						        data = $(this).data('star-rating');
						        if (!data) {
						          $(this).data('star-rating', (data = new Starrr($(this), option)));
						        }
						        if (typeof option === 'string') {
						          return data[option].apply(data, args);
						        }
						      });
						    }
						  });
						})(window.jQuery, window);

						$(function() {
						  return $(".starrr").starrr();
						});

						$( document ).ready(function() {
							
						  $('#stars').on('starrr:change', function(e, value){
						    $('#count').html(value);
						    document.getElementById('count-rating').value = value;
						  });
						  
						  $('#stars-existing').on('starrr:change', function(e, value){
						    $('#count-existing').html(value);
						    document.getElementById('count-rating').value = value;
						  });
						});
						
						
						
				</script>
				</div>
			<!-- </div> -->
		</div>
	</div>
</body>
</html>
