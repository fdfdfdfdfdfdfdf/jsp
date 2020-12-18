<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="meeting.MeetingDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="meeting" class="meeting.Meeting" scope="page"/>
<jsp:setProperty name="meeting" property="meetingId"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회의 생성 페이지</title>
</head>
<body>
	<%
		String userId = (String)session.getAttribute("userId");
		MeetingDAO meetingDAO = new MeetingDAO();

		int result = meetingDAO.deleteMeeting(meeting, userId);

		if( result == -1){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('Database 오류 관리자에게 문의하세요')");
			script.println("history.back()");
			script.println("</script>");
		}
		else {
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('회의 삭제 성공')");
			script.println("location.href='index.jsp'");
			script.println("</script>");
		}

	%>
</body>
</html>