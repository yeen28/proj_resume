package kr.co.sist.admin;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.sist.dao.GetJdbcTemplate;

public class MainDAO {
	
	public List<UserVO> selectAllUser()throws DataAccessException{
		
		List<UserVO> list = null;
		
		//1. Spring Container 생성 
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		
		//2. JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		
		//3. 쿼리문 수행 
		StringBuilder selectAllUser = new StringBuilder();
		selectAllUser.append("   select id, password, name, email, to_char(input_date,'yyyy-MM-dd day')input_date   ")
		.append("   from users   ");
		
		list = jt.query(selectAllUser.toString(), new SelectUser());
		
		return list;
		
	}//selectAllUser
	
	public class SelectUser implements RowMapper<UserVO>{
		
		public UserVO mapRow(ResultSet rs, int rowNum)throws SQLException{
			
			UserVO uVO = new UserVO();
			
			uVO.setId(rs.getString("id"));
			uVO.setPassword(rs.getString("password"));
			uVO.setName(rs.getString("name"));
			uVO.setEmail(rs.getString("email"));
			uVO.setInput_date(rs.getString("input_date"));
			
			return uVO;
			
		}//mapRow
		
	}//SelectUser
	public List<MainVO> selectAllJobPost()throws DataAccessException{
		
		List<MainVO> list = null;
		
		  //1. Spring Container 생성 
	      GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();

		  //2. JdbcTemplate 얻기
	      JdbcTemplate jt = gjt.getJdbcTemplate();

		  //3. 쿼리문 수행 
	      StringBuilder selectAllJobPost = new StringBuilder();
	      selectAllJobPost.append("	select * from job_post	");
	      
	      list = jt.query(selectAllJobPost.toString(), new SelectJobPost());
		
		return list;
	}//selectAllJobPost
	
	public class SelectJobPost implements RowMapper<MainVO>{
		
		public MainVO mapRow(ResultSet rs, int rowNum)throws SQLException{
			
			MainVO mVO = new MainVO();
			
			mVO.setIdx(rs.getInt("idx"));
			mVO.setCompany(rs.getString("company"));
			mVO.setImg(rs.getString("img"));
			mVO.setCareer(rs.getInt("career"));
			mVO.setAddress(rs.getString("address"));
			mVO.setDescription(rs.getString("description"));
			mVO.setInput_date(rs.getString("input_date"));
			mVO.setId(rs.getString("id"));
			mVO.setHomepage(rs.getString("homepage"));

			return mVO;
			
		}//mapRow
		
	}//SelectJobPost
	
	
}//class
