package kr.co.sist.profile;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.sist.dao.GetJdbcTemplate;

public class ProfileDAO {

	/**
	 * insert와 update를 판단해서 실행
	 * @param pVO
	 * @return
	 * @throws DataAccessException
	 */
	public int updateProfile(ProfileVO pVO) throws DataAccessException {
		int cnt = 0;
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();
		
		if(pVO.getIdx() == 0) {
			String insertProfile = "insert into profile(idx,gender,phone,description,url,img,input_date,tech_idx,id) values(profile_seq.nextval,?,?,?,?,?,sysdate,?,?)";
			jt.update(insertProfile, pVO.getGender(), pVO.getPhone(), pVO.getDescription(), pVO.getUrl(), pVO.getImg(),
					pVO.getTech_idx(), pVO.getId());
		} else {
			String updataProfile = "update profile set phone=?,description=?,url=?,img=?,tech_idx=?, gender=? where id=?";
			cnt = jt.update(updataProfile, pVO.getPhone(), pVO.getDescription(), pVO.getUrl(), pVO.getImg(),
					pVO.getTech_idx(), pVO.getGender(), pVO.getId());
		}
		
		gjt.closeAc();
		
		return cnt;
	}// updateProfile
	
	public ProfileVO selProfile(String id) throws DataAccessException {
		ProfileVO pv = new ProfileVO();

		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();

		String select = "select gender,phone,description,url,img,tech_idx, idx from profile where id=?";
		pv = jt.queryForObject(select, new Object[] { id }, new RowMapper<ProfileVO>() {
			public ProfileVO mapRow(ResultSet rs, int rowNum) throws SQLException {
				ProfileVO pv = new ProfileVO();
				pv.setGender(rs.getString("gender"));
				pv.setPhone(rs.getString("phone"));
				pv.setDescription(rs.getString("description"));
				pv.setUrl(rs.getString("url"));
				pv.setImg(rs.getString("img"));
				pv.setTech_idx(rs.getInt("tech_idx"));
				pv.setIdx(rs.getInt("idx"));
				return pv;
			}
		});

		gjt.closeAc();

		return pv;
	}// updateProfile
	
	public List<TechVO> selectTech() throws DataAccessException {

		List<TechVO> list = null;

		// 스프링 컨데이터 얻기
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();

		// JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();

		// 쿼리 실행
		String select = "select idx,subject from tech_stack";
		list = jt.query(select, new RowMapper<TechVO>() {
			public TechVO mapRow(ResultSet rs, int rowNum) throws SQLException {
				TechVO tv = new TechVO();
				tv.setIdx(rs.getInt("idx"));
				tv.setSubject(rs.getString("subject"));
				return tv;
			}
		});

		gjt.closeAc();

		return list;
	}// selectTech

	public List<String> selectUserTech(int idx) throws DataAccessException, SQLException {
		List<String> list = null;

		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		JdbcTemplate jt = gjt.getJdbcTemplate();

		String selQuery = "select subject from tech_stack where idx = ?";
		list = jt.query(selQuery, new Object[] { idx }, new RowMapper<String>() {

			@Override
			public String mapRow(ResultSet rs, int rowCnt) throws SQLException {
				String subject = "";

				subject = rs.getString("subject");

				return subject;
			}

		});

		return list;
	}

}// class