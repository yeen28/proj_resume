<%@page import="kr.co.sist.portfolio.portfolioDAO"%>
<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="http://localhost/sist_resume/common/css/main_v20211012.css"/>

<style type="text/css">
.delete_wrap{ margin-top: 100px; margin-bottom: 100px; text-align: center; }
.back{ margin-top: 30px; }
</style>
<!--jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">

</script>
</head>
<body>

<!-- header -->
<jsp:include page="/headerfooter/header.jsp"></jsp:include>

<!-- container -->
<div class="container">
	<div class="delete_wrap">
		<c:catch var="e">
		<%
		String paramIdx=request.getParameter("idx");
		int idx=Integer.parseInt(paramIdx);

		portfolioDAO pDAO=new portfolioDAO();
		pageContext.setAttribute("cnt", pDAO.deletePortfolio(idx));
		%>
		<c:choose>
			<c:when test="${ cnt eq 0 }">
				<strong><c:out value="${ param.idx }"/></strong>번 포트폴리오는 존재하지 않습니다. 
			</c:when>
			<c:otherwise>
				<span style="font-weight: bold; font-size: 30px; color: #333">
					<c:out value="${ param.idx }"/>번 포트폴리오가 삭제되었습니다.
				</span>
			</c:otherwise>
		</c:choose>
		<div class="back">
			<span style="font-size: 28px; color: #333;">
				<a href="http://localhost/sist_resume/new_portfolio/portfolio_list.jsp">포트폴리오 목록</a>으로 돌아가기
			</span>
		</div>
		</c:catch>
		<c:if test="${ not empty e }">
		포트폴리오 삭제작업 중 문제가 발생하였습니다.
		</c:if>
	</div>
</div>

<!-- footer -->
<jsp:include page="/headerfooter/footer.jsp"></jsp:include>
</body>
</html>