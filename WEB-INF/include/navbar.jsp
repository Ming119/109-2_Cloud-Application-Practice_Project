<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import='models.*, controllers.*, javax.servlet.http.*, java.util.*'%>

<!DOCTYPE html>
<nav class='navbar navbar-dark bg-dark navbar-expand-lg sticky-top'>
	<div class='container'>
		<a class='navbar-brand' href='/finalproject'>CAP Final Project</a>

		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarResponsive" aria-controls="navbarResponsive"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class='navbar-nav ms-auto'>
				<%
				User user = (User) session.getAttribute("user");
				ArrayList<Trade> trades = (ArrayList<Trade>) session.getAttribute("trades");
						
					if (user == null) {
						out.println("<li class='nav-item'><a class='nav-link' href=Register>Register</a></li>"
								+ "<li class='nav-item'><a class='nav-link' href=Login>Login</a></li>");
					} else {
						out.println("<li class='nav-item'><a class='nav-link' href=Profile aria-disabled='true'>"
								+ user.GetUsername() + "</a></li>");
						out.println("<li class='nav-item'><a class='nav-link' href=Profile aria-disabled='true' id='points'>"
								+ user.GetPoints() + "</a></li>");
						out.println("<li class='nav-item'><a class='nav-link' href=Login>Logout</a></li>");
					}
				%>
			</ul>
		</div>
	</div>
</nav>
<hr />