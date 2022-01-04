<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8" info="포트폴리오 작성"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>포트폴리오 작성</title>
<link rel="stylesheet" type="text/css" href="http://localhost/jsp_prj/common/css/main_v20211012.css"/>

<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../favicon.ico">

<style type="text/css">
/* #wrap{ border: 1px solid #333; } */

/* container */
#container{width: 900px; height: 800px; margin: 80px auto;}
#portfolioWrite{ /* position: absolute; top: 130px; left: 400px; */ font-size: 25px; font-weight: bold; color: #333; margin-bottom: 50px; }
#prj1{ border: 1px solid #898989; width: 900px; height: 500px; /* position: absolute; top: 210px; left: 570px; */position: absolute; top: 210px; border-radius: 10px; }
#prj2{ position: absolute; top: 25px; left: 30px; font-size: 20px; font-weight: bold; color: #333; }
#prj3{ position: absolute; top: 100px; left: 50px; }
#inputProject{ width: 500px; }
#year{ position: absolute; top: 100px; left: 600px; }
#selectYear{ width: 200px; }
#team{ position: absolute; top: 180px; left: 50px; }
#selectTeam{ width: 250px; }
#url{ position: absolute; top: 180px; left: 350px; width: 450px; }
#contents{ position: absolute; top: 260px; left: 50px; }
#textarea{ width: 750px; height: 130px; }
.cancel{ position: absolute; top: 440px; left: 350px; font-size: 15px; font-weight: bold; background-color: #D8D8D8; color: #333;
	border-radius: 5px; width: 80px; }
.save{ position: absolute; top: 440px; left: 460px; font-size: 15px; font-weight: bold; background-color: #374FF4; color: #FFFFFF;
	border-radius: 5px; width: 80px; }

</style>

<!--jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script src="http://localhost/sist_resume/common/bootstrap/holder.js"></script> 
<script src="http://localhost/sist_resume/common/bootstrap/ie-emulation-modes-warning.js"></script>
<link href="http://localhost/sist_resume/common/bootstrap/carousel.css" rel="stylesheet">

<script type="text/javascript">
function cancel() {
	location.href="http://localhost/sist_resume/new_portfolio/portfolio_list.jsp";
}//cancel

$(function(){
	
	$("#saveBtn").click(function(){
		if( $("#inputProject").val() == "" ){
			alert("프로젝트명을 입력해주세요.");
			return;
		}//end if
		
		$("#portfolio_write_frm").submit();
	});//click
});//ready
</script>

</head>
<body>
<div id="wrap">
<!-- header -->
<jsp:include page="/headerfooter/header.jsp"></jsp:include>

<form action="portfolio_write_insert_process.jsp" method="post" id="portfolio_write_frm">
<div id="container">
	<div id="portfolioWrite">
		포트폴리오 작성
	</div>
	<div id="prj1">
		<div id="prj2">개인 프로젝트
		<!-- / id <input type="text" name="id"/> -->
		<input type="hidden" name="id" value="${ id }"/>
		</div>
		<div id="prj3">
			<label>프로젝트</label>
    		<input type="text" id="inputProject" class="form-control" placeholder="입력" name="proj_title">
		</div>
		<div id="year">
			<label>제작 연도</label>
			<select id="selectYear" class="form-control" name="date_year">
			<c:forEach var="i" begin="2000" end="2021" step="1">
			<option value="${ i }"><c:out value="${ i }"/>년</option>
			</c:forEach>
			</select>
		</div>
		<div id="team">
			<label>팀 구성<span style="font-size: 10px">(optional)</span></label>
			<select id="selectTeam" class="form-control" name="team">
  				<option>팀</option>
  				<option>개인</option>
			</select>
		</div>
		<div id="url">
		<label>URL<span style="font-size: 10px">(optional)</span></label>
		<input type="text" name="url_link" placeholder="https://" class="form-control"/>
		</div>
		<div id="contents">
			<label>상세 업무 및 성과<span style="font-size: 10px">(optional)</span></label>
			<textarea id="textarea" class="form-control" rows="3" placeholder="입력" name="description"></textarea>
		</div>
		<div id="cancel">
			<input class="cancel" type="button" value="취소" onclick="cancel()">
		</div>
		<div>
			<input class="save" type="button" value="저장" id="saveBtn">
		</div>
	</div>
</div>
</form>

<!-- footer -->
<jsp:include page="/headerfooter/footer.jsp"></jsp:include>
</div>
</body>
</html>