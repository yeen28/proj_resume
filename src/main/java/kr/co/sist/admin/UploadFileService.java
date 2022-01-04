package kr.co.sist.admin;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class UploadFileService {
	/**
	 * upload������ �����ϴ� ������ ��� ��ȸ
	 * @return
	 */
	public UploadFileVO searchFileList(int idx){
		UploadFileVO list=new UploadFileVO();
		
		//1. ���ϸ���Ʈ�� ������ ������ �����Ѵ�.
		File temp=new File("C:/Users/user/git/sist_prj2_resume/sist_resume/src/main/webapp/upload");
		//2. �ش� ������ ��� ����, ���丮�� ��´�.
		//File[] listFiles=temp.listFiles();
		
		UploadFileVO ufVO=null;
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd a HH:mm:ss");
		//for( File file : listFiles ) {
		//3. ���Ͽ� ���ؼ��� ������ ��´�.
			if( temp.isFile() ) {
				ufVO=new UploadFileVO();
			//4. ���� ������ VO�� �Ҵ�
				ufVO.setFileName( temp.getName() );
				ufVO.setFileLen( temp.length() );
				ufVO.setLastModified(sdf.format(new Date(temp.lastModified())));
			}//end if
		//} //end for
		
		return list;
	}//searchFileList
}
