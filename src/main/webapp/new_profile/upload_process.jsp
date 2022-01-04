<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info="업로드 파일의 처리"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="http://localhost/jsp_prj/common/css/main_v20211012.css">
<style type="text/css">

</style>
<!--jQuery CDN-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
<%
// 1. 파일 업로드 컴포넌트 생성. (파일이 업로드 된다.)
/* File uploadPath = new File("http://localhost/sist_resume/src/main/webapp/new_profile/upload"); */
File uploadPath = new File("C:/Users/user/git/sist_resume/sist_resume/src/main/webapp/new_profile/upload");
if(!uploadPath.exists()) { // 업로드 폴더가 존재하지 않으면
	uploadPath.mkdirs();
}

int maxSize = 1024 * 1024 * 10;

MultipartRequest mr = new MultipartRequest(request, uploadPath.getAbsolutePath(), maxSize, "UTF-8", new DefaultFileRenamePolicy());
String fileSystemName = mr.getFilesystemName("img2"); // 변경된 파일명
%>
location.href = "http://localhost/sist_resume/new_profile/new_profile.jsp?img=<%=fileSystemName%>";
</script>
</head>
<body>

</body>
</html>