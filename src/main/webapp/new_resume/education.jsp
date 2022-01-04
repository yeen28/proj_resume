<%@page import="org.springframework.dao.DataAccessException"%>
<%@page import="kr.co.sist.resume.ResumeDAO"%>
<%@page import="kr.co.sist.resume.EducationVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("id");

ResumeDAO rDAO = new ResumeDAO();

try {
	EducationVO eduVO = rDAO.selectEducation(id);
	pageContext.setAttribute("eduVO", eduVO);
} catch (DataAccessException e) {
	System.out.println("저장된 학력이 1건이 아닙니다.");
	e.printStackTrace();
}

%>

<div class="row resume_card_header">
	<div class="resume_card_left col-md-3">
		<h3 class="card_title">학력</h3>
	</div>
	<div class="resume_card_middle col-md-3 col-md-offset-1">
		<h4>${ eduVO.univ } ${ eduVO.major }</h4>
	</div>
	<div class="resume_card_right col-md-2 col-md-offset-3">
		<button class="btn btn-primary btn-lg" type="button"
			data-toggle="collapse" data-target="#education" aria-expanded="false"
			aria-controls="education">+ 상세</button>
	</div>
</div>
<div>
	<div class="collapse" id="education">
		<div class="well resume_form">
			<form action="edu_process.jsp" id="edu_frm" method="post">
				<div class="form-group">
					<label for="edu_univ_name">* 학교명</label> <input type="text"
						class="form-control" id="edu_univ_name" placeholder="ex) 남서울대학교" name="univ" value="${ eduVO.univ }">
				</div>
				<div class="form-group">
					<label for="edu_major">* 전공</label> <input type="text"
						class="form-control" id="edu_major" placeholder="ex) 컴퓨터소프트웨어학과" name="major" value="${ eduVO.major }">
				</div>
				<div class="form-group">
					<label for="edu_degree">* 학위</label> <input type="text"
						class="form-control" id="edu_degree" placeholder="ex) 학사" name="degree" value="${ eduVO.degree }">
				</div>
				<div class="form-group">
					<label for="edu_ent">* 입학년도</label>
					<input type="month" class="form-control" id="edu_ent" name="ent" value="${ eduVO.ent }">
				</div>
				<div class="form-group">
					<label for="edu_grad">졸업(예정) 년월</label>
					<input type="month" class="form-control" id="edu_grad" name="grad" value="${ eduVO.grad}" >
				</div>
				<div class="form-group">
					<label for="edu_score">내 학점 / 최대학점</label>
					<div class="row" id="edu_score">
						<div class="col-xs-2">
							<input type="number" class="form-control" placeholder="3.9"
								step="0.1" id="score" name="score" value="${ eduVO.score }">
						</div>
						<div class="col-xs-2">
							<input type="number" class="form-control" placeholder="4.5"
								step="0.1" id="max_score" name="max_score" value="${ eduVO.max_score }">
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="edu_description">기타 내용</label>
					<textarea class="form-control" id="edu_description" rows="7"
						placeholder="기타 학력사항을 작성해주세요." name="description">${ eduVO.description }</textarea>
				</div>
				<input type="hidden" name="id" value="<%= id %>">
				<input type="hidden" name="idx" value="${ eduVO.idx}">
			</form>
		</div>
		<div class="row">
			<div class="col-md-2 col-md-offset-4">
				<button type="button" class="btn btn-success btn-lg" id="save_edu">저장</button>
			</div>
			<div class="col-md-2">
				<button type="button" class="btn btn-default btn-lg" id="reset_edu">삭제</button>
			</div>
		</div>
		<form id="remove_education" action="remove_process.jsp" method="post">
			<input type="hidden" name="table" value="education">
			<input type="hidden" name="idx" id="edu_idx" value="${ eduVO.idx }">
		</form>
	</div>
</div>