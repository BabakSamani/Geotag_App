<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Stay On</title>
	<!-- Bootstrap core CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
	<jsp:useBean id="nameBean" type="models.User" scope="session" />
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
	
</head>
<body >
	<!-- ---
	layout: error_page
	title: 500 Internal Server Error
	--- -->
	<div class="container">
	  <!-- Jumbotron -->
	  <div class="jumbotron">
	    <h1><i class="fa fa-shield fa-flip-horizontal orange"></i> You are still on!</h1>
	    <p class="lead">You have already signed in under name of "<em><jsp:getProperty name="nameBean" property="firstname" /> <jsp:getProperty name="nameBean" property="lastname" />".</em></p>
	    <p>
	    		<a href="userhome.jsp" class="btn btn-default btn-lg"><span class="green">Sign On</span></a>
	    		<a href="SignOut" class="btn btn-default btn-lg"><span class="orange">Sign Out</span></a>
	        
	    </p>
	  </div>
	</div>
	<div class="container">
	  <div class="body-content">
	    <div class="row">
	      <div class="col-md-6">
	        <h2>What happened?</h2>
	        <p class="lead">It seams your session has not terminated yet and you are trying to sign in with your account again.
	        Please sign out from your account or click on sign on button to go back to your home page.</p>
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