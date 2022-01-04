package kr.co.sist.admin;

public class UserVO {
	public String id, password, name, email, input_date;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getInput_date() {
		return input_date;
	}

	public void setInput_date(String input_date) {
		this.input_date = input_date;
	}

	public UserVO(String id, String password, String name, String email, String input_date) {
		this.id = id;
		this.password = password;
		this.name = name;
		this.email = email;
		this.input_date = input_date;
	}

	public UserVO() {
	}
	
}
