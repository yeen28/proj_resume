package kr.co.sist.dao;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 * Spring JDBC�� ����Ͽ� DBMS �۾��� �ϱ� ���� JdbcTemplate�� ��ȯ�ϴ� ��.
 * @author user
 */
public class GetJdbcTemplate {
	private static GetJdbcTemplate gjt;
	
	private GetJdbcTemplate() {
	}//GetJdbcTemplate
	
	public static GetJdbcTemplate getInstance() {
		if( gjt == null ) {
			gjt=new GetJdbcTemplate();
		}//end if
		
		return gjt;
	}//getInstance
	
	private ApplicationContext ac;
	private ApplicationContext getAc() {
		//ac�� ��ü�� �����Ǿ����� �ʾҰų�(null), ac�� Ȱ��ȭ ���°� �ƴ϶��
		if( ac == null || (ac != null && !((ClassPathXmlApplicationContext)ac).isActive()) ) {
			//Spring Container�� �������ش�. (�̷��� ���Ӽ��� ������ ��� �� �� �ִ�.)
			ac=new ClassPathXmlApplicationContext("kr/co/sist/dao/applicationContext.xml");
		}//end if
		return ac;
	}//getAc
	
	/**
	 * DBCP ����� DBMS �۾��� �����ϴ� org.springframework.jdbc.core.JdbcTemplate Ŭ������ ��ü�� ��ȯ�ϴ� ���� �Ѵ�.
	 * @return
	 */
	public JdbcTemplate getJdbcTemplate() {
		JdbcTemplate jt=null;
		ApplicationContext ac=getAc();
		
		jt=ac.getBean(JdbcTemplate.class);
		
		return jt;
	}//getJdbcTemplate
	
	public void closeAc() {
		//Spring Container���� �޸� ������ �߻����� �ʵ��� �ݾ��ش�.
		if( ac != null ) {
			((ClassPathXmlApplicationContext)ac).close();
			ac=null;
		}//end if
	}//closeAc
	
}//class
