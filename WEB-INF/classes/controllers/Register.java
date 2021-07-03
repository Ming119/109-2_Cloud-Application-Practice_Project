package controllers;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.Trade;
import models.User;

@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Register() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
		response.setLocale(new Locale(new String("zh"), new String("TW")));
		response.setContentType("text/html");
		
		request.getRequestDispatcher("WEB-INF/view/register.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		User user = User.Register(username, password);
		
		if (user != null) {
			HttpSession session = request.getSession(true);
			session.setAttribute("user", user);
			session.setAttribute("trades", Trade.getTrades(user));
			System.out.println("register as: " + user.toStr());
			response.sendRedirect("/finalproject");
		} else {
			System.out.println("register Failed!");
			response.sendRedirect("Register");
		}
		
	}

}
