package kr.co.sist.admin;

public class MainVO {
	
	private int idx,career;
	private String company,img,address,description,input_date,id,homepage;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getCareer() {
		return career;
	}
	public void setCareer(int career) {
		this.career = career;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getInput_date() {
		return input_date;
	}
	public void setInput_date(String input_date) {
		this.input_date = input_date;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getHomepage() {
		return homepage;
	}
	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}
	@Override
	public String toString() {
		return "MainVO [idx=" + idx + ", career=" + career + ", company=" + company + ", img=" + img + ", address="
				+ address + ", description=" + description + ", input_date=" + input_date + ", id=" + id + ", homepage="
				+ homepage + "]";
	}
	
}//class
