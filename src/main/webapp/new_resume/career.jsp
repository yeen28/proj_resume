<%@page import="kr.co.sist.resume.ResumeDAO"%>
<%@page import="kr.co.sist.resume.CareerVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="org.springframework.dao.DataAccessException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("id");

ResumeDAO rDAO = new ResumeDAO();

try {
	CareerVO careerVO = rDAO.selectCareer(id);
	pageContext.setAttribute("careerVO", careerVO);
} catch (DataAccessException e) {
	System.out.println("저장된 경력이 1건이 아닙니다.");
}
%>

<div class="row resume_card_header">
	<div class="resume_card_left col-md-3">
		<h3 class="card_title">업무 경험</h3>
	</div>
	<div class="resume_card_middle col-md-3 col-md-offset-1">
		<h4>${ careerVO.company } ${ careerVO.period }</h4>
	</div>
	<div class="resume_card_right col-md-2 col-md-offset-3">
		<button class="btn btn-primary btn-lg" type="button"
			data-toggle="collapse" data-target="#career" aria-expanded="false"
			aria-controls="career">+ 상세</button>
	</div>
</div>
<div>
	<div class="collapse" id="career">
		<div class="well resume_form">
			<form id="career_frm" action="career_process.jsp" method="post">
				<div class="form-group">
					<label for="company_name">* 회사 이름</label> <input type="text"
						class="form-control" id="company_name" name="company"
						placeholder="ex) 삼성SDS" value="${ careerVO.company }">
				</div>
				<div class="form-group">
					<label for="task_name">* 직무</label> <input type="text"
						class="form-control" id="task_name" name="task"
						placeholder="ex) 프론트엔드 개발자" value="${ careerVO.task }">
				</div>
				<div class="form-group">
					<label for="work_period">* 근무 기간</label> <input type="text"
						class="form-control" id="work_period" name="period"
						placeholder="ex) 2년 3개월" value="${ careerVO.period }">
				</div>
				<div class="form-group">
					<label for="using_stack">사용 기술</label> <input type="text"
						class="form-control" id="using_stack" name="tech"
						placeholder="ex) android, Java, ..." value="${ careerVO.tech }">
				</div>
				<div class="form-group">
					<label for="career_description">업무 내용</label>
					<textarea class="form-control" id="career_description"
						name="description" rows="7" placeholder="업무 및 성과를 작성해주세요.">${ careerVO.description }</textarea>
				</div>
				<input type="hidden" name="id" value="<%=id%>">
				<input type="hidden" name="idx" value="${ careerVO.idx }">
			</form>
		
		</div>
		<div class="row">
			<div class="col-md-2 col-md-offset-4">
				<button type="button" class="btn btn-success btn-lg"
					id="save_career">저장</button>
			</div>
			<div class="col-md-2">
				<button type="button" class="btn btn-default btn-lg"
					id="reset_career">삭제</button>
			</div>
		</div>
		<form id="remove_career" action="remove_process.jsp" method="post">
			<input type="hidden" name="table" value="career">
			<input type="hidden" name="idx" id="car_idx" value="${ careerVO.idx }">
		</form>
	</div>
</div>