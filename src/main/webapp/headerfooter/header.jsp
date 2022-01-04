<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link rel="stylesheet" href="http://localhost/sist_resume/headerfooter/header.css">
<%
String userName = (String) session.getAttribute("userName");
%>

<div class="bloc l-bloc" id="nav-bloc">
	<div class="container">
		<nav class="navbar row">
			<div class="navbar-header">
				<a class="navbar-brand" href="http://localhost/sist_resume/index.jsp">이력서 및 채용공고</a>
				<!-- 브라우저 창이 작아지면 메뉴를 접었다 폈다 할수 있음 -->
				<button id="nav-toggle" type="button"
					class="ui-navbar-toggle navbar-toggle" data-toggle="collapse"
					data-target=".navbar-1">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
			</div>
			<div class="collapse navbar-collapse navbar-1">
				<ul class="site-navigation nav">
					<li><a href="http://localhost/sist_resume/new_resume/new_resume.jsp">이력서</a></li>
					<li><a href="http://localhost/sist_resume/new_portfolio/portfolio_list.jsp">포트폴리오</a></li>
					<li><a href="http://localhost/sist_resume/new_job_post/job_post_list.jsp">채용공고</a></li>
					<li><a href="http://localhost/sist_resume/new_notice/notice_list.jsp">공지사항</a></li>
					<%
					if(userName != null && !userName.equals("")) {
						out.print("<li><a href='http://localhost/sist_resume/new_profile/new_profile.jsp'>"); 
						out.print(userName + "'s 프로필");
						out.print("</a></li>"); 
					}
					%>
				</ul>
			</div>
		</nav>
	</div>
</div>