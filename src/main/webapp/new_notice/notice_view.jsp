<%@page import="kr.co.sist.notice.NoticeVO"%>
<%@page import="kr.co.sist.notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>공지사항 보기</title>
<!--jQuery CDN-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="http://localhost/sist_resume/new_notice/notice_view.css">
<script type="text/javascript">
function notice(){
	location.href="http://localhost/sist_resume/new_notice/notice_list.jsp";
}//notice
</script>
</head>
<body>
<%
String param1 = request.getParameter("idx");
int idx = Integer.parseInt(param1);
NoticeDAO nDAO = new NoticeDAO();
NoticeVO nVO = nDAO.selectNotice(idx);
%>
	<!-- header -->
	<jsp:include page="/headerfooter/header.jsp"></jsp:include>
	<div class="container">
		<div class="notice_wrap">
			<div class="notice_head">
				<h2 style="font-weight: bold;">공지사항</h2>
			</div>
			<div class="notice_border">
				<div class="notice_content">
					<table class="table">
						<tbody>
							<tr>
								<td style="font-weight: bold; font-size: 16px; color: #333;">제목</td>
								<td colspan="5" style="font-size: 16px; color: #333;"><%= nVO.getTitle() %></td>
							</tr>
							<tr>
								<td style="font-weight: bold; font-size: 16px; color: #333;">작성자</td>
								<td style="font-size: 16px; color: #333;"><%= nVO.getId() %></td>
								<td style="font-weight: bold; font-size: 16px; color: #333;">작성일</td>
								<td style="font-size: 16px; color: #333;"><%= nVO.getInput_date() %></td>
								<td style="font-weight: bold; font-size: 16px; color: #333;">조회수</td>
								<td style="font-size: 16px; color: #333;"><%= nVO.getCount() %></td>
							</tr>
							<tr>
								<td colspan="6" style="font-size: 16px; color: #333;"><%= nVO.getDescription() %></td>
							</tr>
						</tbody>
					</table>
				</div>
				<input type="button" value="목록" onclick="notice()" class="noticeBtn"/>
			</div>
		</div>
	</div>
	<!-- footer -->
	<jsp:include page="/headerfooter/footer.jsp"></jsp:include>
</body>
</html>