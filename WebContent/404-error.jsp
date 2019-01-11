<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Error 404</title>
	<jsp:useBean id="nameBean" type="models.User" scope="session" />
	<!-- Bootstrap core CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
	<style>
	/* Error Page Inline Styles */
	body {
	  padding-top: 20px;
	}
	/* Layout */
	.jumbotron {
	  font-size: 21px;
	  font-weight: 200;
	  line-height: 2.1428571435;
	  color: inherit;
	  padding: 10px 0px;
	}
	/* Everything but the jumbotron gets side spacing for mobile-first views */
	.masthead, .body-content, {
	  padding-left: 15px;
	  padding-right: 15px;
	}
	/* Main marketing message and sign up button */
	.jumbotron {
	  text-align: center;
	  background-color: transparent;
	}
	.jumbotron .btn {
	  font-size: 21px;
	  padding: 14px 24px;
	}
	/* Colors */
	.green {color:#5cb85c;}
	.orange {color:#f0ad4e;}
	.red {color:#d9534f;}
	</style>
	<script type="text/javascript">
	  function loadDomain() {
	    var display = document.getElementById("display-domain");
	    display.innerHTML = document.domain;
	  }
	</script>
</head>
<body onload="javascript:loadDomain();">
	<!-- ---
	layout: error_page
	title: 500 Internal Server Error
	--- -->
	<div class="container">
	  <!-- Jumbotron -->
	  <div class="jumbotron">
	    <h1><i class="fa fa-frown-o red"></i> Error 404</h1>
	    <p class="lead">We couldn't find what you're looking for on <em><span id="display-domain"></span></em>.</p>
	    <c:choose>
			<c:when test="${nameBean.type == '1'}">
				<a href="/Geotag_App/adminhome.jsp" class="btn btn-default btn-lg text-center"><span class="green">Take Me To The Homepage</span></a>
			</c:when>
			<c:when test="${nameBean.type == null}">
				<script>
				  window.location.href = "/Geotag_App/Index.jsp";
				</script>
			</c:when>
			<c:otherwise>
				<a href="/Geotag_App/userhome.jsp" class="btn btn-default btn-lg text-center"><span class="green">Take Me To The Homepage</span></a>
			</c:otherwise>
		</c:choose>
	    <!-- <p><a onclick=javascript:checkSite(); class="btn btn-default btn-lg"><span class="green">Take Me To The Homepage</span></a> -->
	        <!-- <script type="text/javascript">
	            function checkSite(){
	              	var currentSite = window.location.hostname;
	                	window.location = "http://" + currentSite + ":8080/Geotag_App/Index.jsp";
	            }
	        </script> -->
	    </p>
	  </div>
	</div>
	<div class="container">
	  <div class="body-content">
	    <div class="row">
	      <div class="col-md-6">
	        <h2>What happened?</h2>
	        <p class="lead">A 404 error status implies that the file or page that you're looking for could not be found.</p>
	      </div>
	      <div class="col-md-6">
	        <h2>What can I do?</h2>
	        <p class="lead">If you're a site visitor</p>
	        <p>Please use your browser's back button and check that you're in the right place. If you need immediate assistance, please send us an email instead.</p>
	        <p class="lead">If you're the site owner</p>
	         <p>Please check that you're in the right place and get in touch with your website provider if you believe this to be an error.</p>
	     </div>
	    </div>
	  </div>
	</div>
	<!-- End Error Page Content -->
	<!--Scripts-->
	<!-- jQuery library -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>