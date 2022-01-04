<%@page import="org.springframework.dao.DataAccessException"%>
<%@page import="org.springframework.dao.DataIntegrityViolationException"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="kr.co.sist.admin.JobpostVO"%>
<%@page import="kr.co.sist.admin.LoginDAO"%>
<%@page import="kr.co.sist.admin.JobpostDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>이력서 관리 및 채용공고 관리자 페이지</title>
<jsp:include page="../admin/admin_header.jsp"/>
<style type="text/css">
.sub_btn {width: 1000px; margin: auto; text-align: center; margin-top: 100px}
</style>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(function () {
	$("#btn").click(function () {
		location.href = "http://localhost/sist_resume/admin/admin_job_post_main.jsp";
	});//btn-click
});//ready
</script>
</head>
<body>
	<c:catch var="e">
		<%
		request.setCharacterEncoding("UTF-8");
		File uploadPath=new File("C:/Users/user/git/sist_prj2_resume/sist_resume/src/main/webapp/upload");
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}//end if
		
		int maxFileSize=1024*1024*15; //15Mbyte
		
		MultipartRequest mr=new MultipartRequest( request, uploadPath.getAbsolutePath(), maxFileSize, "UTF-8", new DefaultFileRenamePolicy());
		
	 //1.입력폼의 값을 mr로 받는다.
	 	String company = mr.getParameter("company");
	 	String career = mr.getParameter("career");
	 	String tech_idx = mr.getParameter("tech_idx");
	 	String address = mr.getParameter("address");
	 	String description = mr.getParameter("description");
	 	String homepage = mr.getParameter("homepage");
	 //이미지 파일
	 	String OriginName = mr.getOriginalFileName("img"); // 원본파일명
	 	String fileSystemName = mr.getFilesystemName("img"); // 변경된 파일명
	 //session에 있는 id 값을 받아온다.
		String id = (String)session.getAttribute("sess_id");
	 //2. 입력폼의 값을 VO를 생성하고 VO에 넣는다.
		JobpostVO jVO = new JobpostVO();
	 
		jVO.setCompany(company);
 		jVO.setImg(OriginName);
 		try{
			jVO.setCareer(Integer.parseInt(career));
			jVO.setTech_idx(Integer.parseInt(tech_idx)); 
 		} catch(NumberFormatException nfe) {
 			jVO.setCareer(0);
 			jVO.setTech_idx(0);
 		}
		jVO.setAddress(address);
		jVO.setDescription(description);
		
		jVO.setHomepage(homepage);
	 //3. 값을 가진 VO를 insert할 method에 넣어 insert작업을 수행한다.
		JobpostDAO jd = new JobpostDAO();
		int cnt = jd.insertJobpost(jVO); 
	 //4. insert작업후 view페이지로 이동한다.  

		%>
		<div style="font-size: 40px; font-weight: bold; width: 1000px; margin: auto; margin-top: 200px; text-align: center;">
			채용공고가 등록되었습니다.
		</div>
		<div class="sub_btn">
			<input type="button" id="btn" class="btn btn-lg" value="채용공고 홈가기">
		</div>
	</c:catch>
		<c:if test="${not empty e }">
			죄송합니다. 채용공고 등록 중 에러가 발생했습니다. 다시 한번 시도해주시길 바랍니다.
			<c:out value="${e }"/>
		</c:if>
</body>
</html>