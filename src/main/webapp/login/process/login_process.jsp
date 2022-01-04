<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.sist.user.MemberVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@page import="kr.co.sist.user.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="로그인 처리"
%>
<%@ include file="/common/jsp/common_code.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="lVO" class="kr.co.sist.user.LoginVO" scope="page"/>
<jsp:setProperty property="*" name="lVO"/>

<c:catch var="e">
<%
String password=DataEncrypt.messageDigest( "SHA-1", request.getParameter("password"));

MemberDAO mDAO=new MemberDAO();
	String id=mDAO.selectLogin(lVO.getId(), password);
	session.setAttribute("id", id);
	// 헤더에 이름이 필요해서 세션에 올림
	String userName = mDAO.selUserInfo(id).getName();
	session.setAttribute("userName", userName);

/* List<String> listSub=mDAO.selectSub( mVO.getId() );
List<String> listUrl=mDAO.selectUrl( mVO.getId() );
session.setAttribute("listSub", listSub);
session.setAttribute("listUrl", listUrl); */
%>
<c:redirect url="http://localhost/sist_resume/index.jsp"/>
</c:catch>
<c:if test="${ not empty e }">
<script type="text/javascript">
/* ${ e } */
alert("존재하지 않는 아이디, 비밀번호입니다.");
location.href="javascript:history.back()";
</script>
</c:if>