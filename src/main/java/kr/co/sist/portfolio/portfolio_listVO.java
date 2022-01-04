package kr.co.sist.portfolio;

public class portfolio_listVO {
	private int idx;
	private String proj_title, date_year, team, description, id;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getProj_title() {
		return proj_title;
	}
	public void setProj_title(String proj_title) {
		this.proj_title = proj_title;
	}
	public String getDate_year() {
		return date_year;
	}
	public void setDate_year(String date_year) {
		this.date_year = date_year;
	}
	public String getTeam() {
		return team;
	}
	public void setTeam(String team) {
		this.team = team;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	@Override
	public String toString() {
		return "portfolio_a_VO [idx=" + idx + ", proj_title=" + proj_title + ", date_year=" + date_year + ", team="
				+ team + ", description=" + description + ", id=" + id + "]";
	}	

}//class