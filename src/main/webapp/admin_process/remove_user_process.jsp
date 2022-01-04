<%@page import="kr.co.sist.admin.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원 삭제 페이지</title>
<jsp:include page="../admin/admin_header.jsp"/>
<style type="text/css">
.subtitle {width: 1000px; margin: auto; text-align: center; margin-top: 200px;}
.sub_btn {width: 1000px; margin: auto; text-align: center; margin-top: 100px}
</style>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(function () {
	$("#btn").click(function () {
		location.href = "http://localhost/sist_resume/admin/admin_user_main.jsp";
	});//btn-click
});//ready
</script>
</head>
<body>
<c:catch var="e">
	<%
	String paramId = request.getParameter("id");
	
	UserDAO ud = new UserDAO();
	ud.deleteId(paramId);
	%>
	<c:choose>	
		<c:when test="${cnt eq 0 }">
			<h2><strong><c:out value="${param.id }"/></strong>번 회원은 존재하지 않습니다.</h2>
		</c:when>
		<c:otherwise>
		<div class="subtitle">
			<span style="font-weight: bold; font-size: 40px; ">
				<c:out value="${param.id }"/>회원이 삭제되었습니다.
			</span>
		</div>
		<div class="sub_btn"">
			<input type="button" id="btn" class="btn btn-lg"value="회원관리 홈가기">
		</div>
		</c:otherwise>
	</c:choose>
</c:catch>
<c:if test="${not empty e }">
	삭제 중 문제가 발생하였습니다.
</c:if>
</body>
</html>