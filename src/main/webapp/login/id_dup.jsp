<%@page import="kr.co.sist.user.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="아이디 중복확인"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>아이디 중복확인</title>

<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(function() {
	$("#btn").click(function() {
		chkNull();
	}); //click
	
	$("#id").keydown(function(evt) {
		if( evt.which == 13 ){
			chkNull();
		}//end if
	});
}); //ready

function chkNull() {
	let id=$("#id").val().trim();
	
	if(id==""){
		alert("중복 검사할 아이디를 입력해주세요.");
		return;
	}//end if
	
	$("#frm").submit();
}//chkNull

function sendId( id ){
	//부모창으로 아이디 전달
	opener.window.document.new_user.id.value=id;
	//자식창 닫기
	self.close();
}//sendId
</script>
</head>
<body>
<form action="id_dup.jsp" method="get" id="frm">
<h2>아이디 중복확인</h2>
<label>아이디</label>
<input type="text" name="id" id="id"/>
<input type="text" style="display: none;"/>
<input type="button" value="중복확인" id="btn"/>
<c:if test="${not empty param.id }">
<div>
<%
//입력된 id를 받는다.
String id=request.getParameter("id");
//DB검증.
MemberDAO mDAO=new MemberDAO();
String resultId=mDAO.selectId(id);
//검증결과 출력
pageContext.setAttribute("resultId", resultId);
%>
<span style="color:#0D569F; font-weight: bold;">
입력하신 <c:out value="${ param.id }"/>
</span>는 
<c:choose>
<c:when test="${ empty resultId }">
<span style="color:#0D569F; font-weight: bold;">
사용가능합니다.
</span>
[<a href="javascript:sendId('${ param.id }')">사용</a>]
</c:when>
<c:otherwise>
<span style="color:#D75043; font-weight: bold;">
이미 사용중입니다.
</span>
</c:otherwise>
</c:choose>
</div>
</c:if>
</form>

</body>
</html>