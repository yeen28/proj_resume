<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    info="로그인페이지"%>
<%@ include file="/common/jsp/common_code.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><%= title %></title>

 <!--jQuery CDN-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

 <link href="http://localhost/sist_resume/common/css/signin.css" rel="stylesheet">
 
</head>

<body>
<div id="wrap">
<!-- header -->
<jsp:include page="/headerfooter/header.jsp"/>

<div id="container">
	<form class="form-signin" action="http://localhost/sist_resume/login/process/login_process.jsp" method="post">
        <h2 id="signin-heading"><img src="http://localhost/sist_resume/common/images/icons/login_icon.PNG" width="50px"/>&nbsp;<strong>로그인</strong></h2>
        <label>아이디</label>
        <input type="text" id="inputId" name="id" class="form-control" placeholder="아이디" required autofocus>
		<label style="margin-top: 10px">비밀번호</label>
		<input type="password" id="inputPassword" name="password" class="form-control" placeholder="비밀번호" required>
		<button class="btn btn-lg btn-block" type="submit">로그인하기</button>
	</form>
	
	<div id="signin-bottom">
	<a href="http://localhost/sist_resume/login/sign_up.jsp">회원가입</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="http://localhost/sist_resume/login/find.jsp">아이디/비밀번호 찾기</a>
	</div>
</div>

<!-- footer -->
<jsp:include page="/headerfooter/footer.jsp"/>
</div>

</body>
</html>