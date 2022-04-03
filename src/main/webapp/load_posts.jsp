<%@page import="com.techblog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.techblog.helper.DBConnectionUtil"%>
<%@page import="com.techblog.dao.PostDao"%>

<div class="row">
	<%
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
		<div class="card" style="width: 20rem;">
			<img class="card-img-top img-fluid" src="post_pics/<%=p.getpPic()%>"
				alt="Card image cap">
			<div class="card-body">
				<b><%=p.getpTitle()%></b>
				<p><%=p.getpContent()%></p>
			</div>
		</div>
	</div>
	<%
	}
	%>
</div>