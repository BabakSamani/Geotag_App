<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin Home page</title>
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
                    <li>
                        <a href="adminMap.jsp">
                            <i class="glyphicon glyphicon-road"></i>
                            Map
                        </a>
                    </li>
                    <li class="active">
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
                            <li><a href="#" >
								<span class="glyphicon glyphicon-bullhorn"></span> Logged in as, 
									<jsp:getProperty name="nameBean" property="firstname" />
									<jsp:getProperty name="nameBean" property="lastname" />
								</a>
						   </li>
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
					
					<h2>See All Locations Here:</h2>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
					<div class="line"></div>
					<table class="table table-striped">
					  <thead>
					    <tr>
					    	  <th>#</th>
					      <th class="col-xs-4 col-xs-offset-3">Name</th>
					      <th class="col-xs-4 col-xs-offset-3">Latitude, Longitude</th>
					      <th class="col-xs-4 col-xs-offset-3">Address</th>
					      <th class="col-xs-4 col-xs-offset-3">Rating</th>
					      <th class="col-xs-4 col-xs-offset-3">Tag Date</th>
					      <th class="col-xs-4 col-xs-offset-3">Category Name</th>
					      <!-- <th class="col-xs-4 col-xs-offset-3">Icon</th> -->
					      <th></th>
					    </tr>
					  	<c:set var="length" value="${0}" />
						<c:forEach var="location" items="${alllocations}">
							<c:set var="length" value="${length + 1}" />
						</c:forEach>
						<c:choose>
							<c:when test="${length == '0'}">
								<tr>
									<td></td>
									<td>There is no user in the database!</td>
									<td></td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:set var="count" value="0" scope="page" />
								<c:forEach var="location" items="${alllocations}">
									<c:set var="count" value="${count + 1}" scope="page"/>
									<tr>
										<td><c:out value="${count}"/></th>
										<td><c:out value="${location[0]}"/></th>
										<td><c:out value="${location[1]}, ${location[2]}"/></td>
										<td><c:out value="${location[4]}"/></td>
										<td><c:out value="${location[5]}/5"/></td>
										<td><c:out value="${location[6]}"/></td>
										<td><c:out value="${location[7]}"/></td>
										<%-- <td>
								      		<img class="img-thumbnail" width="10%" height="10%" id="iconImage" src="${location[8]}">
									  	</td> --%>
									  	<td>
								      		<button type="button" class="btn btn-primary">Remove</button>
									  	</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					  </thead>
					</table>
				</div>
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
         
		 function bs_input_file() {
			$(".input-file").before(
				function() {
					if ( ! $(this).prev().hasClass('input-ghost') ) {
						var element = $("<input type='file' class='input-ghost' style='visibility:hidden; height:0'>");
						element.attr("name",$(this).attr("name"));
						element.change(function(){
							element.next(element).find('input').val((element.val()).split('\\').pop());
						});
						$(this).find("button.btn-choose").click(function(){
							element.click();
						});
						$(this).find("button.btn-reset").click(function(){
							element.val(null);
							$(this).parents(".input-file").find('input').val('');
						});
						$(this).find('input').css("cursor","pointer");
						$(this).find('input').mousedown(function() {
							$(this).parents('.input-file').prev().click();
							return false;
						});
						return element;
					}
				}
			);
		}
		$(function() {
			bs_input_file();
		});
      </script>
</html>