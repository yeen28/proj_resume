package kr.co.sist.resume;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.sist.dao.GetJdbcTemplate;

public class ResumeDAO {

	public CareerVO selectCareer(String id) throws SQLException {
		CareerVO cVO = new CareerVO();

		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();

		String selectCareer = "select * from career where id = '" + id + "'";

		cVO = jt.queryForObject(selectCareer, new RowMapper<CareerVO>() {

			@Override
			public CareerVO mapRow(ResultSet rs, int rowCnt) throws SQLException {
				CareerVO cVO = new CareerVO();

				cVO.setIdx(rs.getInt("idx"));
				cVO.setCompany(rs.getString("company"));
				cVO.setTask(rs.getString("task"));
				cVO.setPeriod(rs.getString("period"));
				cVO.setDescription(rs.getString("description"));
				cVO.setTech(rs.getString("tech"));

				return cVO;
			}
		});

		return cVO;
	}

	public int updateCareer(CareerVO cVO) throws DataAccessException {
		int count = 0;
		
		
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();

		System.out.println(cVO.toString());

		String updateCareer;
		if (cVO.getIdx() == 0) {
			updateCareer = "insert into career (idx, company, task, period, description, tech, id) values(career_seq.nextval, ?, ?, ?, ?, ?, ?)";
			count = jt.update(updateCareer, cVO.getCompany(), cVO.getTask(), cVO.getPeriod(), cVO.getDescription(),
					cVO.getTech(), cVO.getId());
		} else {
			updateCareer = "update career set company=?, task=?, period=?, description=?, tech=? where idx = ?";
			count = jt.update(updateCareer, cVO.getCompany(), cVO.getTask(), cVO.getPeriod(), cVO.getDescription(),
					cVO.getTech(), cVO.getIdx());
		}

		gjt.closeAc();
		return count;
	}

	public EducationVO selectEducation(String id) throws SQLException {
		EducationVO eVO = new EducationVO();

		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();

		String selectEducation = "select * from education where id = '" + id + "'";

		eVO = jt.queryForObject(selectEducation, new RowMapper<EducationVO>() {

			@Override
			public EducationVO mapRow(ResultSet rs, int rowCnt) throws SQLException {
				EducationVO eVO = new EducationVO();

				eVO.setIdx(rs.getInt("idx"));
				eVO.setScore(rs.getDouble("score"));
				eVO.setMax_score(rs.getDouble("max_score"));
				eVO.setUniv(rs.getString("univ"));
				eVO.setMajor(rs.getString("major"));
				eVO.setDegree(rs.getString("degree"));
				eVO.setEnt(rs.getString("ent"));
				eVO.setGrad(rs.getNString("grad"));
				eVO.setDescription(rs.getString("description"));

				return eVO;
			}
		});

		return eVO;
	}

	public int updateEdu(EducationVO eVO) throws DataAccessException {
		int count = 0;
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();

		String updateEdu;
		if (eVO.getIdx() == 0) {
			updateEdu = "insert into education (univ, major, degree, ent, grad, score, max_score, description, id, idx) values(?, ?, ?, ?, ?, ?, ?, ?, ?, edu_seq.nextval)";
			count = jt.update(updateEdu, eVO.getUniv(), eVO.getMajor(), eVO.getDegree(), eVO.getEnt(), eVO.getGrad(),
					eVO.getScore(), eVO.getMax_score(), eVO.getDescription(), eVO.getId());
		} else {
			updateEdu = "update education set univ=?, major=?, Degree=?, ent=?, grad=?, score=?, max_score=?, description=? where idx = ?";
			count = jt.update(updateEdu, eVO.getUniv(), eVO.getMajor(), eVO.getDegree(), eVO.getEnt(), eVO.getGrad(),
					eVO.getScore(), eVO.getMax_score(), eVO.getDescription(), eVO.getIdx());
		}

		gjt.closeAc();
		return count;
	}

	public CertificateVO selectCert(String id) throws SQLException {
		CertificateVO cVO = new CertificateVO();

		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();

		String selectCert = "select * from Certificate where id = '" + id + "'";

		cVO = jt.queryForObject(selectCert, new RowMapper<CertificateVO>() {

			@Override
			public CertificateVO mapRow(ResultSet rs, int rowCnt) throws SQLException {
				CertificateVO cVO = new CertificateVO();

				cVO.setIdx(rs.getInt("idx"));
				cVO.setTitle(rs.getString("title"));
				cVO.setGet_date(rs.getString("get_date"));
				cVO.setDescription(rs.getString("description"));

				return cVO;
			}

		});

		return cVO;
	}

	public int updateCert(CertificateVO cVO) throws DataAccessException {
		int count = 0;
		
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();

		String updateCert;
		if (cVO.getIdx() == 0) {
			updateCert = "insert into certificate(idx, title, get_date, description, id) values(cert_seq.nextval, ?, ?, ?, ?)";
			count = jt.update(updateCert, cVO.getTitle(), cVO.getGet_date(), cVO.getDescription(), cVO.getId());
		} else {
			updateCert = "update certificate set title=?, get_date=?, description=? where idx=?";
			count = jt.update(updateCert, cVO.getTitle(), cVO.getGet_date(), cVO.getDescription(), cVO.getIdx());
		}

		gjt.closeAc();
		
		return count;
	}

	public LanguageVO selectLang(String id) throws SQLException {
		LanguageVO lVO = new LanguageVO();

		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();

		String selectLang = "select * from Language where id = '" + id + "'";

		lVO = jt.queryForObject(selectLang, new RowMapper<LanguageVO>() {

			@Override
			public LanguageVO mapRow(ResultSet rs, int rowCnt) throws SQLException {
				LanguageVO lVO = new LanguageVO();

				lVO.setIdx(rs.getInt("idx"));
				lVO.setLang(rs.getString("lang"));
				lVO.setExam_title(rs.getString("exam_title"));
				lVO.setScore(rs.getString("score"));

				return lVO;
			}

		});

		return lVO;
	}
	
	public int updateLang(LanguageVO lVO) throws DataAccessException {
		int count = 0;
		
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();

		String updateLang;
		if (lVO.getIdx() == 0) {
			updateLang = "insert into language(idx, lang, exam_title, score, id) values(lang_seq.nextval, ?, ?, ?, ?)";
			count = jt.update(updateLang, lVO.getLang(), lVO.getExam_title(), lVO.getScore(), lVO.getId());
		} else {
			updateLang = "update language set lang=?, exam_title=?, score=? where idx=?";
			count = jt.update(updateLang, lVO.getLang(), lVO.getExam_title(), lVO.getScore(), lVO.getIdx());
		}

		gjt.closeAc();
		
		return count;
	}

	public void deleteRow(String table, int idx) throws DataAccessException {
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();

		String deleteCareer = "delete " + table + " where idx = '" + idx + "'";

		jt.update(deleteCareer);
		gjt.closeAc();
	}

}