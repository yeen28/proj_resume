<%@page import="kr.co.sist.admin.UserVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.sist.admin.UserDAO"%>
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
<title>회원관리 페이지</title>
<jsp:include page="admin_header.jsp"/>
<style type="text/css">
/* 소제목 */
.title2{  margin-bottom: 20px; margin-top: 50px; font-weight: bold; font-size: 25px;}
.title_tr>th{ text-align: center;font-size: 14px; }

th{text-align: center;}

/* 회원 조회 */
#searh {position: absolute; top:2000px; left: 1000px; width: 300px}
</style>

<script type="text/javascript">
function removeData(id) {
	if (confirm( id + " 회원을 삭제하시겠습니까?")) {
		$("#removeUserid").val( id );
		
		$("#removeFrm").submit();
	}//end if
}//removeData

</script>
</head>
<body>
<div class="container">
	<div style="margin: 0px auto; width: 900px;text-align: left;">
		<h3 class="title2">회원 관리</h3>
	</div>
	
	<!-- 회원목록 -->
	<%
	UserDAO ud = new UserDAO();
	
	int numPerPage = 10;
	int totData = ud.selCnt();
	int LastPage = totData/numPerPage;
	if (totData % numPerPage > 0) {
		++LastPage;
	}//end if
	int blockPage = 10;
	int nowPage = 1;
	try {
		nowPage = Integer.parseInt(request.getParameter("page"));
	} catch(NumberFormatException nfe) {
		nowPage = 1;
	}
	
	int start = ((nowPage -1)/blockPage)*10+1;
	int end = start+blockPage-1;
	if(end > LastPage) {
		end = LastPage;
	}//end if
	
	int rowBegin = (nowPage -1)*numPerPage+1;
	int rowEnd = nowPage * numPerPage;
	
	List<UserVO> list = ud.selectAllUsers(rowBegin, rowEnd);
	
	pageContext.setAttribute("start", start);
	pageContext.setAttribute("end", end);
	pageContext.setAttribute("nowPage", nowPage);
	pageContext.setAttribute("userData", list);
	%>
	
	<div style="padding-top: 50px;">
		<table class="table table-hover" style="width: 1300px;">
			<thead>
				<tr class="title_tr">
					<th>아이디</th>
					<th>이름</th>
					<th>이메일</th>
					<th>가입일</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="user" items="${ userData }"> 
						<tr >
							<th><c:out value="${user.id}"/></th>
							<th><c:out value="${user.name}"/></th>
							<th><c:out value="${user.email}"/></th>
							<th><c:out value="${user.input_date}"/></th>
							<th><input type="button" value="삭제" class="btn"  onclick="removeData('${ user.id }')"/></th>
						</tr>
				</c:forEach>
			</tbody>
		</table>
		<!-- 회원 삭제 -->
		<form name="removeFrm" id="removeFrm" action="http://localhost/sist_resume/admin_process/remove_user_process.jsp" method="post">
			<input type="hidden" name="id" id="removeUserid"> 
		</form>
	</div><br/>
	<div style="text-align: center;">
		<nav id="pagination">
			<ul class="pagination">
				<li>
						<c:if test="${ nowPage ne 1 and param.page ne null }">
					<a href="http://localhost/sist_resume/admin/admin_user_main.jsp?page=${ nowPage-1 }" aria-label="Previous">
						<span aria-hidden="true">&laquo;</span>
					</a>
						</c:if>
				</li>
					<c:forEach var="i" begin="${ start }" end="${ end }">
						<li><a href="http://localhost/sist_resume/admin/admin_user_main.jsp?page=${ i }" ><c:out value="${ i }"/></a></li>
					</c:forEach>
				<li>
						<% if(LastPage != 0 && nowPage != LastPage){ %>
					<a href="http://localhost/sist_resume/admin/admin_user_main.jsp?page=${ nowPage+1 }" aria-label="Next">
						<span aria-hidden="true">&raquo;</span>
					</a>
							<% } %>
				</li>
			</ul>
		</nav>
	</div>
</div><!-- container -->	
	
</body>
</html>