<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session.invalidate();
response.sendRedirect("http://localhost/sist_resume/admin/admin_login.jsp");
%>