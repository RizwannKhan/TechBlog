<%@page import="java.util.List"%>
<%@page import="com.techblog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.helper.DBConnectionUtil"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@page import="com.techblog.helper.PasswordEncoder"%>
<%@page import="com.techblog.entities.Message"%>
<%@page import="com.techblog.entities.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page errorPage="error_page.jsp"%>
<%
User user = (User) session.getAttribute("current_user");
if (user == null) {
	response.sendRedirect("login_page");
}
%>
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
body {
	background: url("img/background4.png");
	background-size: cover;
	background-attachment: fixed;
}
</style>
<title>TechBlog - Profile</title>
<!-- add icon link -->
<link rel="icon" href="img/title.png" type="image/x-icon">
</head>
<body>

	<!-- navbar starts here -->
	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<a class="navbar-brand" href="profile"><span class="fa fa-qrcode"></span>
			TechBlog</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link" href="profile"><span
						class="fa fa-home"></span> Home <span class="sr-only">(current)</span>
				</a></li>

				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"><span class="fa fa-check-square-o"></span>
						Categories </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Programming Language</a> <a
							class="dropdown-item" href="#">Project Implementation</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Data Structure</a>
					</div></li>
				<li class="nav-item"><a class="nav-link" href="#"><span
						class="fa fa-address-book-o"></span> Contact</a></li>
				<li class="nav-item"><a class="nav-link" href="#!"
					data-toggle="modal" data-target="#add_post_modal"><span
						class="fa fa-asterisk"></span> Add Post</a></li>
			</ul>
			<ul class="navbar-nav mr-right">
				<li class="nav-item active"><a class="nav-link" href="#!"
					data-toggle="modal" data-target="#profile_modal"><span
						class="fa fa-user-circle"></span> <%=user.getName()%></a></li>
				<li class="nav-item"><a class="nav-link" href="logout"><span
						class="fa fa-sign-out"></span> Logout</a></li>
			</ul>
		</div>
	</nav>
	<!-- navbar ends here -->

	<!-- Message -->
	<%
	Message msg = (Message) session.getAttribute("msg");
	if (msg != null) {
	%>
	<div class="alert <%=msg.getCssClass()%>" role="alert">
		<%=msg.getContent()%>
	</div>
	<%
	session.removeAttribute("msg");
	}
	%>

	<!-- main body of page -->
	<main>
		<div class="container">
			<div class="row mt-4">
				<div class="col-md-4">
					<!-- categories -->
					<div class="list-group">
						<%
						PostDao pDao = new PostDao(DBConnectionUtil.getConnection());
						%>
						<a href="#" onclick="getPosts(0, this)"
							class="list-group-item d-flex justify-content-between align-items-center list-group-item-action active c-link">
							All Posts <span class="badge badge-light badge-pill"><%=pDao.getAllPosts().size()%></span>
						</a>
						<%
						List<Category> listCat = pDao.getAllCategories();
						for (Category cat : listCat) {
						%>
						<a href="#" onclick="getPosts(<%=cat.getCid()%>, this)"
							class="list-group-item d-flex justify-content-between align-items-center list-group-item-action c-link"><%=cat.getName()%>
							<span class="badge badge-light badge-pill"><%=pDao.getPostByCatId(cat.getCid()).size()%></span>
						</a>
						<%
						}
						%>
					</div>
				</div>
				<div class="col-md-8">
					<!-- posts -->
					<div class="container text-center" id="post_loader">
						<i class="fa fa-refresh fa-5x fa-spin"></i>
						<h3 class="mt-3">Loading...</h3>
					</div>
					<div class="container-fluid" id="post_container"></div>
				</div>
			</div>
		</div>
	</main>
	<!-- end main body of page -->


	<!-- Start Profile Modal -->
	<!-- Modal -->
	<div class="modal fade" id="profile_modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header primary-background text-white text-center">
					<h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<img alt="" src="pics/<%=user.getProfile()%>" class="img-fluid"
							style="border-radius: 50%; max-width: 150px;">
						<h5 class="modal-title mt-2" id="exampleModalLabel"><%=user.getName().toUpperCase()%></h5>
					</div>

					<!-- details -->
					<div id="profile_details"">
						<table class="table table-hover">
							<tbody>
								<tr>
									<th scope="row">ID :</th>
									<td><%=user.getId()%></td>
								</tr>
								<tr>
									<th scope="row">Email :</th>
									<td><%=user.getEmail()%></td>
								</tr>
								<tr>
									<th scope="row">Gender :</th>
									<td colspan="2"><%=user.getGender().toUpperCase()%></td>
								</tr>
								<tr>
									<th scope="row">Status :</th>
									<td colspan="2"><%=user.getAbout()%></td>
								</tr>
								<tr>
									<th scope="row">Registered On :</th>
									<td colspan="2"><%=user.getRegDate().toString()%></td>
								</tr>
							</tbody>
						</table>
					</div>

					<!-- Profile edit -->
					<div id="profile_edit" style="display: none;">
						<h3 class="mt-2">Edit Profile</h3>
						<form action="edit" method="post" enctype="multipart/form-data">
							<table class="table table-hover">
								<tbody>
									<tr>
										<th scope="row">ID :</th>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<th scope="row">Name :</th>
										<td><input type="text" name="user_name"
											class="form-control" value="<%=user.getName()%>"></td>
									</tr>
									<tr>
										<th scope="row">Email :</th>
										<td><%=user.getEmail().toUpperCase()%></td>
									</tr>
									<tr>
										<th scope="row">Password :</th>
										<td><input type="password" name="user_password"
											class="form-control" value="<%=user.getPassword()%>"></td>
									</tr>
									<tr>
										<th scope="row">Gender :</th>
										<td><%=user.getGender().toUpperCase()%></td>
									</tr>
									<tr>
										<th scope="row">Status :</th>
										<td colspan="2"><textarea rows="" cols=""
												name="user_about" class="form-control"><%=user.getAbout()%></textarea></td>
									</tr>
									<tr>
										<th scope="row">Select Profile</th>
										<td><input type="file" name="image" class="form-control"></td>
									</tr>
								</tbody>
							</table>
							<div class="container text-center">
								<button class="btn btn-outline-primary" type="submit">Save</button>
							</div>
						</form>
					</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button type="button" id="edit_profile_btn" class="btn btn-primary">EDIT</button>
				</div>
			</div>
		</div>
	</div>
	<!-- End Profile Modal -->

	<!-- Start add post modal -->
	<!-- Modal -->
	<div class="modal fade" id="add_post_modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Add Post
						Details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="addPost" method="post" enctype="multipart/form-data"
						id="post_form">
						<div class="form-group">
							<select class="form-control" name="cid">
								<option selected disabled>---Select Category---</option>
								<%
								PostDao postDao = new PostDao(DBConnectionUtil.getConnection());
								List<Category> list = postDao.getAllCategories();
								for (Category c : list) {
								%>
								<option value="<%=c.getCid()%>"><%=c.getName()%></option>
								<%
								}
								%>
							</select>
						</div>
						<div class="form-group">
							<input type="text" placeholder="Enter Post Title" name="pTitle"
								class="form-control">
						</div>
						<div class="form-group">
							<textarea rows="5" cols="" class="form-control" name="pContent"
								placeholder="Enter your Content"></textarea>
						</div>
						<div class="form-group">
							<textarea rows="5" cols="" class="form-control" name="pCode"
								placeholder="Enter your Program Code (if any)"></textarea>
						</div>
						<div class="form-group">
							<label>Select Your Pic</label><br> <input type="file"
								name="pPic" class="form-control">
						</div>
						<div class="container text-center">
							<button type="submit" class="btn btn-outline-primary">Add
								Post</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- end add post modal -->

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
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script type="text/javascript" src="js/myjs.js"></script>

	<script type="text/javascript">
		$(document).ready(function() {

			let editStatus = false;

			$('#edit_profile_btn').click(function() {

				if (editStatus == false) {
					$('#profile_details').hide();
					$('#profile_edit').show();
					editStatus = true;
					$(this).text("BACK");
				} else {
					$('#profile_details').show();
					$('#profile_edit').hide();
					editStatus = false;
					$(this).text("EDIT");
				}

			});
		});
	</script>

	<!-- now add post js -->
	<script type="text/javascript">
		$(document).ready(function(e) {
			$("#post_form").on("submit", function(event) {

				event.preventDefault();

				let postForm = new FormData(this);

				//now requisting to server...
				$.ajax({
					url : "addPost",
					type : 'POST',
					data : postForm,

					success : function(data, textStatus, jqXHR) {
						//console.log("Post added");
						//console.log(data);
						if(data.trim() === "done"){
							swal("Post Added", "Your post has been added successfully", "success")
							.then((value) => {
								  window.location="profile"
								});
						}else{
							swal("Error !!!", "Something went wrong", "error");
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						console.log("Error");
						swal("Error !!!", "Something went wrong", "error");
					},
					processData : false,
					contentType : false
				})

			})
		})
	</script>

	<!-- loading posts using ajax -->
	<script type="text/javascript">
		
		function getPosts(catId, temp) {			
			$('#post_loader').show();
			$('#post_container').hide();
			
			$('.c-link').removeClass('active');			
			
			$.ajax({
				url: "load_posts",
				data: {cid: catId},
				success: function(data, textStatus, jqXHR) {
					//console.log(data);
					$('#post_loader').hide();
					$('#post_container').show();
					$('#post_container').html(data);
					$(temp).addClass('active');
				}
			});		
		}
	
		$(document).ready(function(e) {
			let allPostRef = $('.c-link')[0];			
			getPosts(0, allPostRef);				
		});
	</script>

</body>
</html>