<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<jsp:useBean id="meeting" class="meeting.Meeting" scope="page"/>
<jsp:setProperty name="meeting" property="meetingId"/>
<jsp:setProperty name="meeting" property="meetingPassword"/>
<jsp:setProperty name="meeting" property="meetingLink"/>
<jsp:setProperty name="meeting" property="maxMember"/>
<jsp:setProperty name="meeting" property="fileLink"/>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  

  <title>Meeting search page</title>

  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="css/heroic-features.css" rel="stylesheet">

</head>

<body>

	<form action="searchAction.jsp" method="post">
    	<input type="text" name="meetingId" placeholder="회의의 이름을 입력해주세요.">
    	<button type="submit" formmethod="POST">검색</button>
	</form>
<%
    String id = (String)session.getAttribute("userId");
    PrintWriter script = response.getWriter();

    System.out.println(id);

    if(id==null) {
        response.sendRedirect("login.jsp");
    }

    script.println("<script>");
    if(meeting.getMeetingId() != null && !(meeting.getMeetingId().equals("null"))){
		script.println("window.meetingFlag=true");
		script.println("window.meetingId='"+meeting.getMeetingId()+"'");
	}else{
		script.println("window.meetingFlag=false");
	}
    script.println("</script>");
%>




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

    function add_card(meeting_id){
        var div=document.createElement('div');
        div.innerHTML=document.getElementById('meeting').innerHTML;
        div.id = meeting_id
        div.getElementsByClassName('meeting_name')[0].innerHTML = meeting_id
        document.getElementById('field').appendChild(div);
    }

    function join_card(meetingId){
        post_to_url('joinMeetingAction.jsp',{'meetingId':meetingId})
    }

    window.onload = function(){
        if(window.meetingFlag==true){
	    	add_card(window.meetingId)
        }
    }

</script>


  <!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="#"> <%=id%> 님 환영합니다 </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link" href="generateMeeting.jsp">회의 생성</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="logoutAction.jsp">로그아웃</a>
            </li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- Page Content -->
  <div class="container" style="height:800px">
    
    <div id="field" class="row">

      <div id="meeting" class="col-lg-3 col-md-6 mb-4"  style="display:none">
        <div class="card h-100" style="float:left; margin:15px;">
        	<div class="card" style="width: 280px;">
				<div class="card-header">
 					<div class="meeting_name" style="display:inline;">
 						회의 입니당
 					</div>
 					<div style="text-align:right;display:inline;">
                        <a href="#" class="btn btn-primary" onclick="join_card(this.parentNode.parentNode.parentNode.parentNode.parentNode.id)">Join</a>
 					</div>	
  				</div>
 				<ul class="list-group list-group-flush">
					<li class="list-group-item">Cras justo odio</li>
					<li class="list-group-item">Dapibus ac facilisis in</li>
					<li class="list-group-item">Vestibulum at eros</li>
				</ul>
			</div>
        </div>
      </div>
    <!-- /.row -->
  </div>
  <!-- /.container -->

  <!-- Footer -->
  <footer class="py-5 bg-dark">
    <div class="container">
      <p class="m-0 text-center text-white">Copyright &copy; Your Website 2020</p>
    </div>
    <!-- /.container -->
  </footer>
</div>
  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>
