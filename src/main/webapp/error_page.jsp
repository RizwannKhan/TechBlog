<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<!-- css -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/mystyle.css" type="text/css">
<style type="text/css">
.banner-background {
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 99%, 66% 93%, 32% 100%, 0 92%, 0 0);
}
</style>
<title>Error - Sorry !!!</title>
<!-- add icon link -->
<link rel="icon" href="img/title.png" type="image/x-icon">
</head>
<body>

	<div class="container text-center">
		<img class="img-fluid" alt="Error !!! Sorry, Something went wrong"
			src="img/error1.png">
		<h3 class="display-3">Sorry ! Something went wrong...</h3>
		<h6 class="mt-3"><%=exception%></h6>
		<a class="btn primary-background btn-lg text-white mt-3 display-3"
			href="index"><span class="fa fa-home fa-1x"></span> Home</a>
	</div>

</body>
</html>