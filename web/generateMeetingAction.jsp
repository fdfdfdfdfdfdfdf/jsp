<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="meeting.MeetingDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="meeting" class="meeting.Meeting" scope="page"/>
<jsp:setProperty name="meeting" property="meetingId"/>
<jsp:setProperty name="meeting" property="meetingPassword"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회의 생성 페이지</title>
</head>
<body>
	<%
		if(meeting.getMeetingId()==null || meeting.getMeetingPassword()==null){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 항목이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			String userId = (String)session.getAttribute("userId");
			MeetingDAO meetingDAO = new MeetingDAO();
			int result = meetingDAO.createMeeting(meeting,userId);

			if( result == -1){
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 회의 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("alert('회의 생성 완료')");
				script.println("location.href='index.jsp'");
				script.println("</script>");
			}
		}
		
	%>
</body>
</html>