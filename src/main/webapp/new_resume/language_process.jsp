<%@page import="org.springframework.dao.DataAccessException"%>
<%@page import="kr.co.sist.resume.ResumeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="langVO" class="kr.co.sist.resume.LanguageVO" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="langVO"/>
<script type="text/javascript">
<%
ResumeDAO rDAO = new ResumeDAO();

try {
	rDAO.updateLang(langVO);
%>
alert("저장되었습니다.");
<%
} catch(DataAccessException e) {
	System.out.println("데이터 액세스 익셉션 발생");
%>
alert("저장에 실패하였습니다.");
<%
}
%>
location.href = "http://localhost/sist_resume/new_resume/new_resume.jsp";
</script>