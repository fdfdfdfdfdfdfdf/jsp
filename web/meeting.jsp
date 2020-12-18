<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="meeting.MeetingDAO" %>
<jsp:useBean id="meeting" class="meeting.Meeting" scope="page"/>
<jsp:setProperty name="meeting" property="meetingId"/>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Streaming main page</title>

  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="css/heroic-features.css" rel="stylesheet">

</head>

<body>

<%
    String id = (String)session.getAttribute("userId");
    PrintWriter script = response.getWriter();

    MeetingDAO meetingDAO=new MeetingDAO();
    meeting = meetingDAO.getMeetingLink(meeting);

    String meetingLink = meeting.getMeetingLink();
    String fileLink = meeting.getFileLink();
%>




<script type="text/javascript">

    function openWin(url,title){
        field = document.getElementById('field')
        loaded = document.getElementById('loaded')

        field.style.visibility="hidden";
        loaded.style.visibility="visible";

        setTimeout(function(){
            field.style.visibility="visible";
            loaded.style.visibility="hidden";
            window.open(url, title, "width=1600, height=900, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );
        }, 3000);
    }

    window.onload = function(){
        field = document.getElementById('field')
        loaded = document.getElementById('loaded')

        field.style.visibility="hidden";
        loaded.style.visibility="visible";

        setTimeout(function(){
            field.style.visibility="visible";
            loaded.style.visibility="hidden";
            window.open('<%=meetingLink%>', "Video chat", "width=1600, height=900, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );
            window.open('<%=fileLink%>', "Workspace", "width=1600, height=900, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );
        }, 3000);
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
                    <a class="nav-link" href="index.jsp">나가기</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- contents -->
<div class="container" style="height:800px">
    <div id="field" class="row">
        <input class="col-sm-6" type=button value="Video Chat" onclick="javascript:openWin('<%=meetingLink%>','Video Chat');">
        <input class="col-sm-6" type=button value="Workspace" onclick="javascript:openWin('<%=fileLink%>','Workspace');">
    </div>
    <div id='loaded' style="text-align: center; visibility:hidden;">
        <img SRC="img/loading.gif">
    </div>
</div>

<!-- Bootstrap core JavaScript -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>
