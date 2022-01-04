<%@page import="kr.co.sist.admin.NoticeVO"%>
<%@page import="kr.co.sist.admin.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="공지사항 상세페이지"
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
<title>공지사항 페이지</title>

<style type="text/css">
/* container */
.noticeTable1{ padding-top:80px; width: 1000px; height: 80px; margin: auto;}
.noticeTable2{ padding-top: 95px; width: 1000px; border: 1px solid #E6E6E6; border-radius: 10px; color: #333; font-size: 17px; margin: auto; }
.noticeContents{ padding : 20px; margin: auto; }
.noticeBtn{ font-size: 20px; background-color: #494949; color: #FFFFFF; border: 1px solid #494949; border-radius: 5px; width: 90px; margin: auto; }
.listbtn{width: 1000px; text-align: center; padding-top: 50px; margin: auto}
.center{margin: 0px auto; text-align: center;}

.con_font {font-size: 15px; font-weight: bold; color: #333}
.con_font2 {font-size: 15px; color: #333}

/* 소제목 */
.title2{  margin-top: 50px; font-weight: bold; font-size: 25px;}
</style>

<jsp:include page="admin_header.jsp"/>

<script type="text/javascript">
$(function () {
	$("#listbtn").click(function() {
		location.href="http://localhost/sist_resume/admin/admin_notice_main.jsp";
	}); //click
	
})//ready

let sess_id = "${ sess_id }";
function deleteBtn(id) {
	if(id != sess_id){
		alert("글 삭제에 접근 권한이 없습니다.");
		return;
	}//end if

	let flag=confirm("정말 삭제하시겠습니까?");
	if(flag){
		$("#delFrm").submit();
	}//end if
}//delete

function edit(id) {
	if(id != sess_id){
		alert("글 수정에 접근 권한이 없습니다.");
		return;
	}//end if
	
	$("#editFrm").submit();
} //edit
</script>
</head>
<body>
<c:catch var="e">
<jsp:useBean id="unVO" class="kr.co.sist.admin.UpdateNoticeVO" scope="page"/>
<jsp:setProperty property="*" name="unVO"/>
<%
int idx=unVO.getIdx();
NoticeDAO nd=new NoticeDAO();
NoticeVO nv=nd.selectDetail(idx);
pageContext.setAttribute("nv", nv);
%>
<div id="center">

<div class="container" >
		<div style="margin: 0px auto; width: 900px;text-align: left;">
			<h3 class="title2">공지사항</h3>
		</div>	
	<div class="noticeTable1">
		<table class="table">
			<tbody>
				<tr>
					<td width="80"><span class="con_font">제목</span></td>
					<td colspan="5"><span class="con_font2">${ nv.title }</span></td>
				</tr>
				<tr>
					<td><span class="con_font">작성자</span></td>
					<td><span class="con_font2">${ nv.id }</span></td>
					<td width="80"><span class="con_font">작성일</span></td>
					<td><span class="con_font2">${ nv.input_date }</span></td>
					<td width="80"><span class="con_font">조회수</span></td>
					<td><span class="con_font2">${ nv.count }</span></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="noticeTable2">
		<div class="noticeContents">
		<c:out value="${ nv.description }" escapeXml="false"/>
		</div>
	</div>
	<div class="listbtn">
		<input class="noticeBtn" type="button" value="목록" id="listbtn">
		<input class="noticeBtn" type="button" value="수정" id="editBtn" onclick="edit('${ nv.id }')">
		<input class="noticeBtn" type="button" value="삭제" id="delBtn" onclick="deleteBtn('${ nv.id }')"/>
		<%-- <input class="noticeBtn" type="button" value="삭제" id="delBtn(${ nv.id })"/> --%>
	</div>
</div>
</div>

<form id="delFrm" method="post">
	<input type="hidden" value="delete" name="delete"/>
</form>

<form id="editFrm" action="http://localhost/sist_resume/admin/admin_notice_edit.jsp">
	<input type="hidden" value="${ unVO.getIdx() }" name="idx"/>
	<%-- <input type="hidden" value="edit" name="edit"/>
	<input type="hidden" value="${ nv.title }" name="title"/>
	<input type="hidden" value="${ nv.description }" name="description"/> --%>
</form>

<%
if( request.getParameter("delete") != null ){
	nd.delNotice(idx);
%>
	<script type="text/javascript">
	alert("삭제되었습니다.");
	location.href="http://localhost/sist_resume/admin/admin_notice_main.jsp";
	</script>
<%
}//end if
%>

</c:catch>
<c:if test="${ not empty e }">
${ e }
<c:redirect url="http://localhost/sist_resume/common/error/error.jsp"/>
</c:if>
</body>
</html>