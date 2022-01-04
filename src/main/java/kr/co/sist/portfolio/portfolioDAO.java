package kr.co.sist.portfolio;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.sist.dao.GetJdbcTemplate;

public class portfolioDAO {
	
	public List<portfolio_listVO> selectAllportfolio(String id) throws SQLException {
		List<portfolio_listVO> list=null;
		
		//1. Spring Container ���
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate ���
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. ������ ����
		StringBuilder selectPortfolio=new StringBuilder();
		selectPortfolio.append( "select idx, proj_title, date_year, team, description, id" ).append(" from portfolio where id=?");
		
		list=jt.query(selectPortfolio.toString(), new Object[] { id }, new SelectPortfolio());
		//4. Spring Container �ݱ�
		gjt.closeAc();
		
		return list;
		
	}//selectAllportfolio
	
	public List<portfolio_listVO> selectAllportfolio(String id, int begin, int end) throws SQLException {
		List<portfolio_listVO> list=null;
		
		//1. Spring Container ���
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate ���
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. ������ ����
		StringBuilder selectPortfolio=new StringBuilder();
		selectPortfolio
		.append("	select idx, proj_title, date_year, team, description, id	" )
		.append("	from (select rownum r_num, idx, proj_title, date_year, team, description, id	")
		.append("	from (select idx, proj_title, date_year, team, description, id	")
		.append("	from portfolio where id=?	")
		.append("	order by idx desc))	")
		.append("	where r_num between ? and ?	");
		
		list=jt.query(selectPortfolio.toString(), new Object[] { id, begin, end }, new SelectPortfolio());
		//4. Spring Container �ݱ�
		gjt.closeAc();
		
		return list;
		
	}//selectAllportfolio
	
	public class SelectPortfolio implements RowMapper<portfolio_listVO> {
		public portfolio_listVO mapRow(ResultSet rs, int rowNum)throws SQLException {
			portfolio_listVO paVO=new portfolio_listVO();
			paVO.setIdx(rs.getInt("idx"));
			paVO.setProj_title(rs.getString("proj_title"));
			paVO.setDate_year(rs.getString("date_year"));
			paVO.setTeam(rs.getString("team"));
			paVO.setDescription(rs.getString("description"));
			paVO.setId(rs.getString("id"));
			
			return paVO;
		}//mapRow
	}//SelectPortfolio
	
	
	public int deletePortfolio(int idx)throws DataAccessException {
		int cnt=0;
		
		//1. Spring Container ���
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate ���
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. ������ ����
		String deletePortfolio="delete from portfolio where idx=?";
		cnt=jt.update(deletePortfolio, idx);
		//4. Spring Container �ݱ�
		gjt.closeAc();
		
		return cnt;
	}//deletePortfolio

}//class