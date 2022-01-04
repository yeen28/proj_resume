<%@page import="kr.co.sist.portfolio.portfolio_writeCRUD"%>
<%@page import="kr.co.sist.portfolio.portfolio_writeVO"%>
<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"
    info="포트폴리오 수정"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>포트폴리오</title>

<style type="text/css">
.go_portfolio_list{ margin-top: 100px; margin-bottom: 100px; text-align: center; }
.go{ margin-top: 30px; }
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
<%
request.setCharacterEncoding("UTF-8");
%>
<!-- header -->
<jsp:include page="/headerfooter/header.jsp"></jsp:include>
<jsp:useBean id="pv" class="kr.co.sist.portfolio.portfolio_writeVO"/>
<jsp:setProperty property="*" name="pv"/>
<div class="container">
	<div class="go_portfolio_list">
		<c:catch var="e">
		<%
		portfolio_writeCRUD pbc=new portfolio_writeCRUD();
		pbc.updatePortfolio(pv);
		%>
		<span style="font-size: 30px; color: #333; font-weight: bold;">포트폴리오 수정 성공</span><br/>
		<div class="go">
			<span style="font-size: 28px; color: #333;">
				<a href="http://localhost/sist_resume/new_portfolio/portfolio_list.jsp">포트폴리오 목록</a>조회하기
			</span>
		</div>
		</c:catch>
		<c:if test="${ not empty e }">
			<c:out value="${ param.proj_title }"/>의 포트폴리오 정보를 입력 중 문제 발생.<br/>
			<%-- ${ e } --%>
		</c:if>
	</div>
</div>

<!-- footer -->
<jsp:include page="/headerfooter/footer.jsp"></jsp:include>
</body>
</html>