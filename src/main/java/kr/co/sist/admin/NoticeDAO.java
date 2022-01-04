package kr.co.sist.admin;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.sist.dao.GetJdbcTemplate;

public class NoticeDAO {

	/**
	 * 공지사항 목록 전체조회
	 * @param idx
	 * @return 번호, 제목, 입력일
	 * @throws SQLException
	 */
	public List<NoticeVO> selectAllNotice() throws SQLException {
		List<NoticeVO> list = null;
		
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt = gjt.getJdbcTemplate();
		
		StringBuilder selectNotice = new StringBuilder();
		
		selectNotice
		.append("select idx, title, input_date  ")
		.append("from notice ");
		
		list = jt.query(selectNotice.toString(), new SelectNotice());
		
		gjt.closeAc();
		
		return list;
	}//selectAllNotice
	
	public class SelectNotice implements RowMapper<NoticeVO> {
		public NoticeVO mapRow(ResultSet rs, int rowNum) throws SQLException {
			NoticeVO nv = new NoticeVO();
			
			nv.setIdx(rs.getInt("idx"));
			nv.setTitle(rs.getString("title"));
			nv.setInput_date(rs.getString("input_date"));
			
			return nv;
		}
	}//SelectNotice
	
	/**
	 * 공지사항 메인 페이지에서 보여줄 정보 조회 (페이지네이션)
	 * @param begin
	 * @param end
	 * @return 번호, 제목, 입력일
	 * @throws SQLException
	 */
	public List<NoticeVO> selAllTitle(int begin, int end) throws SQLException {
		List<NoticeVO> list=null;
		
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt=gjt.getJdbcTemplate();
		
		StringBuilder select=new StringBuilder();
		select
		.append("	select idx,title, input_date,count	")
		.append("	from (select rownum r_num, idx,title,input_date,count	")
		.append("			from (select idx,title,to_char(input_date,'yyyy-MM-dd') input_date,count	")
		.append("					from notice	")
		.append("					order by idx desc) )	")
		.append("	where r_num between ? and ?	");
		list=jt.query(select.toString(), new Object[] { begin, end }, new RowMapper<NoticeVO>() {
			public NoticeVO mapRow(ResultSet rs, int rowNum) throws SQLException {
				NoticeVO nv=new NoticeVO();
				nv.setIdx(rs.getInt("idx"));
				nv.setTitle(rs.getString("title"));
				nv.setInput_date(rs.getString("input_date"));
				nv.setCount(rs.getInt("count"));
				return nv;
			}
		});
		
		gjt.closeAc();
		
		return list;
	}//selAllTitle
	
	/**
	 * 공지사항 추가
	 * @param anv
	 * @throws SQLException
	 */
	public void insertNotice(AddNoticeVO anv) throws SQLException {
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt = gjt.getJdbcTemplate();
		
		String selectNotice="insert into notice(idx,title,description,input_date,count,id) values(notice_seq.nextval,?,?,sysdate,0,?)";
		
		jt.update(selectNotice, new Object[] { anv.getTitle(), anv.getDescription(), anv.getId() });
		
		gjt.closeAc();
	}//insertNotice
	
	/**
	 * 공지사항 수정을 위한 select
	 * @param idx
	 * @return 제목, 내용
	 * @throws SQLException
	 */
	public UpdateNoticeVO selEditNotice(int idx) throws SQLException {
		UpdateNoticeVO unv=new UpdateNoticeVO();
		
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt = gjt.getJdbcTemplate();
		
		String select="select title,description from notice where idx=?";
		
		unv=jt.queryForObject(select, new Object[] { idx }, new RowMapper<UpdateNoticeVO>() {
			public UpdateNoticeVO mapRow(ResultSet rs, int rowNum) throws SQLException {
				UpdateNoticeVO unv=new UpdateNoticeVO();
				unv.setTitle(rs.getString("title"));
				unv.setDescription(rs.getString("description"));
				return unv;
			}//mapRow
		});
		
		gjt.closeAc();
		
		return unv;
	}//selEditNotice
	
	/**
	 * 공지사항 수정
	 * @param unv
	 * @throws SQLException
	 */
	public void updateNotice(UpdateNoticeVO unv) throws SQLException {
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt = gjt.getJdbcTemplate();
		
		String update="update notice set title=?,description=? where idx=?";
		
		jt.update(update, new Object[] { unv.getTitle(), unv.getDescription(), unv.getIdx() });
		
		gjt.closeAc();
	}//updateNotice
	
	/**
	 * 공지 상세페이지
	 * @param anv
	 * @throws SQLException
	 */
	public NoticeVO selectDetail(int idx) throws SQLException {
		NoticeVO nv=new NoticeVO();
		
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt = gjt.getJdbcTemplate();
		
		String select="select idx,title,description,input_date,count,id from notice where idx=?";
		
		nv=jt.queryForObject(select, new Object[] { idx }, new RowMapper<NoticeVO>() {
			public NoticeVO mapRow(ResultSet rs, int rowNum) throws SQLException {
				NoticeVO nv=new NoticeVO();
				nv.setIdx(rs.getInt("idx"));
				nv.setTitle(rs.getString("title"));
				nv.setDescription(rs.getString("description"));
				nv.setInput_date(rs.getString("input_date"));
				nv.setCount(rs.getInt("count"));
				nv.setId(rs.getString("id"));
				return nv;
			}
		});
		
		gjt.closeAc();
		
		return nv;
	}//selectDetail
	
	/**
	 * 공지사항 삭제
	 * @param idx
	 * @throws SQLException
	 */
	public void delNotice(int idx) throws SQLException {
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		
		JdbcTemplate jt = gjt.getJdbcTemplate();
		
		String delete="delete from notice where idx=?";
		
		jt.update(delete, new Object[] { idx });
		
		gjt.closeAc();
	}//delNotice
	
}
