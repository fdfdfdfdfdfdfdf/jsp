package meeting;

import util.DB_connector;
import util.commandLineExecutor;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MeetingDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public MeetingDAO() {
		DB_connector db_connector = new DB_connector();
		conn = db_connector.getConn();
	}

	public int createMeeting(Meeting meeting, String userId) {
		String insertMeetingSQL = "INSERT INTO meeting VALUES (?, ?, ?, ?, ?)";
		String insertUserMeetingSQL = "INSERT INTO user_meeting VALUES (?, ?)";

		String selectPortSQL="SELECT meeting_link from meeting";

		try{
			int[] numArray= new int[101];
			int portMeeting=0, portFile=0;
			pstmt=conn.prepareStatement(selectPortSQL);
			rs=pstmt.executeQuery();

			while(rs.next()) {
				numArray[(rs.getInt(1)-10000)]=1;
			}
			for( int i=0;i<100;i++) {
				if(numArray[i+1]==0) {
					portMeeting=i+10001;
					portFile=i+10101;
					break;
				}
			}

			commandLineExecutor.execute("docker run -dit --name "+Integer.toString(portFile)+" -e \"PASSWORD="+meeting.getMeetingPassword()+"\" -e \"SUDO=Y\" -p "+Integer.toString(portFile)+":6080 chenjr0719/ubuntu-unity-novnc");
			Thread.sleep(5000);
			commandLineExecutor.execute("docker run -dit --name "+Integer.toString(portMeeting)+" -p "+Integer.toString(portMeeting)+":3000 node-test-ssl");


			pstmt=conn.prepareStatement(insertMeetingSQL);
			pstmt.setString(1, meeting.getMeetingId());
			pstmt.setString(2, meeting.getMeetingPassword());
			pstmt.setString(3, String.valueOf(portMeeting));
			pstmt.setString(4, "0");
			pstmt.setString(5, String.valueOf(portFile));
			pstmt.executeUpdate();

			pstmt=conn.prepareStatement(insertUserMeetingSQL);
			pstmt.setString(1, userId);
			pstmt.setString(2, meeting.getMeetingId());

			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // database 오류
	}
	
//	public int createMeeting(Meeting meeting, String userId) {
//		String insertMeetingSQL = "INSERT INTO meeting VALUES (?, ?, ?, ?, ?)";
//		String insertUserMeetingSQL = "INSERT INTO user_meeting VALUES (?, ?)";
//
//		try{
//
////			commandLineExecutor.execute("docker run -dit --name 4000 -p 4000:3000 node-test");
////			commandLineExecutor.execute("docker run -dit --name 5000 -e \"PASSWORD="+meeting.getMeetingPassword()+"\" -e \"SUDO=yes\" -p 5000:6080 chenjr0719/ubuntu-unity-novnc");
//
//			pstmt=conn.prepareStatement(insertMeetingSQL);
//			pstmt.setString(1, meeting.getMeetingId());
//			pstmt.setString(2, meeting.getMeetingPassword());
//			pstmt.setString(3, "4000");
//			pstmt.setString(4, "0");
//			pstmt.setString(5, "5000");
//			pstmt.executeUpdate();
//
//			pstmt=conn.prepareStatement(insertUserMeetingSQL);
//			pstmt.setString(1, userId);
//			pstmt.setString(2, meeting.getMeetingId());
//
//			return pstmt.executeUpdate();
//		}catch(Exception e) {
//			e.printStackTrace();
//		}
//		return -1; // database 오류
//	}

	public int deleteMeeting(Meeting meeting, String userId) {
		String userMeetingDeleteSQL = "DELETE FROM user_meeting WHERE meeting_id=? AND user_Id=?";
		String searchexistanceSQL = "Select count(*) From user_meeting Where meeting_id=?";

		String getMeetingLinkSQL = "SELECT meeting_link, file_link FROM meeting WHERE meetingId=?";
		String meetingDeleteSQL = "DELETE FROM meeting WHERE meetingId=?";


		try{
			pstmt=conn.prepareStatement(userMeetingDeleteSQL);
			pstmt.setString(1, meeting.getMeetingId());
			pstmt.setString(2,userId);
			pstmt.executeUpdate();

			pstmt=conn.prepareStatement(searchexistanceSQL);
			pstmt.setString(1, meeting.getMeetingId());
			rs = pstmt.executeQuery();
			rs.next();

			if(rs.getInt(1)==0) {
				pstmt=conn.prepareStatement(getMeetingLinkSQL);
				pstmt.setString(1, meeting.getMeetingId());
				rs = pstmt.executeQuery();

				rs.next();
				String meeting_link = rs.getString(1);
				String file_link = rs.getString(2);

				commandLineExecutor.execute("docker rm -f "+ meeting_link);
				commandLineExecutor.execute("docker rm -f "+ file_link);

				pstmt=conn.prepareStatement(meetingDeleteSQL);
				pstmt.setString(1, meeting.getMeetingId());
				pstmt.executeUpdate();
			}

			return 0;

		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // database 오류
	}


//	public int deleteMeeting(Meeting meeting) {
//		String getMeetingLinkSQL = "SELECT meeting_link, file_link FROM meeting WHERE meetingId=?";
//		String meetingDeleteSQL = "DELETE FROM meeting WHERE meetingId=?";
//		String userMeetingDeleteSQL = "DELETE FROM user_meeting WHERE meeting_id=?";
//		try{
//			pstmt=conn.prepareStatement(getMeetingLinkSQL);
//			pstmt.setString(1, meeting.getMeetingId());
//			rs = pstmt.executeQuery();
//
//			rs.next();
//			String meeting_link = rs.getString(1);
//			String file_link = rs.getString(2);
//
//			commandLineExecutor.execute("docker rm -f "+ meeting_link);
//			commandLineExecutor.execute("docker rm -f "+ file_link);
//
//			pstmt=conn.prepareStatement(meetingDeleteSQL);
//			pstmt.setString(1, meeting.getMeetingId());
//			pstmt.executeUpdate();
//
//			pstmt=conn.prepareStatement(userMeetingDeleteSQL);
//			pstmt.setString(1, meeting.getMeetingId());
//			return pstmt.executeUpdate();
//		}catch(Exception e) {
//			e.printStackTrace();
//		}
//		return -1; // database 오류
//	}

	public int manageMeeting(Meeting meeting) {
		String meetingUpdateSQL = "UPDATE meeting SET meetingPw=? WHERE meetingId=?";
		try{
			pstmt=conn.prepareStatement(meetingUpdateSQL);
			pstmt.setString(1, meeting.getMeetingPassword());
			pstmt.setString(2, meeting.getMeetingId());
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // database 오류
	}

	public Meeting getMeetingLink(Meeting meeting) {
		String getMeetingLinkSQL = "select meeting_link, file_link from meeting where meetingId=?";
		try{
			pstmt=conn.prepareStatement(getMeetingLinkSQL);
			pstmt.setString(1, meeting.getMeetingId());
			rs=pstmt.executeQuery();

			rs.next();
			meeting.setMeetingLink("https://222.111.20.3:"+rs.getString(1));
			meeting.setFileLink("http://222.111.20.3:"+rs.getString(2));

		}catch(Exception e) {
			e.printStackTrace();
		}
		return meeting; // null 값이면 database 오류
	}

	public Meeting searchMeeting(String meetingId) {
		String searchMeetingSQL="select * from meeting where meetingId=?";
		Meeting meeting=new Meeting();
		try {

			pstmt=conn.prepareStatement(searchMeetingSQL);
			pstmt.setString(1, meetingId);
			rs=pstmt.executeQuery();

			rs.next();
			meeting.setMeetingId(rs.getString(1));
			meeting.setMeetingPassword(rs.getString(2));
			meeting.setMeetingLink(rs.getString(3));
			meeting.setMaxMember(rs.getString(4));
			meeting.setFileLink(rs.getString(5));
		}catch(Exception e) {
			e.printStackTrace();
		}
		return meeting;
	}

	public int joinMeeting(Meeting meeting, String userId) {
		String joinMeetingSQL="INSERT INTO user_meeting VALUES (?, ?)";

		try {
			pstmt=conn.prepareStatement(joinMeetingSQL);
			pstmt.setString(1, userId);
			pstmt.setString(2, meeting.getMeetingId());
			pstmt.executeUpdate();

			return 0;
		}catch(Exception e){
			e.printStackTrace();
		}

		return -1;
	}
}
