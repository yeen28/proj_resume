package kr.co.sist.admin;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.sist.dao.GetJdbcTemplate;

public class UserDAO {

	/**
	 * 총 회원 수 얻기
	 * @return 총 회원 수
	 * @throws DataAccessException
	 */
	public int selCnt() throws DataAccessException {
		int cnt=0;
		
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		JdbcTemplate jt=gjt.getJdbcTemplate();
		String select="select count(id) from users";
		cnt=jt.queryForObject(select, Integer.class);
		
		return cnt;
	}//selCnt
	
	 /**
	 * 회원 전체 조회
	 * @author user
	 */
	   public List<UserVO> selectAllUsers(int begin, int end)throws SQLException {
		      List<UserVO> list=null;
		      
		      GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		      JdbcTemplate jt=gjt.getJdbcTemplate();
		      StringBuilder selectUsers=new StringBuilder();
		      
		      selectUsers.append
		      ("   select id,password,name,email,input_date	")
		      .append("	from (select rownum rnum, id, password, name, email, to_char(input_date,'yyyy-MM-dd day')input_date   ")
		      .append("   from users)  ")
		      .append("  where rnum between ? and ?  ");
		      
		      list=jt.query(selectUsers.toString(),new Object[] {begin, end} ,new SelectUsers());

		      gjt.closeAc();
		      
		      return list;
		   }//selectDeptEmp
	   

	public class SelectUsers implements RowMapper<UserVO> {
		   public UserVO mapRow(ResultSet rs, int rowNum) throws SQLException {
			   UserVO uv = new UserVO();
			   uv.setId(rs.getString("id"));
			   uv.setPassword(rs.getString("password"));
			   uv.setName(rs.getString("name"));
			   uv.setEmail(rs.getString("email"));
			   uv.setInput_date(rs.getString("input_date"));
			   return uv;
		   }//UserVO
	   }//SelectUsers
	   
	 /**
	 * 회원 삭제
	 * @param uVO
	 * @throws SQLException
	 */
	//public void deleteId(UserVO uVO) throws SQLException {
		public void deleteId(String id) throws SQLException {
		   
		   GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		   
		   JdbcTemplate jt = gjt.getJdbcTemplate();
		   
		   String deleteId = "delete from users where id=?"; 
		   
		   jt.update(deleteId,id);
		   
		   gjt.closeAc();
		   
	   }//deleteId
	
}//main
