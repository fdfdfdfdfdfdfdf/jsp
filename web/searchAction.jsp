<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="meeting.MeetingDAO" %>
<jsp:useBean id="meeting" class="meeting.Meeting" scope="page"/>
<jsp:setProperty name="meeting" property="meetingId"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	MeetingDAO meetingDAO=new MeetingDAO();
	meeting = meetingDAO.searchMeeting(meeting.getMeetingId());
%>

<script>

	function post_to_url(path, params, method) {
    	method = method || "post";

    	var form = document.createElement("form");
    	form.setAttribute("method", method);
    	form.setAttribute("action", path);

	    for(var key in params) {
	        var hiddenField = document.createElement("input");
	        hiddenField.setAttribute("type", "hidden");
	        hiddenField.setAttribute("name", key);
	        hiddenField.setAttribute("value", params[key]);
	        form.appendChild(hiddenField);
    	}
	    document.body.appendChild(form);
	    form.submit();
	}
	
	window.onload = function(){
       post_to_url("search.jsp",{meetingId:'<%=meeting.getMeetingId()%>', meetingPassword:'<%=meeting.getMeetingPassword()%>', meetingLink:'<%=meeting.getMeetingLink()%>', maxMember:'<%=meeting.getMaxMember()%>', fileLink:'<%=meeting.getFileLink()%>'});
    }
</script>

</body>
</html>