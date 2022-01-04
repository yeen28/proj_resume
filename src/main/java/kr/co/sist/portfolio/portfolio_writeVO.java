package kr.co.sist.portfolio;

public class portfolio_writeVO {
	private int idx;
	private String proj_title, date_year, team, description, url_link, id;
	
	public portfolio_writeVO() {
		
	}
	
	public portfolio_writeVO(int idx, String proj_title, String date_year, String team, String description, String id) {
		this.idx = idx;
		this.proj_title = proj_title;
		this.date_year = date_year;
		this.team = team;
		this.description = description;
		this.id = id;
	}

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

	public String getUrl_link() {
		return url_link;
	}

	public void setUrl_link(String url_link) {
		this.url_link = url_link;
	}	
	
}//class
