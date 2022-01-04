package kr.co.sist.admin;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.sist.dao.GetJdbcTemplate;

public class JobpostDAO {

	/**
	 * 채용공고 메인화면 전체조회
	 * @param idx
	 * @return
	 * @throws SQLException
	 */
	public List<JobpostVO> selectAllJobpost(int begin, int end) throws SQLException {
		List<JobpostVO> list = null;
		
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();
		StringBuilder selectJobpost = new StringBuilder();
		
		selectJobpost
		.append("select idx, company, input_date ")
		.append( " from (select rownum r_num, idx,company,input_date ")
		.append("	from (select idx,company,to_char(input_date,'yyyy-MM-dd') input_date	")
		.append("					from job_post	")
		.append("					order by idx desc) )	")
		.append("	where r_num between ? and ?	");
		
		list = jt.query(selectJobpost.toString(), new Object[] {begin, end}, new SelectJobpost());
		
		gjt.closeAc();
		
		return list;
	}//selectAllJobpost
	
	public class SelectJobpost implements RowMapper<JobpostVO> {
		public JobpostVO mapRow(ResultSet rs, int rowNum) throws SQLException {
			JobpostVO jv = new JobpostVO();
			
			jv.setIdx(rs.getInt("idx"));
			jv.setCompany(rs.getString("company"));
			jv.setInput_date(rs.getString("input_date"));
			
			return jv;
		}
	}//SelectJobpost
	
	/**
	 * 채용공고 상세페이지
	 * @param idx
	 * @return
	 * @throws SQLException
	 */
	public JobpostVO selectAllJobpost_list(int idx) throws SQLException {
		JobpostVO jVO = null;
		
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();
		String selectJobpost_list = 
		"  select company, img, career, address, description, to_char(input_date,'yyyy-mm-dd') input_date, homepage, "
				+ "  (select ts.subject from tech_stack ts where ts.idx in "
				+ "  (select pt.tech_idx from post_tech pt where pt.post_idx=?)) as subject "
				+ " from job_post where idx=?  ";
		jVO = jt.queryForObject(selectJobpost_list.toString(), new Object[] { Long.valueOf(idx),Long.valueOf(idx) } ,new SelectJobpost_list());
		
		gjt.closeAc();
		
		return jVO;
	}//selectAllJobpost_list
	
	public class SelectJobpost_list implements RowMapper<JobpostVO> {
		public JobpostVO mapRow(ResultSet rs, int rowNum) throws SQLException {
			JobpostVO jv = new JobpostVO();
			
			jv.setCompany(rs.getString("company"));
			jv.setImg(rs.getString("img"));
			jv.setCareer(rs.getInt("career")); //career 들어가야하는데 subject이들어갔어요 //이걸로 삼성은 조회됩니다.
			jv.setAddress(rs.getString("address"));
			jv.setDescription(rs.getString("description"));
			jv.setInput_date(rs.getString("input_date"));
			jv.setHomepage(rs.getString("homepage"));
			jv.setSubject(rs.getString("subject"));
			
			return jv;
		}
	}//SelectJobpost_list
	
	
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
	

	/**
	 * 채용공고 내용 추가
	 * @param jVO
	 * @return
	 * @throws DataAccessException
	 */
	public int insertJobpost (JobpostVO jVO) throws DataAccessException {
		int cnt = 0;
		int cnt1 = 0;
		
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();
		
		//1. 시퀀스의 번호를 조회해서 변수에 저장한다.
		String selectIdx="select job_post_seq.nextval from dual";
		Integer idx=jt.queryForObject(selectIdx,Integer.class);
		
		//2. 변수에 저장된 번호와 회사, 이미지 등의 Job_post를 실행한다.
		String insertJobpost = 
				" insert into job_post(idx, company, img, career, address, description, input_date, homepage,id) "
				+ "  values (?,?,?,?,?,?,sysdate,?,?)  ";
		cnt = jt.update(insertJobpost, idx,jVO.getCompany(), jVO.getImg(), jVO.getCareer(), jVO.getAddress(), jVO.getDescription(), jVO.getHomepage(),jVO.getId());
		
		//3. 변수에 저장된 번호를 가지고 post_tech를 실행한다. 
		String insertPosttech =
				" insert into post_tech(post_idx, tech_idx) values (?,?)";
		
		cnt1 = jt.update(insertPosttech, idx, jVO.getTech_idx());

		gjt.closeAc();
		
		return cnt+cnt1;
	}//insertJobpost
	
	/**
	 * 채용공고 삭제
	 * @param idx
	 * @return
	 * @throws SQLException
	 */
	public int deleteData(int idx) throws SQLException {
		int cnt = 0;
		int cnt1 = 0;
		
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();

		String deletetech_idx = "  delete from post_tech where post_idx=?  ";
		cnt = jt.update(deletetech_idx,new Object[] {Long.valueOf(idx)});
		
		String deleteJobpost = "  delete from job_post where idx = ?  ";
		cnt1 = jt.update(deleteJobpost,new Object[] {Long.valueOf(idx)});
		gjt.closeAc();
		
		return cnt+cnt1;
	}//deleteData
	
	/**
	 * 총 채용공고 수 
	 * @return 총 채용공고 수 
	 * @throws DataAccessException
	 */
	public int selJobpost() throws DataAccessException {
		int cnt = 0;
		
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();
		String select = "select count(idx) from job_post";
		cnt = jt.queryForObject(select, Integer.class);
		
		return cnt;
	}//selJobpost
	
}
