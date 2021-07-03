<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import='models.*, java.util.*'%>

<!DOCTYPE html>

<html>
<%@ include file="../include/head.html"%>

<body class="bg-dark">
	<%@ include file="../include/navbar.jsp"%>
	<div class="container">
		<div class='row'>		
			<ul class="list-group list-group-flush bg-dark">
				<%					
					if (trades != null && trades.size() != 0) {
						for (Trade t : trades) {
							out.println("<li class='list-group-item bg-dark text-white'>" + t.toString() + "</li>");
						}
					}
				%>
			</ul>
		</div>
	</div>

</body>
</html>