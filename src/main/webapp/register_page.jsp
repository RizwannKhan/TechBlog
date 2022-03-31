<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 99%, 67% 95%, 32% 100%, 0 94%, 0 0);
}
</style>
<title>TechBlog - Register</title>
</head>
<body>

	<!-- navbar -->
	<%@include file="navbar.jsp"%>

	<main>
		<div class="container">
			<div class="row">
				<div class="col-md-6 offset-md-3">
					<div class="card">
						<div class="card-header primary-background text-white text-center">
							<span class="fa fa-user-plus fa-3x"></span> <br>
							<p>Register Here !!!</p>
						</div>
						<div class="card-body">
							<form>
								<div class="form-group">
									<label for="username">User Name</label> <input type="text"
										class="form-control" id="username" name="username"
										aria-describedby="emailHelp" placeholder="Enter username">
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">Email address</label> <input
										type="email" class="form-control" id="exampleInputEmail1"
										aria-describedby="emailHelp" placeholder="Enter email">
									<small id="emailHelp" class="form-text text-muted">We'll
										never share your email with anyone else.</small>
								</div>
								<div class="form-group">
									<label for="exampleInputPassword1">Password</label> <input
										type="password" name="password" class="form-control"
										id="exampleInputPassword1" placeholder="Password">
								</div>
								<div class="form-group">
									<label for="gender">Gender</label> <br> <input
										type="radio" id="gender" name="gender"> Male &nbsp; <input
										type="radio" id="gender" name="gender"> Female
								</div>
								<div class="form-group">
									<textarea rows="10" cols="" name="userabout"
										placeholder="Enter something about yourself"></textarea>
								</div>
								<div class="form-check">
									<input type="checkbox" name="condition"
										class="form-check-input" id="exampleCheck1"> <label
										class="form-check-label" for="exampleCheck1">Agree
										terms and conditions</label>
								</div>
								<br>
								<button type="submit" class="btn btn-primary">Submit</button>
							</form>
						</div>
						<div class="card-footer">
							<p>
								Already a member, <a href="login_page"> Login here !!! </a>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>

	<!-- javascript -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"
		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
	<script type="text/javascript" src="js/myjs.js"></script>
</body>
</html>