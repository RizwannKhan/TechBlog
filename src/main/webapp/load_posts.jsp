<%@page import="com.techblog.entities.User"%>
<%@page import="com.techblog.dao.LikeDao"%>
<%@page import="com.techblog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.techblog.helper.DBConnectionUtil"%>
<%@page import="com.techblog.dao.PostDao"%>

<div class="row">
	<%
	User user = (User) session.getAttribute("current_user");

	Thread.sleep(1000);

	PostDao dao = new PostDao(DBConnectionUtil.getConnection());
	List<Post> posts = null;
	int cid = Integer.parseInt(request.getParameter("cid"));
	if (cid == 0) {
		posts = dao.getAllPosts();
	} else {
		posts = dao.getPostByCatId(cid);
	}

	if (posts.size() == 0) {
		out.println("<h3 class='display-4 text-center'>No Posts available in this category...!!!</h3>");
		return;
	}

	for (Post p : posts) {
	%>
	<div class="col-md-6 mt-2">
		<div class="card">
			<img class="card-img-top img-fluid" src="post_pics/<%=p.getpPic()%>"
				alt="Card image cap">
			<div class="card-body">
				<b><%=p.getpTitle()%></b>
				<p><%=p.getpContent()%></p>
			</div>
			<div class="card-footer primary-background">
				<%
				LikeDao ld = new LikeDao(DBConnectionUtil.getConnection());
				%>
				<a href="#" 
					class="btn btn-outline-light btn-sm"><i
					class="fa fa-thumbs-o-up"></i> <span class="like-counter"><%=ld.countLikeOnPost(p.getpId())%></span></a>
				<a href="show_single_post?post_id=<%=p.getpId()%>"
					class="btn btn-outline-light btn-sm">Read more...</a> <a href="#"
					class="btn btn-outline-light btn-sm"><i
					class="fa fa-commenting-o"></i> <span>20</span></a>
			</div>
		</div>
	</div>
	<%
	}
	%>
</div>