<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="meeting" class="meeting.Meeting" scope="page"/>
<jsp:setProperty name="meeting" property="meetingId"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>회의 관리 페이지</title>
</head>
<body>

<script type="text/javascript">

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

	function remove_card(meetingId){
		post_to_url('deleteMeetingAction.jsp',{'meetingId':meetingId})
	}

</script>

	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.jsp"> WMA </a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="index.jsp">메인</a></li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="col=lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top : 20px;">
				<form method="post" action="manageMeetingAction.jsp">
					<h3 style="text-align:center;">회의 관리 화면</h3>
					<div class="form-group">
						<input type="hidden" class="form-control" name="meetingId" maxlength="20"value="<%=meeting.getMeetingId()%>">
						<input type="password" class="form-control" placeholder="회의 비밀번호" name="meetingPassword" maxlength="20">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="변경 사항 적용">
				</form>
				<button class="btn btn-primary form-control" onclick="remove_card('<%=meeting.getMeetingId()%>')">삭제</button>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>