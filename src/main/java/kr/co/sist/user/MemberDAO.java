package kr.co.sist.user;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.sist.dao.GetJdbcTemplate;

public class MemberDAO {

	/**
	 * ȸ������ ó��
	 * @param mVO ȸ������VO
	 * @throws DataAccessException
	 */
	public void insertMember( MemberVO mVO ) throws DataAccessException {
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt=gjt.getJdbcTemplate();
		
		String insertMember="insert into users(id, password, name, email, input_date) values(?,?,?,?,sysdate)";
		jt.update(insertMember, mVO.getId(), mVO.getPassword(), mVO.getName(), mVO.getEmail());
		
		gjt.closeAc();
		
	}//insertMember
	
	/**
	 * �α��� ó��
	 * @param id
	 * @param pw
	 * @return ȸ�����̵�
	 * @throws SQLException
	 */
	public String selectLogin( String id, String pw ) throws SQLException {
		String result="";
		
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt=gjt.getJdbcTemplate();
		
		StringBuilder selectMember=new StringBuilder();
		selectMember
		.append("	select id	")
		.append("	from users	")
		.append("	where id=? and password=? ");
		result=jt.queryForObject(selectMember.toString(), new Object[] { id, pw }, String.class);
		
		gjt.closeAc();
		
		return result;
	}//selectLogin
	
	/**
	 * ���̵� ã��
	 * @param name
	 * @param email
	 * @return ���̵�
	 * @throws SQLException
	 */
	public String selectFindId( String name, String email ) throws SQLException {
		String id="";
		
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt=gjt.getJdbcTemplate();
		
		StringBuilder selectId=new StringBuilder();
		selectId
		.append("	select id	")
		.append("	from users	")
		.append("	where name=? and email=?	");
		id=jt.queryForObject(selectId.toString(), new Object[] { name, email }, String.class);
		
		gjt.closeAc();
		
		return id;
	}//selectFindId
	
	/**
	 * ��й�ȣ ã��
	 * @param name
	 * @param id
	 * @param email
	 * @return ��й�ȣ
	 * @throws SQLException
	 */
	public String selectFindPw ( String name, String id, String email ) throws SQLException {
		String pw="";
		
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt=gjt.getJdbcTemplate();
		
		StringBuilder selectId=new StringBuilder();
		selectId
		.append("	select password	")
		.append("	from users	")
		.append("	where name=? and id=? and email=?	");
		pw=jt.queryForObject(selectId.toString(), new Object[] { name, id, email }, String.class);
		
		gjt.closeAc();
		
		return pw;
	}//selectFindPw
	
	/**
	 * ������ ���̵� ����Ͽ� ��ġ�ϴ� ��й�ȣ ���
	 * @param id
	 * @return ��й�ȣ
	 */
	public String selChangePw(String id) throws SQLException {
		String pw="";
		
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt=gjt.getJdbcTemplate();
		
		StringBuilder selectPw=new StringBuilder();
		selectPw
		.append("	select password	")
		.append("	from users	")
		.append("	where id=?	");
		pw=jt.queryForObject(selectPw.toString(), new Object[] { id }, String.class);
		
		gjt.closeAc();
		
		return pw;
	}//selectPw
	
	/**
	 * ��й�ȣ ����
	 * @param uVO
	 * @return
	 * @throws DataAccessException
	 */
	public void updatePw( UpdatePwdVO uVO ) throws DataAccessException {
		
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt=gjt.getJdbcTemplate();
		
		StringBuilder updateMember=new StringBuilder();
		updateMember
		.append("	update users	")
		.append("	set password=?	")
		.append("	where id=?");
		jt.update(updateMember.toString(), uVO.getNew_pass(), uVO.getId());
		
		gjt.closeAc();
		
	}//insertMember
	
	/**
	 * ���̵� �ߺ��˻� : ���̵� DB Table�� �����ϴ���?
	 * @param id ��ȸ�� id
	 * @return ��ȸ�� id
	 * @throws SQLException
	 */
	public String selectId(String id) throws SQLException{
		String returnId="";
		
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt=gjt.getJdbcTemplate();
		
		String selectId="select id from users where id=?";
		try {
			//�� ���� ���ڵ尡 ��ȸ�Ǹ� ��ȸ����� ������ ����
			returnId=jt.queryForObject(selectId, new Object[] { id }, String.class);
		} catch(EmptyResultDataAccessException erdae) {
			//��ȸ����� ���� ������ ���ܹ߻�.
			returnId="";
		}//end catch
		
		gjt.closeAc();
		
		return returnId;
	}//selectId
	
	/**
	 * ȸ��Ż��<br/>
	 * ȸ���� ���̵�� ��й�ȣ�� ��ġ�ϴ��� Ȯ��
	 * @param mVO
	 * @return ��й�ȣ
	 * @throws SQLException
	 */
	public String selectPw(String id) throws SQLException {
		String pw="";
		
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt=gjt.getJdbcTemplate();
		
		StringBuilder selectPw=new StringBuilder();
		selectPw
		.append("	select password	")
		.append("	from users	")
		.append("	where id=?	");
		pw=jt.queryForObject(selectPw.toString(), new Object[] { id }, String.class);
		
		gjt.closeAc();
		
		return pw;
	}//selectPw
	
	/**
	 * ȸ��Ż�� ( ȸ���� Ż���ϸ� ��� ��� ���� )
	 * @throws SQLException
	 */
	public void deleteMember(String id) throws SQLException{
		
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
	
		JdbcTemplate jt=gjt.getJdbcTemplate();
	
		String deleteMember="delete from users where id=?";
		jt.update(deleteMember, id);
		
		gjt.closeAc();
	}//deleteMember
	
	/**
	 * ȸ��Ż��� �����ִ� ��Ʈ������ ����
	 * @param id
	 * @return ��Ʈ������ ����
	 * @throws SQLException
	 */
	public int cntPortfolio(String id) throws SQLException{
		int cnt=0;
		
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt=gjt.getJdbcTemplate();
		
		String select="select count(idx) from portfolio where id=?";
		cnt=jt.queryForObject(select, new Object[] { id }, Integer.class);
		
		gjt.closeAc();
		
		return cnt;
	}//cntPortfolio
	

	
	
	
	
	
	/**
	 * ȸ���� ������ ���ɺо� ���
	 * @param id
	 * @return ���ɺо�
	 * @throws SQLException
	 */
	public List<String> selectSub(String id) throws SQLException{
		List<String> returnSub=null;
		
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt=gjt.getJdbcTemplate();
		
		StringBuilder subject=new StringBuilder();
		subject
		.append("	select subject	")
		.append("	from tech_stack	")
		.append("	where idx in (	")
		.append("	select tech_idx	")
		.append("	from profile	")
		.append("	where id=?)	");
		returnSub=jt.query(subject.toString(), new Object[] { id }, new RowMapper<String>() {
			public String mapRow( ResultSet rs, int rowNum ) throws SQLException{
				return String.valueOf(rs.getString("subject"));
			}//mapRow
		});
		
		gjt.closeAc();
		
		return returnSub;
	}//selectSub
	
	/**
	 * ȸ���� Ȩ������ �ּ� ���
	 * @param id
	 * @return ȸ���� Ȩ������ URL
	 * @throws SQLException
	 */
	public List<String> selectUrl(String id) throws SQLException{
		List<String> returnUrl=null;
		
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt=gjt.getJdbcTemplate();
		
		StringBuilder select=new StringBuilder();
		select
		.append("	select url	")
		.append("	from profile	")
		.append("	where id=?	");
		returnUrl=jt.query(select.toString(), new Object[] { id }, new RowMapper<String>() {
			public String mapRow( ResultSet rs, int rowNum ) throws SQLException{
				return String.valueOf(rs.getString("url"));
			}//mapRow
		});
		
		gjt.closeAc();
		
		return returnUrl;
	}//selectUrl
	
	public List<String> selectPhone(String id) throws SQLException{
		List<String> returnPhone=null;
		
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt=gjt.getJdbcTemplate();
		
		StringBuilder select=new StringBuilder();
		select
		.append("	select phone	")
		.append("	from profile	")
		.append("	where id=?	");
		returnPhone=jt.query(select.toString(), new Object[] { id }, new RowMapper<String>() {
			public String mapRow( ResultSet rs, int rowNum ) throws SQLException{
				return String.valueOf(rs.getString("phone"));
			}//mapRow
		});
		
		gjt.closeAc();
		
		return returnPhone;
	}//selectPhone
	
	/**
	 * �̸�, �̸��� ���
	 * @param id
	 * @return �̸�, �̸���
	 * @throws SQLException
	 */
	public IndexVO selUserInfo(String id) throws SQLException{
		IndexVO iv=new IndexVO();
		
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt=gjt.getJdbcTemplate();
		
		StringBuilder select=new StringBuilder();
		select
		.append("	select name, email ")
		.append("	from users	")
		.append("	where id=?	");
		iv=jt.queryForObject(select.toString(), new Object[] { id }, new RowMapper<IndexVO>() {
			public IndexVO mapRow( ResultSet rs, int rowNum ) throws SQLException{
				IndexVO iv=new IndexVO();
				iv.setName(rs.getString("name"));
				iv.setEmail(rs.getString("email"));
				return iv;
			}//mapRow
		});
		
		gjt.closeAc();
		
		return iv;
	}//selUserInfo
	
	/**
	 * �������� �ֱ� ��� ���
	 * @return 
	 * @throws SQLException
	 */
	public List<String> selNoticeTitle() throws SQLException{
		List<String> title=null;
		
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt=gjt.getJdbcTemplate();
		
		StringBuilder select=new StringBuilder();
		select
		.append("	select title	")
		.append("	from (select rownum r_num, title	")
		.append("	from (select title	")
		.append("	from notice	")
		.append("	order by idx desc))	")
		.append("	where r_num between 1 and 10	");
		title=jt.query(select.toString(), new RowMapper<String>() {
			@Override
			public String mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getString("title");
			}
		});
		
		gjt.closeAc();
		
		return title;
	}//selNoticeTitle
	
	public List<String> selJobPostTitle() throws SQLException{
		List<String> company=null;
		
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt=gjt.getJdbcTemplate();
		
		StringBuilder select=new StringBuilder();
		select
		.append("	select company	")
		.append("	from (select rownum r_num, company	")
		.append("	from (select company	")
		.append("	from job_post	")
		.append("	order by idx desc))	")
		.append("	where r_num between 1 and 8	");
		company=jt.query(select.toString(), new RowMapper<String>() {
			@Override
			public String mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getString("company");
			}
		});
		
		gjt.closeAc();
		
		return company;
	}//selJobPostTitle
	
	
	
	
	
	
	public List<MemberVO> selectAllUser(String pw) throws SQLException{
		List<MemberVO> list=null;
		
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt=gjt.getJdbcTemplate();
		
		StringBuilder selectMember=new StringBuilder();
		selectMember
		.append("	select id, name, email	")
		.append("	from users	");
		
		//dynamic query
		if( pw != "" || pw != null ) {
			selectMember.append("	where password=?");
		}//end if
		
		if( pw == "" || pw == null ) {
			//��� ȸ�������� ��ȸ
			list=jt.query(selectMember.toString(), new SelectMember());
		} else {
			//��й�ȣ�� �´� ȸ�������� ��ȸ
			list=jt.query(selectMember.toString(), new Object[] { pw }, new SelectMember());
		}//end else
		
		//4.Spring Container �ݱ�
		gjt.closeAc();
		return list;
	}//selectAllUser
	
	/////////////// inner class : ȸ�������� ������ ������ Ŭ���� ���� /////////////////
	public class SelectMember implements RowMapper<MemberVO>{
		public MemberVO mapRow(ResultSet rs, int rowNum) throws SQLException {
			MemberVO mv=new MemberVO();
			mv.setId(rs.getString("id"));
			mv.setPassword(rs.getString("password"));
			mv.setName(rs.getString("name"));
			mv.setEmail(rs.getString("email"));
			mv.setInput_date(rs.getString("input_date"));
			return mv;
		}//mapRow
	}
	
}//class
