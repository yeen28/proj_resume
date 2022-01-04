<%@page import="kr.co.sist.user.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="아이디 찾기 성공"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/common/jsp/common_code.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= title %></title>
<link rel="stylesheet" href="<%= protocol %><%= domain %><%= contextRoot %><%= common_css %>/find.css"/>

 <!--jQuery CDN-->
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
MemberDAO mDAO=new MemberDAO();
String id=mDAO.selectFindId(mVO.getName(), mVO.getEmail());
String name=request.getParameter("name");

pageContext.setAttribute("id", id);
pageContext.setAttribute("name", name);
%>


<div id="find_wrap">
<!-- header -->
<jsp:include page="/headerfooter/header.jsp"></jsp:include>

<div class="find_container">

<div class="find_img">
<img alt="find" src="<%= protocol %><%= domain %><%= contextRoot %><%= common_images %>/find.png">
</div>

<div class="container-mid result-mid">
<span><strong><c:out value="${ name }"/></strong>님의 아이디입니다.<br/>
아이디 : <strong><c:out value="${ id }"/></strong></span>
</div>

<div id="result-bottom">
<a class="btn" href="<%= protocol %><%= domain %><%= contextRoot %><%= login %>/login_page.jsp">로그인</a>
</div>
</div>

<!-- footer -->
<jsp:include page="/headerfooter/footer.jsp"></jsp:include>
</div>
</c:catch>

<c:if test="${ not empty e }">

<div id="find_wrap">
<!-- header -->
<jsp:include page="/headerfooter/header.jsp"></jsp:include>

<div class="find_container">
<div class="find_img">
<img alt="find" src="<%= protocol %><%= domain %><%= contextRoot %><%= common_images %>/find.png">
</div>

<div class="container-mid result-mid">
<span>이름과 이메일을 확인해주세요.</span>
</div>

<div id="result-bottom">
<a class="btn" href="<%= protocol %><%= domain %><%= contextRoot %><%= login %>/find.jsp">확인</a>
</div>
</div>

<!-- footer -->
<jsp:include page="/headerfooter/footer.jsp"></jsp:include>
</div>

</c:if>

</body>
</html>