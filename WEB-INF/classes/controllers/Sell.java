package controllers;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.Trade;
import models.User;

@WebServlet("/Sell")
public class Sell extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Sell() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(true);
		if (session.getAttribute("user") == null)
			response.sendRedirect("Login");
		else {
			User   user  = (User)session.getAttribute("user");
			String stock = request.getParameter("stock");
			double price = Double.parseDouble(request.getParameter("price"));
			int    share = -(Integer.parseInt(request.getParameter("share")));
			double fee   = Double.parseDouble(request.getParameter("fee"));
			double tax   = Double.parseDouble(request.getParameter("tax"));
			double total = -Double.parseDouble(request.getParameter("total"));
			
			if (Trade.trade(user, new Date(), stock, price, share, fee, tax, total) != null) {
				session.setAttribute("user", user);
				session.setAttribute("trades", Trade.getTrades(user));
				response.sendRedirect("index.jsp");
			} else {
				response.setStatus(400);
			}
		}
	}

}
