package models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class Trade {
	private final static DB db = new DB();
	private final static DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	
	private User   user;
	private String datetime;
	private String stock;
	private double price;
	private int    share;
	private Double fee;
	private Double tax;
	private Double total;
	
	public Trade() {
		user = null;
		datetime = dateFormat.format(new Date());
		stock    = null;
		share    = -1;
		price    = -1;
		fee      = 0.0;
		tax      = 0.0;
		total    = 0.0;
	}
	
	public Trade(User user, Date datetime, String stock, double price, int share, Double fee, Double tax, Double total) {
		this.user     = user;
		this.datetime = dateFormat.format(datetime);
		this.stock    = stock;
		this.price    = price;
		this.share    = share;
		this.fee      = fee;
		this.tax      = tax;
		this.total    = total;
	}
	
	public Trade(User user, String datetime, String stock, double price, int share, Double fee, Double tax, Double total) {
		this.user     = user;
		this.datetime = datetime;
		this.stock    = stock;
		this.price    = price;
		this.share    = share;
		this.fee      = fee;
		this.tax      = tax;
		this.total    = total;
	}
	
	public void SetUser(User user) { this.user = user; }
	public void SetDate(String datetime) { this.datetime = datetime; }
	public void SetDate(Date datetime) { this.datetime = dateFormat.format(datetime); }
	public void SetStock(String stock) { this.stock = stock; }
	public void SetPrice(double price) { this.price = price; }
	public void SetShare(int share) { this.share = share; }
	public void SetFee(Double fee) { this.fee = fee; }
	public void SetTax(Double tax) { this.tax = tax; }
	public void SetTotal(Double total) { this.total = total; }
	
	public User GetUser() { return user; }
	public String GetDateString() { return datetime; }
	public Date GetDate() throws ParseException { return dateFormat.parse(datetime); }
	public String GetStock() { return stock; }
	public double GetPrice() { return price; }
	public int GetShare() { return share; }
	public Double GetFee() { return fee; }
	public Double GetTax() { return tax; }
	public Double GetTotal() { return total; }
	
	public String toStr() { return 
			"\tUser ID: " + GetUser().GetID() +
			"\n\tDate: " + GetDateString() + 
			"\n\tStock: " + GetStock() + 
			"\n\tPrice: " + GetPrice() + 
			"\n\tShare: " + GetShare() + 
			"\n\tFee: " + GetFee() +  
			"\n\tTax: " + GetTax();
	}
	
	public String toString() { return
			"Date: " + GetDateString() + 
			"\tStock: " + GetStock() + 
			"\tPrice: " + GetPrice() + 
			"\tShare: " + GetShare() + 
			"\tFee: " + GetFee() +  
			"\tTax: " + GetTax();
	}
	
	public static Trade trade(User user, Date datetime, String stock, double price, int share, Double fee, Double tax, Double total) {		
		if (db.CreateTrade(user, dateFormat.format(datetime), stock, price, share, fee, tax, total))  {
			user.trade(total);
			return new Trade(user, datetime, stock, price, share, fee, tax, total);
		}
		else return null;
	}
	
	public static ArrayList<Trade> getTrades(User user) {
		ResultSet rs = db.ReadTrades(user.GetID());
		
		
		ArrayList<Trade> tradesArray = new ArrayList<>();
		try {
			while (rs.next()) {
				String datet = rs.getString("datetime");
				String stock = rs.getString("stock");
				double price = rs.getDouble("price");
				int    share = rs.getInt("share");
				double fee   = rs.getDouble("fee");
				double tax   = rs.getDouble("tax");
				double total = rs.getDouble("total");
				
				tradesArray.add(new Trade(user, datet, stock, price, share, fee, tax, total));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return tradesArray;
	}
	
	
}
