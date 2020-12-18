<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userId"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
</head>
<body>
	<%
		if(user.getUserId()==null || user.getUserPassword()==null||user.getUserName()==null){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 항목이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			UserDAO userDAO=new UserDAO();
			int result=userDAO.join(user);
			if( result == -1){
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("alert('없음')");
				script.println("location.href='index.jsp'");
				script.println("</script>");
			}
		}
		
	%>
</body>
</html>