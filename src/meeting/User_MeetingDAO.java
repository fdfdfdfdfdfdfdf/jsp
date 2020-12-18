package meeting;

import util.DB_connector;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.List;


public class User_MeetingDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public User_MeetingDAO() {
		DB_connector db_connector = new DB_connector();
		conn = db_connector.getConn();
	}

	public List<String> get_meeting_array(String user_Id) {

		List<String> str_array = new ArrayList<String>();
		String SQL="select meeting_Id from user_meeting where user_Id=?";

		try {
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, user_Id);
			rs=pstmt.executeQuery();

			while(rs.next()) {
				str_array.add(rs.getString(1));
			}

		}catch(Exception e) {
			e.printStackTrace();
		}

		return str_array;
	}
}
