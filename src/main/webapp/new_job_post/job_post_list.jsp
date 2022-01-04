<%@page import="kr.co.sist.job_post.job_postVO"%>
<%@page import="kr.co.sist.job_post.job_postDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8" info="채용공고 목록"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>채용공고 목록</title>
<link rel="stylesheet" type="text/css" href="http://localhost/sist_resume/common/css/main_v20211012.css"/>

<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../favicon.ico">

<!--jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="http://localhost/sist_resume/new_job_post/job_post_list.css">

<script type="text/javascript">

</script>
</head>
<body>
<%
job_postDAO jpDAO=new job_postDAO();

int numPerPage=10;
int totData=jpDAO.selectAlljobpost().size();
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
List<job_postVO> list=jpDAO.selectAlljobpost(rowBegin,rowEnd);

pageContext.setAttribute("start", start);
pageContext.setAttribute("end", end);
pageContext.setAttribute("nowPage", nowPage);
pageContext.setAttribute("selectJobpost", list);
%>
<!-- header -->
	<jsp:include page="/headerfooter/header.jsp"></jsp:include>
<!-- container -->
	<div class="container">
	<div class="job_post_wrap">
		<div class="job_post_head">
			<h2 style="font-weight: bold;">채용공고</h2>
		</div>
	<%-- <div>
		<div class="company">
			<div class="input-group">
				<span class="input-group-btn">
					<button class="btn btn-default" type="button">search</button>
				</span>
				<input type="text" class="form-control" placeholder="회사명">
			</div>
		</div>
		<div class="interest">
			<div class="input-group">
				<span class="input-group-btn">
					<button class="btn btn-default" type="button">search</button>
				</span>
				<input type="text" class="form-control" placeholder="관심분야명">
			</div>
		</div>
	</div> --%>
	<div style="width: 1300px" >
		<table class="table table-hover">
			<thead>
			<tr>
				<th style="font-size: 18px; font-weight: bold; text-align: center; color: #333;">기업명</th>
				<!-- <th style="font-size: 18px; font-weight: bold; text-align: center; color: #333;">상세정보</th> -->
				<th style="font-size: 18px; font-weight: bold; text-align: center; color: #333;">경력</th>
				<th style="font-size: 18px; font-weight: bold; text-align: center; color: #333;">주소</th>
				<th style="font-size: 18px; font-weight: bold; text-align: center; color: #333;">작성일</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach var="jobpost" items="${ selectJobpost }">
			<tr>
				<td style="font-size: 16px; text-align: center; color: #333;"><a href="http://localhost/sist_resume/new_job_post/job_post_view.jsp?idx=${ jobpost.idx }">${ jobpost.company }</a></td>
				<%-- <td style="font-size: 16px; text-align: center; color: #333;">${ jobpost.description }</td> --%>
				<td style="font-size: 16px; text-align: center; color: #333;">${ jobpost.career }</td>
				<td style="font-size: 16px; text-align: center; color: #333;">${ jobpost.address }</td>
				<td style="font-size: 16px; text-align: center; color: #333;">${ jobpost.input_date }</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>		
		<nav id="pagination">
					<ul class="pagination">
						<li>
						<c:if test="${ nowPage ne 1 and param.now ne null }">
							<a href="http://localhost/sist_resume/new_job_post/job_post_list.jsp?now=${ nowPage-1 }" aria-label="Previous">
								<span aria-hidden="true">&laquo;</span>
							</a>
						</c:if>
						</li>
						<c:forEach var="i" begin="${ start }" end="${ end }">
						<li><a href="http://localhost/sist_resume/new_job_post/job_post_list.jsp?now=${ i }"><c:out value="${ i }"/></a></li>
						</c:forEach>
						<li>
						<% if(LastPage != 0 && nowPage != LastPage){ %>
							<a href="http://localhost/sist_resume/new_job_post/job_post_list.jsp?now=${ nowPage+1 }" aria-label="Next">
								<span aria-hidden="true">&raquo;</span>
							</a>
							<% } %>
						</li>
					</ul>
				</nav>
	</div>
	</div>
	
<!-- footer -->
	<jsp:include page="/headerfooter/footer.jsp"></jsp:include>
</body>
</html>