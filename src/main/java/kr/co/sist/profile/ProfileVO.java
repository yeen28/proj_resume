package kr.co.sist.profile;

public class ProfileVO {
	private int idx, tech_idx;
	private String gender, phone, description, url, input_date, img, id;

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int getTech_idx() {
		return tech_idx;
	}

	public void setTech_idx(int tech_idx) {
		this.tech_idx = tech_idx;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getInput_date() {
		return input_date;
	}

	public void setInput_date(String input_date) {
		this.input_date = input_date;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "ProfileVO [idx=" + idx + ", tech_idx=" + tech_idx + ", gender=" + gender + ", phone=" + phone
				+ ", description=" + description + ", url=" + url + ", input_date=" + input_date + ", img=" + img
				+ ", id=" + id + "]";
	}

}// class
