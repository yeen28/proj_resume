package kr.co.sist.portfolio;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.sist.dao.GetJdbcTemplate;

public class portfolio_writeCRUD {
	
	public int insertPortfolio(portfolio_writeVO pbVO) throws DataAccessException {
		int cnt=0;
		
		//1. GetJdbcTemplate ¾ò±â
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate ¾ò±â
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. Äõ¸®¹® ÀÛ¼º
		String insert="insert into portfolio(idx, proj_title, date_year, team, description, id, url_link) values(port_seq.nextval,?,?,?,?,?,?)";
		cnt=jt.update(insert, pbVO.getProj_title(), pbVO.getDate_year(), pbVO.getTeam(), pbVO.getDescription(), pbVO.getId(), pbVO.getUrl_link());
		//4. ´Ý±â
		gjt.closeAc();
		
		return cnt;
		
	}//insertPortfolio
	
	public portfolio_writeVO selPortfolio(int idx, String id) throws DataAccessException {
		portfolio_writeVO pbVO=null;
		
		//1. GetJdbcTemplate ¾ò±â
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate ¾ò±â
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. Äõ¸®¹® ÀÛ¼º
		String select="select proj_title, date_year, team, description, url_link from portfolio where idx=? and id=?";
		pbVO=jt.queryForObject(select, new Object[] { idx, id }, new RowMapper<portfolio_writeVO>() {
			@Override
			public portfolio_writeVO mapRow(ResultSet rs, int rowNum) throws SQLException {
				portfolio_writeVO pbVO=new portfolio_writeVO();
				pbVO.setProj_title(rs.getString("proj_title"));
				pbVO.setDate_year(rs.getString("date_year"));
				pbVO.setTeam(rs.getString("team"));
				pbVO.setDescription(rs.getString("description"));
				pbVO.setUrl_link(rs.getString("url_link"));
				return pbVO;
			}
		});
		//4. ´Ý±â
		gjt.closeAc();
		
		return pbVO;
		
	}//selPortfolio
	
	public void updatePortfolio(portfolio_writeVO pbVO) throws DataAccessException {
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		JdbcTemplate jt=gjt.getJdbcTemplate();
		
		String update="update portfolio set proj_title=?, date_year=?, team=?, description=?, url_link=? where id=? and idx=?";
		jt.update(update, pbVO.getProj_title(), pbVO.getDate_year(), pbVO.getTeam(), pbVO.getDescription(), pbVO.getUrl_link(), pbVO.getId(), pbVO.getIdx());
		//4. ´Ý±â
		gjt.closeAc();
	}//updatePortfolio
	
}//class