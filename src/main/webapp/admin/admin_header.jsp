<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- jQuery CDN-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<style type="text/css">
table {text-align: center; margin-left: auto; margin-right:auto; margin-top: 15px;}
td {padding: 20px; cursor: pointer; font-size: 18px}

.title{font-weight: bold; font-size: 30px;}
a{ color: #000000; text-decoration: none;}
a:hover { color: #000000; text-decoration: none; }
</style>

<script type="text/javascript">
$(function () {
	$("#user_ad").click(function() {
		location.href="http://localhost/sist_resume/admin/admin_user_main.jsp";
	})//login
	$("#job_post_ad").click(function() {
		location.href="http://localhost/sist_resume/admin/admin_job_post_main.jsp";
	})//job_post
	$("#notice_ad").click(function() {
		location.href="http://localhost/sist_resume/admin/admin_notice_main.jsp";
	})//notice
	$("#pass_ad").click(function() {
		location.href="http://localhost/sist_resume/admin/admin_pass_change.jsp";
	})//pass
	
	$("#logout_ad").click(function () {
		var logout_con = confirm("로그아웃하시겠습니까?");
		if(logout_con == true){
			location.href="http://localhost/sist_resume/admin/admin_logout.jsp";
		}//end if
		else if(logout_con == false){
		}//end else
	})//logout
	
})//ready
</script>

	<header>
		<div >
			<table style="width: 1500px;">
				<tr>
					<td class="title" ><a href="http://localhost/sist_resume/admin/admin_main.jsp">관리자 페이지</a></td><!-- 얘는 그냥 링크로 하시면 되요-->
					<td>&nbsp;</td>
					<td id="user_ad">회원 관리</td>
					<td>||</td> 
					<td id="job_post_ad">채용공고 관리</td>
					<td>||</td>
					<td id="notice_ad">공지사항 관리</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td id="pass_ad">비밀번호 변경</td>
					<td>&nbsp;</td>
					<td id="logout_ad">로그아웃</td>
				</tr>
			</table>
		</div>
	</header>