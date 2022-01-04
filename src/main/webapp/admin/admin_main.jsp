<%@page import="kr.co.sist.admin.UserDAO"%>
<%@page import="kr.co.sist.admin.UserVO"%>
<%@page import="kr.co.sist.admin.MainVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.sist.admin.MainDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${ empty sess_id }">
<c:redirect url="http://localhost/sist_resume/admin/admin_login.jsp"/>
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>이력서 관리 및 채용공고 관리자 페이지</title>
<jsp:include page="admin_header.jsp"/>
<style type="text/css">
#All {
	margin: 0px auto;
	width: 1300px;
}

#main_user {
	width: 1300px;
	height: 380px;
	margin: 0px auto;
	border: 1px solid #333;
	border-radius: 30px;
	margin-top: 100px;
	margin-right: 100px;
	float: left;
	overflow: scroll;
}

#main_job_post {
	width: 1300px;
	height: 380px;
	margin: 0px auto;
	border: 1px solid #333;
	border-radius: 30px;
	margin-top: 520px;
	overflow: scroll;
}

#tbl {
	width: 1300px;
	height: 500px;
}

</style>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(function () {
	$("#main_user").click(function() {
		location.href="http://localhost/sist_resume/admin/admin_user_main.jsp";
	});//main_user
	$("#main_user1").click(function() {
		location.href="http://localhost/sist_resume/admin/admin_user_main.jsp";
	});//main_user
	$("#main_job_post").click(function() {
		location.href="http://localhost/sist_resume/admin/admin_job_post_main.jsp";
	});//main_user
})//ready
</script>
</head>
<body>
<div class="item_margin" id="All">
	 <div class="main1" id="main_user">
		<%
		request.setCharacterEncoding("UTF-8");
		%>
		<%
		MainDAO mDAO = new MainDAO();
		List<UserVO> ulist = mDAO.selectAllUser();
		pageContext.setAttribute("userData", ulist);
		%>
			<h2> &nbsp;&nbsp;회원정보 </h2>
		<table id="tbl">
			<tbody>
				<tr>
					<td style="color: #0099FF"><h3>아이디</h3></td>
					<td style="color: #0099FF"><h3>비밀번호</h3></td>
					<td style="color: #0099FF"><h3>이름</h3></td>
					<td style="color: #0099FF"><h3>이메일</h3></td>
				</tr>
				<c:forEach var="users" items="${ userData }">
					<tr>
						<td style="font-size: 14px"><c:out value="${ users.id }"></c:out></td>
						<td style="font-size: 14px"><c:out value="${ users.password }"></c:out></td>
						<td style="font-size: 14px"><c:out value="${ users.name }"></c:out></td>
						<td style="font-size: 14px"><c:out value="${ users.email }"></c:out></td>
						<td style="font-size: 14px"><c:out value="${ user.input_date }"></c:out></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
	<div class="main3" id="main_job_post">
		<%
		MainDAO mDAO1 = new MainDAO();
		List<MainVO> mlist = mDAO.selectAllJobPost();
		pageContext.setAttribute("jobpostData", mlist);
		%>
				<h2> &nbsp;&nbsp;채용공고 </h2>
		<table id="tbl">
			<tbody>
				<tr>
					<td style="color: #0099FF"><h3>번호</h3></td>
					<td style="color: #0099FF"><h3>회사명</h3></td>
					<td style="color: #0099FF"><h3>주소</h3></td>
					<td style="color: #0099FF"><h3>날짜</h3></td>
					<td style="color: #0099FF"><h3>아이디</h3></td>
					<td style="color: #0099FF"><h3>홈페이지</h3></td>
				</tr>
				<c:forEach var="job_post" items="${ jobpostData }">
					<tr>
						<td style="font-size: 14px"><c:out value="${ job_post.idx }"></c:out></td>
						<td style="font-size: 14px"><c:out value="${ job_post.company }"></c:out></td>
						<td style="font-size: 14px"><c:out value="${ job_post.address }"></c:out></td>
						<td style="font-size: 14px"><c:out value="${ job_post.input_date }"></c:out></td>
						<td style="font-size: 14px"><c:out value="${ job_post.id }"></c:out></td>
						<td style="font-size: 14px"><c:out value="${ job_post.homepage }"></c:out></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

</body>
</html>