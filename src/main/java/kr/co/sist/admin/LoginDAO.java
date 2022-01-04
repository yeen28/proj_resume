package kr.co.sist.admin;

import java.sql.SQLException;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import kr.co.sist.dao.GetJdbcTemplate;

public class LoginDAO {

	/**
	 * �Է��� ���̵�, ��й�ȣ�� ���̵� ���
	 * @param id, pass
	 * @return ���̵�
	 * @throws SQLException
	 */
	public String selectLogin( String id, String pass ) throws SQLException {
		String result="";
		
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt=gjt.getJdbcTemplate();
		
		StringBuilder selectMember=new StringBuilder();
		selectMember
		.append("	select id	")
		.append("	from admin	")
		.append("	where id=? and password=? ");
		result=jt.queryForObject(selectMember.toString(), new Object[] { id, pass }, String.class);
		
		gjt.closeAc();
		
		return result;
	}//selectLogin
	
	/**
	 * ������ ���̵�� ��й�ȣ ���
	 * @param id
	 * @return ���� ��й�ȣ
	 * @throws SQLException
	 */
	public String selChangePwd(String id) throws SQLException {
		String pass="";
		
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt=gjt.getJdbcTemplate();
		
		StringBuilder selectPw=new StringBuilder();
		selectPw
		.append("	select password	")
		.append("	from admin	")
		.append("	where id=?	");
		pass=jt.queryForObject(selectPw.toString(), new Object[] { id }, String.class);
		
		gjt.closeAc();
		
		return pass;
	}//selChangePwd
	
	/**
	 * ��й�ȣ ����
	 * @param id
	 * @param pass
	 * @throws DataAccessException
	 */
	public void updatePwd( String id, String pass ) throws DataAccessException {
		
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt=gjt.getJdbcTemplate();
		
		StringBuilder updateMember=new StringBuilder();
		updateMember
		.append("	update admin	")
		.append("	set password=?	")
		.append("	where id=?");
		jt.update(updateMember.toString(), pass, id);
		
		gjt.closeAc();
	}//updatePwd

}//class
