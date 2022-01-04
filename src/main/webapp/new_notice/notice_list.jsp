<%@page import="kr.co.sist.notice.NoticeVO"%>
<%@page import="kr.co.sist.notice.NoticeDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/common/jsp/common_code.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><%= title %></title>

<!--jQuery CDN-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="http://localhost/sist_resume/new_notice/notice_list.css">
</head>
<body>
<%
NoticeDAO nDAO = new NoticeDAO();

int numPerPage=10;
int totData=nDAO.selectAllNotice().size();
int LastPage=totData/numPerPage;
if(totData % numPerPage > 0){
	++LastPage;
}
int blockPage=10;
int nowPage=1; //현재 페이지
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
List<NoticeVO> list=nDAO.selectAllNotice(rowBegin, rowEnd);

pageContext.setAttribute("start", start);
pageContext.setAttribute("end", end);
pageContext.setAttribute("nowPage", nowPage);
pageContext.setAttribute("selectedNotice", list);
%>
	<!-- header -->
	<jsp:include page="/headerfooter/header.jsp"></jsp:include>
	<!-- container -->
	<div class="container">
		<div class="notice_wrap">
			<div class="notice_head">
				<h2 style="font-weight: bold;">공지사항</h2>
			</div>
			<div>
				<table class="table table-hover">
					<thead>
						<tr>
							<td style="font-size: 18px; font-weight: bold; text-align: center; color: #333;">번호</td>
							<td style="font-size: 18px; font-weight: bold; text-align: center; color: #333;">제목</td>
							<td style="font-size: 18px; font-weight: bold; text-align: center; color: #333;">작성자</td>
							<td style="font-size: 18px; font-weight: bold; text-align: center; color: #333;">작성일</td>
							<td style="font-size: 18px; font-weight: bold; text-align: center; color: #333;">조회</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="notice" items="${ selectedNotice }"> 
							<tr>
								<td style="font-size: 16px; text-align: center; color: #333;">${ notice.idx }</td>
								<td style="font-size: 16px; text-align: center; color: #333;"><a href="http://localhost/sist_resume/new_notice/notice_view.jsp?idx=${ notice.idx }">${ notice.title }</a></td>
								<td style="font-size: 16px; text-align: center; color: #333;">${ notice.id }</td>
								<td style="font-size: 16px; text-align: center; color: #333;">${ notice.input_date }</td>
								<td style="font-size: 16px; text-align: center; color: #333;">${ notice.count }</td>
							</tr> 
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="text-center">
		<nav id="pagination">
					<ul class="pagination">
						<li>
						<c:if test="${ nowPage ne 1 and param.now ne null }">
							<a href="http://localhost/sist_resume/new_notice/notice_list.jsp?now=${ nowPage-1 }" aria-label="Previous">
								<span aria-hidden="true">&laquo;</span>
							</a>
						</c:if>
						</li>
						<c:forEach var="i" begin="${ start }" end="${ end }">
						<li><a href="http://localhost/sist_resume/new_notice/notice_list.jsp?now=${ i }"><c:out value="${ i }"/></a></li>
						</c:forEach>
						<li>
						<% if(LastPage != 0 && nowPage != LastPage){ %>
							<a href="http://localhost/sist_resume/new_notice/notice_list.jsp?now=${ nowPage+1 }" aria-label="Next">
								<span aria-hidden="true">&raquo;</span>
							</a>
							<% } %>
						</li>
					</ul>
				</nav>
	</div>
		</div>
	</div>
	<!-- footer -->
	<jsp:include page="/headerfooter/footer.jsp"></jsp:include>
</body>
</html>