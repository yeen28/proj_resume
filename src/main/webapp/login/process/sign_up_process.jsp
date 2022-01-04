<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@page import="kr.co.sist.user.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="회원가입 처리"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/common/jsp/common_code.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><%= title %></title>
<link rel="stylesheet" href="http://localhost/sist_resume/common/css/sign_up.css"/>

<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>
<%
  request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="mVO" class="kr.co.sist.user.MemberVO" scope="page"/>
<jsp:setProperty property="*" name="mVO"/>

<c:catch var="e">
<%
mVO.setPassword(DataEncrypt.messageDigest( "SHA-1", mVO.getPassword() ));
MemberDAO mDAO=new MemberDAO();
mDAO.insertMember(mVO);
%>
<div id="wrap">
<!-- header -->
<jsp:include page="/headerfooter/header.jsp"></jsp:include>

<div id="success_container">
<div id="container_top">
<img alt="success" src="http://localhost/sist_resume/common/images/registration.PNG"><br/>
<span>회원가입이 <strong>완료</strong>되었습니다.</span><br/>
<span>${ param.name }님 환영합니다.</span>
</div>
<hr/>
<div id="container_bottom">
<a href="http://localhost/sist_resume/index.jsp" id="home">홈으로</a>
<a href="http://localhost/sist_resume/login/login_page.jsp" id="login">로그인</a>
</div>
</div>

<!-- footer -->
<jsp:include page="/headerfooter/footer.jsp"></jsp:include>
</div>
</c:catch>

<c:if test="${ not empty e }">
<c:redirect url="http://localhost/sist_resume/common/error/error.jsp"/>
</c:if>

</body>
</html>