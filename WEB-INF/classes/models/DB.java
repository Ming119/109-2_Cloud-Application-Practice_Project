package models;

import java.sql.*;

public class DB {
	
	private final String jdbcName = System.getenv("dbDriver");
	private final String database = System.getenv("dbConnectionUrl");
	private final String username = System.getenv("dbUsername");
	private final String password = System.getenv("dbPassword");
	
	private Connection connection;

	public DB() {
		connection = null;
	}

	public void connect() {
		try {
			Class.forName(jdbcName);
			connection = DriverManager.getConnection(database, username, password);
			if (connection != null)
				System.out.println("Connect successfully!");
			else
				System.out.println("Connect failed!");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

// User CRUD
	// Create User
	public void CreateUser(String uname, String pw) {
		connect();

		try {
			String sql = "INSERT INTO users (username, password) VALUES (?, ?)";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, uname);
			statement.setString(2, pw);

			int result = statement.executeUpdate();
			if (result > 0)
				System.out.println("Insert User Success!");
			else 
				System.out.println("Insert User Failed!");

		} catch (SQLException e) {
			System.err.println("SQLException: " + e.getMessage());
			System.err.println("SQLState: " + e.getSQLState());
			System.err.println("VendorError: " + e.getErrorCode());
		}
	}
	
	// Read User
	public ResultSet ReadUsers() {
		connect();
		ResultSet resultSet = null;
		try {
			String sql = "SELECT * FROM users";
			PreparedStatement statement = connection.prepareStatement(sql);
			resultSet = statement.executeQuery(sql);

		} catch (SQLException e) {
			System.err.println("SQLException: " + e.getMessage());
			System.err.println("SQLState: " + e.getSQLState());
			System.err.println("VendorError: " + e.getErrorCode());
		}

		return resultSet;
	}

	public ResultSet ReadUsername(String username) {
		connect();

		ResultSet resultSet = null;
		try {
			String sql = "SELECT * FROM users WHERE username=?";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, username);
			resultSet = statement.executeQuery();

		} catch (SQLException e) {
			System.err.println("SQLException: " + e.getMessage());
			System.err.println("SQLState: " + e.getSQLState());
			System.err.println("VendorError: " + e.getErrorCode());
		}

		return resultSet;
	}
	
	// Update User
	public boolean UpdateUser(int id, double points) {
		connect();
		points = Math.round(points*100)/100;
		try {
			String sql = "UPDATE users SET points=? WHERE id=?";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setDouble(1, points);
			statement.setInt(2, id);

			int result = statement.executeUpdate();
			if (result > 0) {
				System.out.println("Update User Success!");
				return true;
			}
			
			System.out.println("Update User Failed!");

		} catch (SQLException e) {
			System.err.println("SQLException: " + e.getMessage());
			System.err.println("SQLState: " + e.getSQLState());
			System.err.println("VendorError: " + e.getErrorCode());
		}
		
		return false;
	}

	// Delete User
	public void DeleteUser(int id) {
		connect();

		try {
			String sql = "DELETE FROM users WHERE id=?";
			PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			statement.setInt(1, id);

			int result = statement.executeUpdate();
			if (result > 0)
				System.out.println("Delete User Success");
			else
				System.out.println("Delete User Failed!");
			
		} catch (SQLException e) {
			System.err.println("SQLException: " + e.getMessage());
			System.err.println("SQLState: " + e.getSQLState());
			System.err.println("VendorError: " + e.getErrorCode());
		}
	}
// End of User CRUD
		
// Trade CRUD
	// Create Trade
	public boolean CreateTrade(User user, String datetime, String stock, double price, int share, double fee, double tax, double total) {
		connect();
		
		try {
			String sql = "INSERT INTO trades (uid, datetime, stock, price, share, fee, tax, total) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement statement = connection.prepareStatement(sql);
			
			statement.setInt(1, user.GetID());
			statement.setString(2, datetime);
			statement.setString(3, stock);
			statement.setDouble(4, price);
			statement.setInt(5, share);
			statement.setDouble(6, fee);
			statement.setDouble(7, tax);
			statement.setDouble(8, total);
			
			int result = statement.executeUpdate();
			if (result > 0) {
				System.out.println("Insert Trade Success!");
				return true; 
			}
			
			System.out.println("Insert Trade Failed!");
			
		} catch(SQLException e) {
			System.err.println("SQLException: " + e.getMessage());
			System.err.println("SQLState: " + e.getSQLState());
			System.err.println("VendorError: " + e.getErrorCode());
		}
		
		return false;
	}
	
	// Read Trade
	public ResultSet ReadTrades() {
		connect();
		ResultSet resultSet = null;
		
		try {
			String sql = "SELECT * FROM trades";
			PreparedStatement statement = connection.prepareStatement(sql);
	
			resultSet = statement.executeQuery();
			
		} catch(SQLException e) {
			System.err.println("SQLException: " + e.getMessage());
			System.err.println("SQLState: " + e.getSQLState());
			System.err.println("VendorError: " + e.getErrorCode());
		}
		
		return resultSet;
	}
	
	public ResultSet ReadTrades(int id) {
		connect();
		ResultSet resultSet = null;
		
		try {
			String sql = "SELECT * FROM trades WHERE uid=? ORDER BY id DESC";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1, id);
			
			resultSet = statement.executeQuery();
			
		} catch(SQLException e) {
			System.err.println("SQLException: " + e.getMessage());
			System.err.println("SQLState: " + e.getSQLState());
			System.err.println("VendorError: " + e.getErrorCode());
		}
		
		return resultSet;
	}
	
	
	// Update
	public void UpdateTrade() {
		/* 
		 * Method not Implemented!
		 * Trade records must not be changed.
		 */
	}
	
	// Delete
	public void DeleteTrade() {
		/* 
		 * Method not Implemented!
		 * Trade records must not be changed.
		 */
	}
// End of Trade CRUD
	
	
	
	public static void main(String[] argv) {
		DB db = new DB();
		db.connect();
	}
}
