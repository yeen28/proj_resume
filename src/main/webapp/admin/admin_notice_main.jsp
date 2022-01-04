<%@page import="kr.co.sist.admin.NoticeVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.sist.admin.NoticeDAO"%>
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
<title>공지사항 관리 페이지</title>

<style type="text/css">
/* 소제목 */
.title2{  margin-bottom: 20px; margin-top: 50px; font-weight: bold; font-size: 25px;}
.title_tr>th{ text-align: center;font-size: 14px; }
#title{text-align: left;}
</style>

<jsp:include page="admin_header.jsp"/>

<script type="text/javascript">
$(function () {
	$("#add_notice").click(function() {
		location.href="http://localhost/sist_resume/admin/admin_notice_add.jsp";
	})
	$("#notice_det").click(function() {
		location.href="http://localhost/sist_resume/admin/admin_notice_list.jsp";
	})
	
})
</script>
</head>
<body>

<c:catch var="e">
<%
request.setCharacterEncoding("UTF-8");
NoticeDAO nd=new NoticeDAO();
int numPerPage=10;
int totData=nd.selectAllNotice().size();
int LastPage=totData/numPerPage;
if(totData % numPerPage > 0){
	++LastPage;
}
int blockPage=10;
int nowPage=1;
try{
	nowPage=Integer.parseInt(request.getParameter("now"));
} catch (NumberFormatException nfe){
	nowPage=1;
}
int start=((nowPage-1)/blockPage)*10+1;
int end=start+blockPage-1;
if( end > LastPage ){
	end=LastPage;
}

int rowBegin=(nowPage-1)*numPerPage+1;
int rowEnd=nowPage*numPerPage;
List<NoticeVO> noticeList=nd.selAllTitle(rowBegin, rowEnd);

pageContext.setAttribute("start", start);
pageContext.setAttribute("end", end);
pageContext.setAttribute("nowPage", nowPage);
pageContext.setAttribute("noticeList", noticeList);
%>
<div class="container">
	<div style="margin: 0px auto; width: 900px;text-align: left;">
		<h3 class="title2">공지사항 관리</h3>
	</div>
	
	<div style="padding-top: 50px;">
		<table class="table table-hover" style="width: 1300px;">
			<thead>
				<tr class="title_tr">
					<th style="width: 100px; height: 41px">번호</th>
					<th style="width: 600px;">제목</th>
					<th style="width:120px;">작성일</th>
					<th style="width:80px;">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="notice" items="${ noticeList }"> 
						<tr class="title_tr">
							<th style="height: 50px" ><c:out value="${notice.idx}"/></th>
							<th id="title"><a href="http://localhost/sist_resume/admin/admin_notice_list.jsp?idx=${ notice.idx }"><c:out value="${notice.title}"/></a></th>
							<th><c:out value="${notice.input_date}"/></th>
							<th style="text-align:center;"><c:out value="${notice.count}"/></th>
						</tr>
				</c:forEach>
			</tbody>
		</table>
	</div><br/>
	
	<!-- 페이지 네비게이션  -->
	<div class="text-center">
		<nav id="pagination">
					<ul class="pagination">
						<li>
						<c:if test="${ nowPage ne 1 and param.now ne null }">
							<a href="http://localhost/sist_resume/admin/admin_notice_main.jsp?now=${ nowPage-1 }" aria-label="Previous">
								<span aria-hidden="true">&laquo;</span>
							</a>
						</c:if>
						</li>
						<c:forEach var="i" begin="${ start }" end="${ end }">
						<li><a href="http://localhost/sist_resume/admin/admin_notice_main.jsp?now=${ i }"><c:out value="${ i }"/></a></li>
						</c:forEach>
						<li>
						<% if(LastPage != 0 && nowPage != LastPage){ %>
							<a href="http://localhost/sist_resume/admin/admin_notice_main.jsp?now=${ nowPage+1 }" aria-label="Next">
								<span aria-hidden="true">&raquo;</span>
							</a>
							<% } %>
						</li>
					</ul>
				</nav>
	</div>
	
	<!-- 공지사항 작성 버튼 -->
	<div style="text-align: center"><!-- div가 가진 대상을 가운데 정렬합니다.-->
		<input type="button" class="btn" value="작성" id="add_notice">
	</div>
</div>
</c:catch>
<c:if test="${ not empty e }">
${ e }
<c:redirect url="http://localhost/sist_resume/common/error/error.jsp"/>
</c:if>
</body>
</html>