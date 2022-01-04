<%@page import="kr.co.sist.portfolio.portfolio_listVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.sist.portfolio.portfolioDAO"%>
<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8" info="포트폴리오 목록"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<!-- 세션에 로그인 정보 없을때 -->
<c:if test="${ empty sessionScope.id }">
	<c:redirect url="http://localhost/sist_resume/login/login_page.jsp"></c:redirect>
</c:if>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>포트폴리오 목록</title>
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
<link rel="stylesheet" href="http://localhost/sist_resume/new_portfolio/portfolio_list.css">

<script type="text/javascript">
function portfolio_write(){
	location.href="http://localhost/sist_resume/new_portfolio/portfolio_write.jsp";
}//portfolio_write

function deletePortfolio(idx) {
	if(confirm(idx+"번 포트폴리오를 삭제하시겠습니까?")) {
		$("#deleteIdx").val(idx);
		$("#deleteFrm").submit();
	}//end if
}//deletePortfolio
</script>

</head>
<body>
<jsp:useBean id="pVO" class="kr.co.sist.portfolio.portfolio_listVO"/>
<jsp:setProperty property="id" name="pVO" value="${ id }"/>
<%
portfolioDAO pDAO=new portfolioDAO();
	
	int numPerPage = 10;
	int totData = pDAO.selectAllportfolio(pVO.getId()).size();
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
	
List<kr.co.sist.portfolio.portfolio_listVO> list=pDAO.selectAllportfolio(pVO.getId(), rowBegin, rowEnd);
	
	pageContext.setAttribute("start", start);
	pageContext.setAttribute("end", end);
	pageContext.setAttribute("nowPage", nowPage);
	
	pageContext.setAttribute("jobpostData", list);
	
pageContext.setAttribute("portfolioData", list);
%>
<!-- header -->
<jsp:include page="/headerfooter/header.jsp"></jsp:include>

<!-- container -->
<div class="container">
	<div class="portfolio_wrap">
		<div class="portfolio_head">
			<h2 style="font-weight: bold;">포트폴리오 목록</h2>
		</div>
		<div>
			<input class="portfolioBtn" type="button" value="포트폴리오 추가" onclick="portfolio_write()">
		</div>
		<div class="portfolioTable">
			<table class="table table-hover">
				<thead>
					<tr>
						<td style="width: 110px; font-size: 18px; font-weight: bold; text-align: center; color: #333">번호</td>
						<td style="width: 1000px; font-size: 18px; font-weight: bold; text-align: center; color: #333">포트폴리오명</td>
						<td style="width: 110px"></td>
					</tr>
				</thead>
				<tbody>
					<c:if test="${ empty portfolioData }">
						<tr>
							<td colspan="3">포트폴리오가 존재하지 않습니다.</td>
						</tr>
					</c:if>
					<c:forEach var="portfolio" items="${ portfolioData }">
						<tr>
							<td style="font-size: 18px; text-align: center; color: #333"><c:out value="${ portfolio.idx }"/></td>
							<td style="font-size: 18px; text-align: center; color: #333"><a href="http://localhost/sist_resume/new_portfolio/portfolio_detail.jsp?idx=${ portfolio.idx }"><c:out value="${ portfolio.proj_title }"/></a></td>
							<td><input class="deleteBtn" type="button" value="삭제" onclick="deletePortfolio(${portfolio.idx})"></td>
						</tr> 
					</c:forEach>
				</tbody>
			</table>
		<form name="deleteFrm" id="deleteFrm" action="portfolio_list_delete_process.jsp" method="post">
		<input type="hidden" name="idx" id="deleteIdx"/>
		</form>
		</div>
		<div class="text-center">
		<nav id="pagination">
					<ul class="pagination">
						<li>
						<c:if test="${ nowPage ne 1 and param.now ne null }">
							<a href="http://localhost/sist_resume/new_portfolio/portfolio_list.jsp?now=${ nowPage-1 }" aria-label="Previous">
								<span aria-hidden="true">&laquo;</span>
							</a>
						</c:if>
						</li>
						<c:forEach var="i" begin="${ start }" end="${ end }">
						<li><a href="http://localhost/sist_resume/new_portfolio/portfolio_list.jsp?now=${ i }"><c:out value="${ i }"/></a></li>
						</c:forEach>
						<li>
						<% if(LastPage != 0 && nowPage != LastPage){ %>
							<a href="http://localhost/sist_resume/new_portfolio/portfolio_list.jsp?now=${ nowPage+1 }" aria-label="Next">
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