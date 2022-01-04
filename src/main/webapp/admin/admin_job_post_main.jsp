<%@page import="kr.co.sist.admin.JobpostVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.sist.admin.JobpostDAO"%>
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
<title>관리자 채용공고 관리 페이지</title>
<jsp:include page="admin_header.jsp"/>
<style type="text/css">
/* 소제목 */
.title2{  margin-bottom: 20px; margin-top: 50px; font-weight: bold; font-size: 25px;}
.title_tr>th{ text-align: center;font-size: 14px; }

th{text-align: center;}
#title{text-align: left;}
</style>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(function () {
	$("#add_job").click(function() {
		location.href="http://localhost/sist_resume/admin/admin_job_post_add.jsp";
	})
	$("#job_post_det").click(function() {
		location.href="http://localhost/sist_resume/admin/admin_job_post_list.jsp";
	})
})//ready

function removeData(idx) {
	if (confirm( idx + " 번 채용공고를 삭제하시겠습니까?")) {
		$("#removeJobpost").val( idx );
		
		$("#removeFrm").submit();
	}//end if
}//removeData
</script>
</head>
<body>
<c:catch var="e">
	<%
	JobpostDAO jdao = new JobpostDAO();
	
	int numPerPage = 10;
	int totData = jdao.selJobpost();
	int LastPage = totData/numPerPage;
	if (totData % numPerPage > 0) {
		++LastPage;
	}//end if
	
	int blockPage = 10;
	int nowPage = 1;
	try {
		nowPage = Integer.parseInt(request.getParameter("page"));
	} catch(NumberFormatException nfe) {
		nowPage = 1;
	}
	
	int start = ((nowPage -1)/blockPage)*10+1;
	int end = start+blockPage-1;
	if(end > LastPage) {
		end = LastPage;
	}//end if
	
	int rowBegin = (nowPage -1)*numPerPage+1;
	int rowEnd = nowPage * numPerPage;
	
	List<JobpostVO> list = jdao.selectAllJobpost(rowBegin, rowEnd); 
	
	pageContext.setAttribute("start", start);
	pageContext.setAttribute("end", end);
	pageContext.setAttribute("nowPage", nowPage);
	
	pageContext.setAttribute("jobpostData", list);
	%>
<div class="container">
	<div style="margin: 0px auto; width: 900px;text-align: left;">
		<h3 class="title2">채용공고 관리</h3>
	</div>
	
	<div style="padding-top: 50px;">
		<table class="table table-hover" style="width: 1300px;">
			<thead>
				<tr class="title_tr">
					<th style="width:100px;">번호</th>
					<th style="width:600px">회사명</th>
					<th style="width:120px;">입력일</th>
					<th style="width:80px"></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="jobpost" items="${ jobpostData }"> 
					<c:set var="i" />
						<tr>
							<th ><c:out value="${jobpost.idx}"/></th>
							<th id="title"><a href="http://localhost/sist_resume/admin/admin_job_post_list.jsp?idx=${jobpost.idx}"><c:out value="${jobpost.company}"/></a></th>
							<th ><c:out value="${jobpost.input_date}"/></th>
							<th ><input type="button" value="삭제" class="btn" onclick="removeData(${jobpost.idx})"></th>
						</tr>
				</c:forEach>
			</tbody>
		</table>
	</div><br/>
		<div style="text-align: center;">
			<nav id="pagination">
				<ul class="pagination">
					<li>
						<c:if test="${ nowPage ne 1 and param.page ne null }">
							<a href="http://localhost/sist_resume/admin/admin_job_post_main.jsp?page=${ nowPage-1 }" aria-label="Previous">
								<span aria-hidden="true">&laquo;</span>
							</a>
						</c:if>
					</li>
					<c:forEach var="i" begin="${ start }" end="${ end }">
						<li><a href="http://localhost/sist_resume/admin/admin_job_post_main.jsp?page=${ i }" ><c:out value="${ i }"/></a></li>
					</c:forEach>
					<li>
						<% if(LastPage != 0 && nowPage != LastPage){ %>
						<a href="http://localhost/sist_resume/admin/admin_job_post_main.jsp?page=${ nowPage+1 }" aria-label="Next">
							<span aria-hidden="true">&raquo;</span>
						</a>
							<% } %>
					</li>
				</ul>
			</nav>
		</div>
	<div style="text-align: center">
		<button type="button" class="btn btn-dark" id="add_job">채용공고 추가</button>
	</div>
			<!-- 채용공고 삭제 -->
		<form name="removeFrm" id="removeFrm" action="http://localhost/sist_resume/admin_process/remove_job_post_process.jsp" method="post">
			<input type="hidden" name="idx" id="removeJobpost"> 
		</form>
</div>
</c:catch>	
</body>
</html>