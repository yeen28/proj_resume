package kr.co.sist.admin;

import kr.co.sist.util.img.ImageResize;

public class Resize {
	public void resize(String img) {
		ImageResize.resizeImage("C:/Users/user/git/sist_prj2_resume/sist_resume/src/main/webapp/upload/"+img, 600, 240);
	}
}

