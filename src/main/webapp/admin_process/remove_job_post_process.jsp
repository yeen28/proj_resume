<%@page import="kr.co.sist.admin.JobpostVO"%>
<%@page import="kr.co.sist.admin.JobpostDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>이력서 관리 및 채용공고 관리자 페이지</title>
<jsp:include page="../admin/admin_header.jsp"/>
<style type="text/css">
.subtitle {width: 1000px; margin: auto; text-align: center; margin-top: 200px;}
.sub_btn {width: 1000px; margin: auto; text-align: center; margin-top: 100px}
</style>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(function () {
	$("#btn").click(function () {
		location.href = "http://localhost/sist_resume/admin/admin_job_post_main.jsp";
	});//btn-click
});//ready
</script>
</head>
<body>

<c:catch var="e">
	<%
/*	String paramIdx = request.getParameter("idx");
 	int idx = Integer.parseInt(paramIdx); */
 	
/*  int idx = Integer.parseInt(request.getParameter("idx"));  */
	String paramIdx = request.getParameter("idx");
	/* if (paramIdx == null) {
		paramIdx = "0";
	} */
	int idx = Integer.parseInt(paramIdx);

/* 	String paramIdx = request.getParameter("idx");
 	int idx = Integer.parseInt(paramIdx); */
 	
	JobpostDAO jdao = new JobpostDAO();
 /* 	JobpostVO jv = new JobpostVO(); */
 	//해당 쿼리 진행하는 method 불러옴
/*  	int cnt =jdao.deleteData(idx); */

 	//scope객체 사용
 	pageContext.setAttribute("cnt", jdao.deleteData(idx));
 	
	/* JobpostDAO jd = new JobpostDAO();
	pageContext.setAttribute("cnt", jd.deleteData(idx)); */
	%>
	<c:choose>	
		<c:when test="${cnt eq 0 }">
			<h2><strong><c:out value="${param.idx }"/></strong>번 채용공고 존재하지 않습니다.</h2>
		</c:when>
		<c:otherwise>
		<div class="subtitle">
			<span style="font-weight: bold; font-size: 40px; ">
				<c:out value="${param.idx }"/>번 채용공고가 삭제되었습니다.
			</span>
		</div>
		<div class="sub_btn">
			<input type="button" id="btn" class="btn btn-lg"value="채용공고 홈가기">
		</div>
		</c:otherwise>
	</c:choose>
</c:catch>
<c:if test="${not empty e }">
	<c:out value="${e }"/>
		삭제 중 문제가 발생하였습니다.
</c:if>
</body>
</html>