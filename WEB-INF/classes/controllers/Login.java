package controllers;

import java.util.*;
import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.Trade;
import models.User;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
    public Login() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
		response.setLocale(new Locale(new String("zh"), new String("TW")));
		response.setContentType("text/html");
		
		HttpSession session = request.getSession(true);
		if (session.getAttribute("user") == null)
			request.getRequestDispatcher("WEB-INF/view/login.jsp").forward(request, response);
		else {
			session.setAttribute("user", null);
			response.sendRedirect("/finalproject");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
				
		User user = User.Login(username, password);
		if (user != null) {
			HttpSession session = request.getSession(true);
			session.setAttribute("user", user);
			session.setAttribute("trades", Trade.getTrades(user));
			System.out.println("Login as: "+ user.toStr());
			response.sendRedirect("/finalproject");
		} else {
			System.out.println("Login Failed!");
			response.sendRedirect("Login");
		}
	}

}
