package kr.co.sist.job_post;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.sist.admin.JobpostVO;
import kr.co.sist.dao.GetJdbcTemplate;

public class job_postDAO {
	
	public List<job_postVO> selectAlljobpost() {
		List<job_postVO> list=null;
		
		//1. Spring Container 얻기
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate 얻기
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. 쿼리문 실행
		String selectJobpost = "select * from job_post order by idx desc";
		list=jt.query(selectJobpost, new RowMapper<job_postVO>() {
			
			@Override
			public job_postVO mapRow(ResultSet rs, int rowCnt) throws SQLException {
				job_postVO jpVO=new job_postVO();
				
				jpVO.setIdx(rs.getInt("idx"));
				jpVO.setCompany(rs.getString("company"));
				jpVO.setImg(rs.getString("img"));
				jpVO.setCareer(rs.getString("career"));
				jpVO.setAddress(rs.getString("address"));
				jpVO.setDescription(rs.getString("description"));
				jpVO.setInput_date(rs.getString("input_date"));
				jpVO.setId(rs.getString("id"));
				jpVO.setHomepage(rs.getString("homepage"));
				
				return jpVO; 
			}//mapRow
			
		});
		
		//4. Spring Container 닫기
		gjt.closeAc();
		
		return list;
		
	}//selectAlljob_post
	
	public List<job_postVO> selectAlljobpost(int begin, int end) {
		List<job_postVO> list=null;
		
		//1. Spring Container 얻기
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate 얻기
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. 쿼리문 실행
		StringBuilder selectJobpost = new StringBuilder();
		selectJobpost
		.append("	select *	")
		.append("	from (select rownum r_num, idx, company, img, career, address, description, to_char(input_date,'yyyy-MM-dd') input_date, id, homepage	")
		.append("	from job_post	")
		.append("	order by idx desc)	")
		.append("	where r_num between ? and ?	");
		list=jt.query(selectJobpost.toString(), new Object[] { begin, end }, new RowMapper<job_postVO>() {
			
			@Override
			public job_postVO mapRow(ResultSet rs, int rowCnt) throws SQLException {
				job_postVO jpVO=new job_postVO();
				
				jpVO.setIdx(rs.getInt("idx"));
				jpVO.setCompany(rs.getString("company"));
				jpVO.setImg(rs.getString("img"));
				jpVO.setCareer(rs.getString("career"));
				jpVO.setAddress(rs.getString("address"));
				jpVO.setDescription(rs.getString("description"));
				jpVO.setInput_date(rs.getString("input_date"));
				jpVO.setId(rs.getString("id"));
				jpVO.setHomepage(rs.getString("homepage"));
				
				return jpVO; 
			}//mapRow
			
		});
		
		//4. Spring Container 닫기
		gjt.closeAc();
		
		return list;
		
	}//selectAlljob_post
	
	public job_postVO selectJobpost(int idx) {
		job_postVO jpVO=new job_postVO();
		
		//1. Spring Container 얻기
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		//2. JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		//3. 쿼리문 실행
		
		String selectQuery="select * from job_post where idx = ?";
		
		jpVO=jt.queryForObject(selectQuery, new Object[] { Long.valueOf(idx) }, new RowMapper<job_postVO>() {
			
			@Override
			public job_postVO mapRow(ResultSet rs, int rowCnt) throws SQLException {
				job_postVO jpVO=new job_postVO();
				
				jpVO.setIdx(rs.getInt("idx"));
				jpVO.setCompany(rs.getString("company"));
				jpVO.setImg(rs.getString("img"));
				jpVO.setCareer(rs.getString("career"));
				jpVO.setAddress(rs.getString("address"));
				jpVO.setDescription(rs.getString("description"));
				jpVO.setInput_date(rs.getString("input_date"));
				jpVO.setId(rs.getString("id"));
				jpVO.setHomepage(rs.getString("homepage"));
				
				return jpVO;
				
			}//mapRow
			
		});
		
		gjt.closeAc();
		
		return jpVO;
		
	}//selectJobpost
	
	
	/**
	 * 채용공고 추가페이지 기술직군 select 데이터
	 * @param idx
	 * @return
	 * @throws SQLException
	 */
	public List<JobpostVO> selectAllSubject(int idx) throws SQLException {
		List<JobpostVO> list = null;
		
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();
		StringBuilder selectSubject = new StringBuilder();
		
		selectSubject
		.append("  select idx, subject ")
		.append( " from tech_stack ");
		
		list = jt.query(selectSubject.toString(), new SelectSubject());
		
		gjt.closeAc();
		
		return list;
	}//selectAllSubject
	
	public class SelectSubject implements RowMapper<JobpostVO> {
		public JobpostVO mapRow(ResultSet rs, int rowNum) throws SQLException {
			JobpostVO jv = new JobpostVO();
			jv.setIdx(rs.getInt("idx"));
			jv.setSubject(rs.getString("subject"));
			
			return jv;
		}
	}//SelectSubject

}//class
