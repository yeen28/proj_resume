<%@page import="kr.co.sist.portfolio.portfolio_writeCRUD"%>
<%@page import="kr.co.sist.portfolio.portfolio_writeVO"%>
<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>포트폴리오</title>
<link rel="stylesheet" type="text/css" href="http://localhost/jsp_prj/common/css/main_v20211012.css"/>

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

<!-- header -->
<jsp:include page="/headerfooter/header.jsp"></jsp:include>

<%
request.setCharacterEncoding("UTF-8");

String proj_title=request.getParameter("proj_title");
String date_year=request.getParameter("date_year");
String team=request.getParameter("team");
String description=request.getParameter("description");
String id=request.getParameter("id");
String url=request.getParameter("url_link");

portfolio_writeVO pwVO=new portfolio_writeVO();
pwVO.setProj_title(proj_title);
pwVO.setDate_year(date_year);
pwVO.setTeam(team);
pwVO.setDescription(description);
pwVO.setId(id);
pwVO.setUrl_link(url);
%>
<div class="container">
	<div class="go_portfolio_list">
		<c:catch var="e">
		<%
		portfolio_writeCRUD pbc=new portfolio_writeCRUD();
		int cnt=pbc.insertPortfolio(pwVO);
		pageContext.setAttribute("cnt", cnt);
		%>
		<span style="font-size: 30px; color: #333; font-weight: bold;">포트폴리오 추가 성공</span><br/>
		<div class="go">
			<span style="font-size: 28px; color: #333;">
				<a href="http://localhost/sist_resume/new_portfolio/portfolio_list.jsp">포트폴리오 목록</a>조회하기
			</span>
		</div>
		</c:catch>
		<c:if test="${ not empty e }">
			<c:out value="${ param.proj_title }"/>의 포트폴리오 정보를 입력 중 문제 발생.<br/>
			<%-- <c:out value="${ e }"></c:out> --%>
		</c:if>
	</div>
</div>

<!-- footer -->
<jsp:include page="/headerfooter/footer.jsp"></jsp:include>
</body>
</html>