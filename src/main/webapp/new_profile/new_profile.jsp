<%@page import="java.util.ArrayList"%>
<%@page import="org.springframework.dao.DataAccessException"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.sist.profile.TechVO"%>
<%@page import="kr.co.sist.user.MemberDAO"%>
<%@page import="kr.co.sist.user.IndexVO"%>
<%@page import="kr.co.sist.profile.ProfileVO"%>
<%@page import="kr.co.sist.profile.ProfileDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 세션에 로그인 정보 없을때 -->
<c:if test="${ empty sessionScope.id }">
	<c:redirect url="http://localhost/sist_resume/login/login_page.jsp"></c:redirect>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>내 프로필</title>
<!--jQuery CDN-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="http://localhost/sist_resume/new_profile/new_profile.css">
<%
String id = (String) session.getAttribute("id");

MemberDAO mDAO = new MemberDAO();
ProfileDAO pDAO = new ProfileDAO();
IndexVO iVO = new IndexVO();
ProfileVO pVO = new ProfileVO();
List<TechVO> tList = pDAO.selectTech();
boolean flag = false;
try {
	iVO = mDAO.selUserInfo(id);
	pVO = pDAO.selProfile(id);
	flag = true;
} catch(DataAccessException e) {
	e.printStackTrace();
}

	pageContext.setAttribute("iVO", iVO);
	pageContext.setAttribute("pVO", pVO);
	pageContext.setAttribute("tList", tList);
%>
<script type="text/javascript">
$(function() {
	$("#prof_save_btn").click(function() {
		$("#prof_frm").submit();
	});
	
	$("#img_btn").click(function() {
		let img = $("#img").val();
		
		// 업로드 가능 확장자의 유효성 검증. 서버에서 실행되는 언어와 같은 소스코드는
		// 업로드 하지 못하도록 막아야 한다.
		// 이미지 파일만 업로드 할 수 있도록 검증.
		// jpg, png, gif, bmp
		let blockExt = ["jpg", "png", "gif", "bmp", ""];
		let blockFlag = false;
		
		let ext = (img.substring(img.lastIndexOf(".") + 1)).toLowerCase();
		for(var i = 0; i < blockExt.length; i++) {
			if(ext == blockExt[i]) {
				blockFlag = true;
				
				break;
			}
		}
		
		if(!blockFlag) {
			alert("업로드 가능한 확장자가 아닙니다.");
			
			return;
		}
		
		$("#img_frm").submit();
	});
	
	$("#del_img").click(function() {
		$("#img").val("");
	});
});

</script>
</head>
<body>
<!-- header -->
<jsp:include page="/headerfooter/header.jsp"></jsp:include>
<div class="container">
	<div class="profile_wrap">
		<div class="profile_head">
			<h2>내 프로필</h2>
		</div>
		<div class="profile_body">
			<div class="frm_body">
				
				<form action="upload_process.jsp" id="img_frm" method="post" enctype="multipart/form-data" class="img_frm">
					<div class="prof_img prof_ele" id="prof_img_view">
						<c:choose>
							<c:when test="${ pVO.img eq 'null' or empty pVO.img}">
								<img src="http://localhost/sist_resume/common/images/defalt.jpg" width="200px;">
							</c:when>
							<c:otherwise>
								<img src="http://localhost/sist_resume/new_profile/upload/${ pVO.img }" width="200px;">
							</c:otherwise>
						</c:choose>
					</div>
					<div class="form-group prof_ele">
						<label for="img">프로필 사진</label>
						<input type="file" name="img2" id="img">
						<input type="button" value="이미지 초기화" id="del_img">
						<input type="button" value="업로드" id="img_btn">
						<p class="help-block">프로필 사진은 .jpg, .png .gif, .bmp 파일만 가능하고, 최대 파일 크기는 10MB 입니다.</p>
					</div>
				</form>
				
				<form id="prof_frm" class="prof_frm" action="http://localhost/sist_resume/new_profile/profile_process.jsp" method="post">
				<input type="hidden" name="img" id="hid_img" value="<%=request.getParameter("img")%>">
				<div class="row prof_ele">
					<div class="form-group col-xs-4" >
						<label for="prof_name">이름</label>
						<input type="text" class="form-control" id="prof_name" value="${ iVO.name }" readonly>
					</div>
				</div>
				
				<% 
				String checkM="";
				String checkW="";
				if(flag){
					if(pVO.getGender().equals("M")) {
						checkM=" checked='checked'";
					} else {
						checkW=" checked='checked'";
					} //end else
				}
				%>
					
				<div class="form-group prof_ele">
					<label>성별</label>
					<div>
						<label class="radio-inline">
		  					<input type="radio" name="gender" id="genderM" value="M" <%= checkM %>>남자
						</label>
						<label class="radio-inline">
						 	<input type="radio" name="gender" id="genderW" value="W" <%= checkW %>>여자
						</label>
					</div>
				</div>
				
				<div class="row prof_ele">
					<div class="form-group col-xs-4" >
					<label>관심분야</label>
						<select class="form-control" name="tech_idx">
							<option value="">선택해 주세요</option>
							<%for(int i = 0; i < tList.size(); i++) { %>
							<option value="<%=tList.get(i).getIdx()%>"<% if(pVO.getTech_idx() == tList.get(i).getIdx()) {%> selected="selected"<%} %>><%=tList.get(i).getSubject()%></option>
							<% } %>
						</select>
					</div>
				</div>
				
				<div class="row prof_ele">
					<div class="form-group col-xs-4" >
						<label>휴대폰 번호</label>
						<input type="text" class="form-control" id="prof_phone" name="phone" placeholder="010-1234-1234" value="${ pVO.phone }">
					</div>
				</div>
				
				<div class="form-group prof_ele">
					<label for="prof_url">개인 홈페이지</label>
    				<input type="url" class="form-control" id="prof_url" name="url"  placeholder="http://www.sist.com" value="${ pVO.url }">
				</div>
				
				<div class="form-group prof_ele">
					<label for="prof_desc">한 줄 소개</label>
    				<input type="text" class="form-control" id="prof_desc" name="description" placeholder="한 줄 자기소개를 입력하세요" value="${ pVO.description }">
				</div>
				
				<div class="prof_save_btn prof_ele">
					<button type="button" class="btn btn-success btn-lg" id="prof_save_btn">저장</button>
				</div>
				<input type="hidden" name="id" value="<%= id%>">
				<input type="hidden" name="idx" value="${ pVO.idx }">
			</form>
			</div>
		</div>
	</div>
</div>
<!-- footer -->
<jsp:include page="/headerfooter/footer.jsp"></jsp:include>
</body>
</html>