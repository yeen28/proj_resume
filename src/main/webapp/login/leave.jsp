<%@page import="kr.co.sist.user.MemberDAO"%>
<%@page import="kr.co.sist.user.LoginVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="회원탈퇴 페이지"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/common/jsp/common_code.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= title %></title>

 <!--jQuery CDN-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="<%= protocol %><%= domain %><%= contextRoot %><%= common_css %>/leave.css" type="text/css"/>
<script type="text/javascript">
function deleteMember() {
	if( $("#exampleInputPassword1").val() == "" ){
		alert("비밀번호를 입력해주세요.");
		document.leaveFrm.password.focus();
		return;
	}//end if
	
	var delConfirm=confirm("탈퇴하시면 모든 정보가 삭제됩니다.\n정말 탈퇴하시겠습니까?");
	if(delConfirm){
		$("#leaveFrm").submit();
	}//end if
} //deleteMember
</script>
</head>

<body>
<c:if test="${ empty sessionScope.id }">
<c:redirect url="login_page.jsp"/>
</c:if>
<%
String id=(String)session.getAttribute("id");
%>
<div id="wrap">
<!-- header -->
<jsp:include page="/headerfooter/header.jsp"></jsp:include>

<div id="container">
<div id="top">
<h2>개인회원 탈퇴</h2>
<hr/>
<span>개인회원 탈퇴 전, 안내 사항을 꼭 확인해주세요.</span>
</div>

<div id="mid">

<%
MemberDAO mDAO=new MemberDAO();
int cnt=mDAO.cntPortfolio(id);
String name=mDAO.selUserInfo(id).getName();
%>

<div id="mid-top">
<span><%= name %></span>&nbsp;&nbsp;&nbsp;회원님께서 보유하고 계신 내역입니다.
<label>이력서&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;포트폴리오( <%= cnt %>개 )</label>
</div>

<div id="mid-mid">
<h4>탈퇴 아이디 복구 불가</h4>
  <p>탈퇴 후에는 아이디와 데이터 복구가 불가능 합니다.<br/>
  신중하게 선택하시기 바랍니다.</p>
<hr/>
<h4>서비스 이용 기록 삭제 안내</h4>
  <p>이력서, 입사지원 현황 등 취업에 필요한 서비스 이용 기록이 모두 삭제되며, 삭제된 데이터는 복구되지 않습니다.<br/>
  필요한 데이터는 미리 백업을 해두시기 바랍니다.</p>
<hr/>
<h4>등록한 게시글 삭제 불가 안내</h4>
  <p>삭제를 원하는 게시글은 반드시 회원탈퇴 전 삭제하시기 바랍니다.<br/>
  탈퇴 후에는 게시글을 임의로 삭제해드릴 수 없습니다.</p>
</div>

<form action="<%= protocol %><%= domain %><%= contextRoot %><%= login %>/process/leave_process.jsp" method="post" id="leaveFrm" name="leaveFrm">
<div id=bottom>
<table class="table">
<tr>
  <td class="th"><label for="exampleInputEmail1">아이디</label></td>
  <td><%= id %><input type="hidden" value="<%=id%>" name="id"/></td>
</tr>
<tr>
  <td class="th"><label for="exampleInputPassword1">비밀번호 확인</label></td>
  <td>
  <div class="form-group">
    <input type="password" class="form-control" id="exampleInputPassword1" name="password" placeholder="비밀번호" required>
  </div>
</tr>
</table>

<div id="btn">
    <input type="button" value="탈퇴하기" id="leave" name="leave" onclick="deleteMember()"/>
    <a class="btn" href="<%=protocol %><%= domain %><%= contextRoot %>/profile/profile.jsp" role="button">돌아가기</a>
</div>
</div>
</form>

</div>
</div>

<!-- footer -->
<jsp:include page="/headerfooter/footer.jsp"></jsp:include>
</div>
</body>
</html>