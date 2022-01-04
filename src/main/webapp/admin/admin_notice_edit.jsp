<%@page import="kr.co.sist.admin.UpdateNoticeVO"%>
<%@page import="kr.co.sist.admin.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="공지사항 수정 페이지"
    %>
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
<title>공지사항 관리 페이지</title>

<style type="text/css">
.notice_title{margin: 0px auto; width: 1000px}
.note {margin: 0px auto; width: 1000px; margin-top: 20px; }

/* 소제목 */
.title2{  margin-bottom: 20px; margin-top: 50px; font-weight: bold; font-size: 25px;}
</style>

  <!-- summernote -->
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  
<jsp:include page="admin_header.jsp"/>
  
  <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>  
<!-- 국제화 : 다른 나라의 언어로 서비스를 제공할 때 i18n -->
<script src="http://localhost/sist_resume/common/js/summernote/lang/summernote-ko-KR.js"></script>
<script>
$(document).ready(function() {
        $('#summernote').summernote({
			placeholder : '공지사항 작성란',
			tabsize : 2,
			width: 1000,
			height: 500,
			lang: 'ko-KR',
        	toolbar: [
        	    // [groupName, [list of button]]
        	    ['style', ['bold']],
        	    ['font', ['strikethrough']],
        	    ['fontsize', ['fontsize']],
        	    ['color', ['color']],
        	    ['table',['table']],
        	    ['insert', ['link']] //, 'picture', 'video']]
        	  ]
        });
}); //ready
</script>
<script type="text/javascript">
$(function () {
	$("#edit").click(function() {
		
		if( $("#title").val() == "" ){
			alert("제목을 입력해주세요.");
			return;
		}
		
		if( $("#summernote").val() == "" ){
			alert("내용을 입력해주세요.");
			return;
		}
		
		$("#frm").submit();
	}); //click
}); //ready
</script>
</head>
<body>
<c:catch var="e">
<%
request.setCharacterEncoding("UTF-8");

int idx=0;
try{
	idx=Integer.parseInt(request.getParameter("idx"));
} catch(NumberFormatException nfe){
	idx=0;
}//end catch

NoticeDAO nd=new NoticeDAO();
UpdateNoticeVO unv=nd.selEditNotice(idx);
pageContext.setAttribute("unv", unv);
%>
<c:if test="${ empty param.title }">
<!-- 공지사항 작성 서머노트 -->
<div class="container">
	<div style="margin: 0px auto; width: 900px;text-align: left; padding-bottom: 50px">
		<h3 class="title2">공지사항 작성</h3>
	</div>

<form name="frm" id="frm" method="post">
<div class="notice_title">
	<input type="text" class="form-control" placeholder="제목" name="title" id="title" value="${ unv.title }">
</div>
<div class="note">
		<textarea name="description" id="summernote"> ${ unv.description }</textarea>
</div>
<input type="hidden" name="id" value="${ sess_id }"/>
</form>

<!-- 공지사항 내용 추가 버튼 -->
	<div style="text-align: center"><!-- div가 가진 대상을 가운데 정렬합니다.-->
		<input type="button" class="btn" value="작성 완료" id="edit">
	</div>
</div>
</c:if>

<c:if test="${ not empty param.title }">
<jsp:useBean id="unVO" class="kr.co.sist.admin.UpdateNoticeVO" scope="page"/>
<jsp:setProperty property="*" name="unVO"/>

<%
nd.updateNotice(unVO);
%>
<!-- <script type="text/javascript">
alert("공지사항을 수정했습니다.");
</script> -->
<% response.sendRedirect("http://localhost/sist_resume/admin/admin_notice_list.jsp?idx="+idx);  %>
</c:if>
</c:catch>
<c:if test="${ not empty e }">
${ e }
<c:redirect url="http://localhost/sist_resume/common/error/error.jsp"/>
</c:if>

</body>
</html>