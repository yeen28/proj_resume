<%@page import="kr.co.sist.admin.Resize"%>
<%@page import="kr.co.sist.admin.JobpostDAO"%>
<%@page import="kr.co.sist.admin.JobpostVO"%>
<%@page import="kr.co.sist.job_post.job_postVO"%>
<%@page import="kr.co.sist.job_post.job_postDAO"%>
<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8" info="채용공고"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>채용공고</title>
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
<link rel="stylesheet" href="http://localhost/sist_resume/new_job_post/job_post_view.css">

<script type="text/javascript">
function job_list(){
	location.href="http://localhost/sist_resume/new_job_post/job_post_list.jsp";
}//job_list
</script>

</head>
<body>
<%
String param1=request.getParameter("idx");
int idx=Integer.parseInt(param1);
job_postDAO jpDAO=new job_postDAO();
job_postVO jpVO=jpDAO.selectJobpost(idx);

JobpostVO jVO=new JobpostDAO().selectAllJobpost_list(idx);
	//scope객체 사용
	pageContext.setAttribute("jpData", jVO);
	pageContext.setAttribute("jpVO", jpVO);
%>
<!-- header -->
	<jsp:include page="/headerfooter/header.jsp"></jsp:include>

<!-- container -->
<div class="container">
<div class="job_post_wrap">
	<div class="job_post_head">
		<h2 style="font-weight: bold;">채용공고</h2>
	</div>	
	<div>
		<!-- <div id="logo">
			<img src="http://localhost/prj2/sample1023/img/sistLogo.png" alt="..." class="img-rounded">
		</div> -->
		<div class="companyPost1">
		<table class="table">
			<tbody>
			<tr>
				<th colspan="3" style="width: 150px">
				<div class="logo-title">
								<div class="logo-img-div">
									<img class="logo-img" src="http://localhost/sist_resume/upload/<%= jpVO.getImg() %>" width="100px;">
								</div>
							</div>
			</tr>
			<tr>
				<th style="width: 150px; font-size: 17px; font-weight: bold; color: #333">회사명</th>
				<th style="width: 150px; font-size: 17px; font-weight: bold; color: #333">주소</th>
				<th style="width: 150px; font-size: 17px; font-weight: bold; color: #333">회사홈페이지</th>
			</tr>
			<tr>
				<td style="width: 700px; font-size: 17px; color: #333"><%= jpVO.getCompany() %></td>
				<td style="width: 700px; font-size: 17px; color: #333"><%= jpVO.getAddress() %></td>
				<td style="width: 700px; font-size: 17px; color: #333"><%= jpVO.getHomepage() %></td>
			</tr>
			</tbody>
		</table>
		</div>
	<div class="companyPost2">
		<table class="table">
			<tbody>
			<tr>
				<th style="width: 170px; font-size: 17px; font-weight: bold; color: #333; text-align: center;">기술직군</th>
				<th style="width: 170px; font-size: 17px; font-weight: bold; color: #333; text-align: center;">경력</th>
				<th style="width: 170px; font-size: 17px; font-weight: bold; color: #333; text-align: center;">입력일</th>
				<th style="width: 170px; font-size: 17px; font-weight: bold; color: #333; text-align: center;">업무소개</th>
			</tr>
			<tr>
				<td style="width: 830px; font-size: 17px; color: #333"><c:out value=" ${jpData.subject }"/></td>
				<td style="width: 830px; font-size: 17px; color: #333"><%= jpVO.getCareer() %></td>
				<td style="width: 830px; font-size: 17px; color: #333"><%= jpVO.getInput_date() %></td>
				<td style="width: 830px; font-size: 17px; color: #333"><%= jpVO.getDescription() %></td>
			</tr>
			</tbody>
		</table>
	</div>
		<input type="button" value="목록으로" onclick="job_list()" class="job_postBtn"/>
	</div>	
</div>
</div>

<!-- footer -->
	<jsp:include page="/headerfooter/footer.jsp"></jsp:include>
</body>
</html>