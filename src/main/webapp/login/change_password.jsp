<%@page import="kr.co.sist.user.MemberVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="비밀번호 변경 페이지"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/common/jsp/common_code.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= title %></title>

<style type="text/css">
#chang_container{width: 350px; height: 500px; margin: 80px auto;}
#chang_container > h1{text-align: center;margin-bottom: 50px;}
#container-mid{font-size: 18px;}
#container-mid > input{width: 350px; height: 40px; font-size: 18px;}
#container-btn{text-align: center;}
#btn{width: 100px; height: 40px; font-size: 18px; font-weight: bold;background-color: #3498DB; border: 0px; color: #fff;}
</style>

 <!--jQuery CDN-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function() {
	$("#btn").click(function() {
	let frm=document.change_frm;
	
	if( $("#before_pass").val() == "" ){
		alert("이전 비밀번호를 입력해주세요.");
		frm.before_pass.focus();
		return;
	}//end if
	
	if( $("#new_pass").val().search(/[0-9]/g) < 0 || $("#new_pass").val().search(/[a-z]/g) < 0 || $("#new_pass").val().length < 6 ) {
		alert("비밀번호는 소문자와 숫자 포함 6자 이상으로 작성해주세요.");
		frm.new_pass.focus();
		return;
	}
	
	if( $("#new_pass2").val() == "" ){
		alert("새로운 비밀번호 확인을 입력해주세요.");
		frm.new_pass2.focus();
		return;
	}//end if
	
	$("#frm").submit();
	});
});
</script>
</head>

<body>
<c:if test="${ empty sessionScope.id }">
<c:redirect url="login_page.jsp"/>
</c:if>
<div id="chang_password_wrap">
<!-- header -->
<jsp:include page="/headerfooter/header.jsp"/>

<div id="chang_container">
<h1>비밀번호 변경</h1>

<form id="frm" name="change_frm" action="<%= protocol %><%= domain %><%= contextRoot %><%= login %>/process/change_pw_process.jsp" method="post">
<div id="container-mid">
<label>이전 비밀번호</label><br/>
<input type="password" id="before_pass" name="before_pass" class="form-control" required autofocus/><br/>
<label>새로운 비밀번호</label><br/>
<input type="password" id="new_pass" name="new_pass" class="form-control" required/><br/>
<label>새로운 비밀번호 확인</label><br/>
<input type="password" id="new_pass2" name="new_pass2" class="form-control" required/><br/>
<input type="hidden" name="id" value="${sessionScope.id}"/>
</div>

<div id="container-btn">
<input type="button" id="btn" name="btn" value="완료"/>
</div>
</form>
</div>

<!-- footer -->
<jsp:include page="/headerfooter/footer.jsp"/>
</div>

</body>
</html>