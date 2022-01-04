<%@page import="org.springframework.dao.DataAccessException"%>
<%@page import="kr.co.sist.resume.ResumeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String table = request.getParameter("table");
int idx = Integer.parseInt(request.getParameter("idx"));
%>
<script type="text/javascript">
<%
ResumeDAO rDAO = new ResumeDAO();

try {
	rDAO.deleteRow(table, idx);
%>
	alert("삭제 되었습니다.");
<%
} catch(DataAccessException e) {
	e.printStackTrace();
%>
	alert("삭제에 실패했습니다.");
<%
}
%>
location.href = "http://localhost/sist_resume/new_resume/new_resume.jsp";
</script>