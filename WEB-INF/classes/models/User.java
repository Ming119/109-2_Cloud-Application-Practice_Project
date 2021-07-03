package models;

import java.sql.ResultSet;
import java.sql.SQLException;

public class User {
	private final static DB db = new DB();
	
	private int id;
	private String username;
	private double points;
	
	public User() {
		id = -1;
		username = "";
		points = 0;
	}
	
	public User(int id, String username, double points) {
		this.id = id;
		this.username = username;
		this.points   = points;
	}
	
	public void SetID(int id) { this.id = id; }
	public void SetUsername(String username) { this.username = username; }
	public void SetPoints(double point) { this.points = point; }
	
	public int GetID() { return id; }
	public String GetUsername() { return username; }
	public double GetPoints() { return points; }
	
	public String toStr() { return 
			"\n\tID: " + GetID() + 
			"\n\tusername: " + GetUsername() + 
			"\n\tpoints: " + GetPoints();
	}
	
	
	
	public static User Login(String username, String password) {
		User user = null;
		int id = -1;
		String pw = null;
		double points = 0;
		
		ResultSet resultSet = db.ReadUsername(username);
		try {
			if (resultSet.next()) {
				id = resultSet.getInt("id");
				pw = resultSet.getString("password");
				points = resultSet.getDouble("points");
			}
			
			if (id != -1 && pw.compareTo(password) == 0)
				user = new User(id, username, points);
			
		} catch(SQLException e) {
			System.err.println("SQLException: " + e.getMessage());
			System.err.println("SQLState: " + e.getSQLState());
			System.err.println("VendorError: " + e.getErrorCode());
		}
		
		return user;
	}
	
	public static User Register(String username, String password) {
		User user = null;
		int id = -1;
		
		ResultSet resultSet = db.ReadUsername(username);
		
		try {
			if (resultSet.next()) 
				id = resultSet.getInt("id");
			
			if (id == -1) {
				db.CreateUser(username, password);
				resultSet = db.ReadUsername(username);
				
				if (resultSet.next())
					user = new User(resultSet.getInt("id"), username, resultSet.getDouble("points"));
			}
			
		} catch(SQLException e) {
			System.err.println("SQLException: " + e.getMessage());
			System.err.println("SQLState: " + e.getSQLState());
			System.err.println("VendorError: " + e.getErrorCode());
		}
		
		return user;
	}
	
	public boolean trade(double total) {
		this.points -= total;
		return db.UpdateUser(GetID(), GetPoints());
	}
}
