package kr.co.sist.notice;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.sist.dao.GetJdbcTemplate;

public class NoticeDAO {

	public List<NoticeVO> selectAllNotice() throws SQLException {
		List<NoticeVO> list = null;

		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();

		String selectNotice = "select idx,title,input_date,count,id from notice order by idx desc";
		list = jt.query(selectNotice, new RowMapper<NoticeVO>() {

			@Override
			public NoticeVO mapRow(ResultSet rs, int rowCnt) throws SQLException {
				NoticeVO nVO = new NoticeVO();

				nVO.setIdx(rs.getInt("idx"));
				nVO.setTitle(rs.getString("title"));
				nVO.setInput_date(rs.getString("input_date"));
				nVO.setCount(rs.getInt("count"));
				nVO.setId(rs.getString("id"));

				return nVO;
			}

		});

		gjt.closeAc();

		return list;
	}
	
	public List<NoticeVO> selectAllNotice(int begin, int end) throws SQLException {
		List<NoticeVO> list = null;
		
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		JdbcTemplate jt=gjt.getJdbcTemplate();
		
		StringBuilder selectNotice=new StringBuilder();
		selectNotice
		.append("	select idx, title, input_date,count,id	" )
		.append("	from (select rownum r_num, idx, title,input_date,count,id	")
		.append("	from (select idx, title,to_char(input_date,'yyyy-MM-dd') input_date,count,id	")
		.append("	from notice	")
		.append("	order by idx desc))	")
		.append("	where r_num between ? and ?	");
		
		list=jt.query(selectNotice.toString(), new Object[] { begin, end }, new RowMapper<NoticeVO>() {

			@Override
			public NoticeVO mapRow(ResultSet rs, int rowCnt) throws SQLException {
				NoticeVO nVO = new NoticeVO();
				nVO.setIdx(rs.getInt("idx"));
				nVO.setTitle(rs.getString("title"));
				nVO.setInput_date(rs.getString("input_date"));
				nVO.setCount(rs.getInt("count"));
				nVO.setId(rs.getString("id"));
				return nVO;
			}
		});
		
		gjt.closeAc();
		
		return list;
		
	}//selectAllportfolio

	public NoticeVO selectNotice(int idx) {
		NoticeVO nVO = new NoticeVO();

		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();
		
		String updateCnt = "update notice set count = (count + 1) where idx = ?";
		jt.update(updateCnt, idx);

		String selectQuery = "select * from notice where idx = ?";

		nVO = jt.queryForObject(selectQuery, new Object[] { Long.valueOf(idx) }, new RowMapper<NoticeVO>() {

			@Override
			public NoticeVO mapRow(ResultSet rs, int rowCnt) throws SQLException {
				NoticeVO nVO = new NoticeVO();

				nVO.setIdx(rs.getInt("idx"));
				nVO.setTitle(rs.getString("title"));
				nVO.setDescription(rs.getString("description"));
				nVO.setInput_date(rs.getString("input_date"));
				nVO.setCount(rs.getInt("count"));
				nVO.setId(rs.getString("id"));

				return nVO;
			}

		});
		
		gjt.closeAc();

		return nVO;
	}

}