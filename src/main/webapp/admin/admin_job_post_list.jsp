<%@page import="kr.co.sist.admin.Resize"%>
<%@page import="kr.co.sist.admin.UploadFileService"%>
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
<title>채용공고 페이지</title>
<jsp:include page="admin_header.jsp"/>
<style type="text/css">
/* container */
.job{ font-size: 25px; font-weight: bold; color: #333; }
.logo-title {text-align:center; display:table; width:150px; height:150px;}
.logo-img-div {display:table-cell; vertical-align:middle;}
.logo-img { max-width:100px; max-height:110px;}

.companyName1{  width: 1000px; }
.companySite{  font-size: 15px; }
.companyLine{margin-bottom: 30px;}
.companyName2{ position: absolute; top: 350px; left: 570px; }
.companyBtn{ font-size: 20px; background-color: #494949; color: #FFFF; border: 1px solid #494949; border-radius: 4px; margin: auto; margin-top: 50px; height: 35px; padding: 5px}	

.center {margin: 0px auto; text-align: center; width: 1000px}
.con_font{font-size: 16px; font-weight: bold; color: #333; }
/* 소제목 */
.title2{  margin-bottom: 20px; margin-top: 50px; font-weight: bold; font-size: 25px;}

hr{border: 0; height: 2px; background: #ccc; width: 1000px; margin: auto;}
</style>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(function () {
	$("#listbtn").click(function() {
		location.href="http://localhost/sist_resume/admin/admin_job_post_main.jsp";
	});
	
})//ready

</script>
</head>
<body>

 <%
 	String paramIdx = request.getParameter("idx");
 	int idx = Integer.parseInt(paramIdx);
 	
	JobpostDAO jdao = new JobpostDAO();
 	JobpostVO jv = new JobpostVO();
 	//해당 쿼리 진행하는 method 불러옴
 	JobpostVO jVO=jdao.selectAllJobpost_list(idx);
 	//scope객체 사용
 	pageContext.setAttribute("jpData", jVO);
 	
	%> 
	
	
	<%
UploadFileService ufs=new UploadFileService();
pageContext.setAttribute( "fileList", ufs.searchFileList(idx) );
%>
	
	
	
<div class="center">
	<div id="container">
		<div style="margin: 0px auto; width: 900px;text-align: left; margin-bottom: 80px">
			<h3 class="title2">채용공고 관리</h3>
		</div>	
		<div class="companyName1">
			<table class="table" style="margin-bottom: 0px; ">
				<tbody>
					<tr>
						<td rowspan="2" style="width: 150px">
						
						<c:if test="${ not empty jpData.img }">
<%
String img=jVO.getImg();
Resize r=new Resize();
r.resize(img); //입력된 이미지명에 대해 설정된 크기로 이미지를 생성한다.
%>
</c:if>
						
						
							<div class="logo-title">
								<div class="logo-img-div">
									<img class="logo-img" src="http://localhost/sist_resume/upload/${jpData.img}">
								</div>
							</div>
						</td>
						<td width="100" style="vertical-align: middle;">
							<span class="con_font">회사명</span>
						</td>
						<td style="vertical-align: middle;">
							<span style="font-size: 15px; color: #333"><c:out value=" ${jpData.company }"/></span>
						</td>
						<td width="150" style="vertical-align: middle;">
							<a href="http://${jpData.homepage}" class="companySite">회사홈페이지</a>
						</td>
					</tr>
					<tr>
						<td width="100" style="vertical-align: middle;">
							<span class="con_font">주소</span>
						</td>
						<td colspan="2" style="vertical-align: middle;">
							<span style="font-size: 15px; color: #333"><c:out value=" ${jpData.address }"/></span>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="companyLine">
			<hr/>
		</div>
		<div class="con_font" style="width: 1000px;margin: auto;text-align: left;">
			<table style="width: 970px">
				<tr>
					<th style="width: 80px; height: 50px;">기술직군</th>
					<th style="width: 80px;"></th>
					<th><c:out value=" ${jpData.subject }"/></th>
				</tr>
				<tr>
					<th style="height:50px">경력</th>
					<th></th>
					<th><c:out value=" ${jpData.career }"/></th>
				</tr>
				<tr>
					<th style="height:50px">입력일</th>
					<th></th>
					<th><c:out value=" ${jpData.input_date }"/></th>
				</tr>
				<tr>
					<th style="height:50px">업무소개</th>
					<th></th>
					<th><c:out value=" ${jpData.description }"/></th>
				</tr>
			</table>
		</div>
		<div>
			<input class="companyBtn" id="listbtn" type="button" value="목록으로" >
		</div>
	</div>

</div>

</body>
</html>