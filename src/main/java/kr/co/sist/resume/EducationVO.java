package kr.co.sist.resume;

public class EducationVO {

	private int idx;
	private double score, max_score;
	private String univ, major, degree, ent, grad, description, id;

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public double getScore() {
		return score;
	}

	public void setScore(double score) {
		this.score = score;
	}

	public double getMax_score() {
		return max_score;
	}

	public void setMax_score(double max_score) {
		this.max_score = max_score;
	}

	public String getUniv() {
		return univ;
	}

	public void setUniv(String univ) {
		this.univ = univ;
	}

	public String getMajor() {
		return major;
	}

	public void setMajor(String major) {
		this.major = major;
	}

	public String getDegree() {
		return degree;
	}

	public void setDegree(String degree) {
		this.degree = degree;
	}

	public String getEnt() {
		return ent;
	}

	public void setEnt(String ent) {
		this.ent = ent;
	}

	public String getGrad() {
		return grad;
	}

	public void setGrad(String grad) {
		this.grad = grad;
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
		return "EducationVO [idx=" + idx + ", score=" + score + ", max_score=" + max_score + ", univ=" + univ
				+ ", major=" + major + ", degree=" + degree + ", ent=" + ent + ", grad=" + grad + ", description="
				+ description + ", id=" + id + "]";
	}

}
