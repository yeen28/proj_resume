<%@page import="org.springframework.dao.DataAccessException"%>
<%@page import="kr.co.sist.profile.ProfileDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="pVO" class="kr.co.sist.profile.ProfileVO" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="pVO"/>
<script type="text/javascript">
<%
String id = (String) session.getAttribute("id");
ProfileDAO pDAO = new ProfileDAO();

try {
	pDAO.updateProfile(pVO);%>
alert("저장되었습니다.");
	<%
} catch(DataAccessException e) {
	e.printStackTrace();
%>
alert("저장에 실패하였습니다.");
<%}%>
location.href = "http://localhost/sist_resume/new_profile/new_profile.jsp";
</script>