package kr.co.sist.user;

public class UpdatePwdVO {
	private String id, before_pass, new_pass;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getNew_pass() {
		return new_pass;
	}

	public void setNew_pass(String new_pass) {
		this.new_pass = new_pass;
	}

	public String getBefore_pass() {
		return before_pass;
	}

	public void setBefore_pass(String before_pass) {
		this.before_pass = before_pass;
	}
	
}
