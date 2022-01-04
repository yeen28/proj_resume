<%@page import="kr.co.sist.admin.LoginDAO"%>
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
.add_button{text-align: center; margin-top: 50px}

/* 소제목 */
.title2{  margin-bottom: 20px; margin-top: 50px; font-weight: bold; font-size: 25px;}

#com_name  {margin-right: 10px; padding: 10px; padding-right: 20px; text-align: left;}

hr {height: 3px;background-color: #dfdfdf; width: 900px;}
</style>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(function () {
	$("#add_jobpost_content").click(function() {
		
		if($("#company").val() == "") {
			alert("회사명을 입력해주세요.");
			return;
		}//end if
		
		if($("#choose_img").val() == "") {
			alert("이미지를 넣어주세요.");
			return;
		}//end if
		
		
		if($("#homepage").val() == "") {
			alert("홈페이지를 입력해주세요.");
			return;
		}//end if
		
		if($("#address").val() == "") {
			alert("주소를 입력해주세요.");
			return;
		}//end if
		
		if($("#tech_idx").val() == null) {
			alert("기술직군을 선택해주세요.");
			return;
		}//end if
		
		if($("#career").val() == "") {
			alert("경력을 입력해주세요.");
			return;
		}//end if
		
		if($("#description").val() == null) {
			alert("업무소개를 입력해주세요.");
			return;
		}//end if
		
		var con_job_post = confirm("채용공고를 등록하시겠습니까?");
		if(con_job_post){
			$("#job_post_add_frm").submit();
		}//end if

	});
})//ready
</script>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	
	JobpostDAO jdao = new JobpostDAO();
	List<JobpostVO> list = jdao.selectAllSubject(0); 
	pageContext.setAttribute("post_techData", list); 
	%>

<form action="../admin_process/insert_job_post_process.jsp" method="post" id="job_post_add_frm" name="job_post_add_frm" enctype="multipart/form-data"> 
<div >
	<div class="container">
		<div style="margin: 0px auto; width: 900px;text-align: left; padding-bottom: 50px">
			<h3 class="title2">채용공고 작성</h3>
		</div>
		<table class="table">
			<tr>
				<td>회사명</td>
				<td><input type="text" class="form-control" id="company"  name="company" style="width:600px; text-align: left" placeholder="내용을 입력해주세요." ></td>
			</tr>
			<tr>
				<td>이미지</td>
				<td>
					<input type="file" id="img" name="img" />
					<label>파일선택</label>
				</td>
			</tr>
			<tr>
				<td>홈페이지</td>
				<td><input type="text" class="form-control" id="homepage" name="homepage" style="width:600px; text-align: left" placeholder="http:// 회사 url" ></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" class="form-control" id="address" name="address" style="width:600px; text-align: left" placeholder="내용을 입력해주세요." ></td>
			</tr>
			<tr>
				<td>기술직군</td>
				<td style="text-align: left" id="tech_idx">
					<select name="tech_idx" >
						<option>------선택------</option>
						<c:forEach var="post_tech" items="${post_techData }">
							<option value="${post_tech.idx }"><c:out value="${post_tech.subject }"/></option>
						</c:forEach>
					</select>
				</td> 
			</tr>
			<tr>
				<td>경력</td>
				<td><input type="text" class="form-control" name="career"  id="career" style="width:600px; text-align: left" placeholder="내용을 입력해주세요." ></td>
			</tr>
			<tr>
				<td>업무소개</td>
				<td style="text-align: left" id="description" >
					<textarea rows="10" cols="65" name="description"  ></textarea>
				</td>
			</tr>
		</table>
			<div class="add_button">
				<input type="button" class="btn btn-lg" value="완료" id="add_jobpost_content">
			</div>
	</div>

</div>
</form>
</body>
</html>