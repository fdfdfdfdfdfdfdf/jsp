package user;

import util.DB_connector;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		DB_connector db_connector = new DB_connector();
		conn = db_connector.getConn();
	}
	
	public int login(String userId, String userPassword) {
		String SQL="select userPassword from user where userId=?";
		try {
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,userId );
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; //로그인 성공
				}else
					return 0; //비밀번호가 틀림
			}
			return -1; //아이디가 없음
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2; //데이터베이스 오류
	}

	public int join(User user) {
		String SQL="INSERT INTO user VALUES (?, ?, ?)";
		try{
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserId());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // database 오류
	}
}
