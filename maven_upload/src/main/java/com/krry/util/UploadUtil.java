package com.krry.util;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.struts2.json.JSONException;
import org.apache.struts2.json.JSONUtil;
import org.springframework.web.multipart.MultipartFile;


/**
 * 文件上传类
 * UploadUtil
 * @author krry
 * @version 1.0.0
 *
 */
public class UploadUtil {
	
	public static String simUpload(MultipartFile file, HttpServletRequest request) 
			throws IllegalStateException, IOException, JSONException{
		
		if(!file.isEmpty()){
			String path = request.getSession().getServletContext().getRealPath("/upload");
			
			//定义文件
			File parent = new File(path);
			if(!parent.exists()) parent.mkdirs();
			
			HashMap<String, Object> map = new HashMap<String,Object>();
			
			String oldName = file.getOriginalFilename();
			
			long size = file.getSize();
			
			//使用TmFileUtil文件上传工具获取文件的各种信息
			//优化文件大小
			String sizeString = TmFileUtil.countFileSize(size);
			//获取文件后缀名
			String ext = TmFileUtil.getExtNoPoint(oldName);
			//随机重命名，10位时间字符串
			String newFileName = TmFileUtil.generateFileName(oldName, 10, "yyyyMMddHHmmss");
			
			String url = "upload/"+newFileName;
			
			//文件传输，parent文件
			file.transferTo(new File(parent, newFileName));
			
			map.put("oldname",oldName);//文件原名称
			map.put("ext",ext);
			map.put("size",sizeString);
			map.put("name",newFileName);//文件新名称
			map.put("url",url);
			
			//以json方式输出到页面
			return JSONUtil.serialize(map);
		}else{
			return null;
		}
	}
	
	/**
	 * 批量上传工具类
	 * com.krry.uitl 
	 * 方法名：uploadFiles
	 * @author krry 
	 * @param request
	 * @param response
	 * @return HashMap<String,Object>
	 * @exception 
	 * @since  1.0.0
	 */
	public static HashMap<String, Object> uploadFiles(HttpServletRequest request,HttpServletResponse response){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		String fileName;
		
		try {
			//设置编码集
			request.setCharacterEncoding("utf-8");
			response.setContentType("html/text;charset=utf-8");
			
			//获取文件上传的目录
			String realPath = request.getRealPath("/");
			//定义上传目录
			String dirPath = realPath+"/upload";
			
			File dirFile = new File(dirPath);
			//如果此文件夹不存在
			if(!dirFile.exists()){
				dirFile.mkdirs();//创建此文件夹
			}
			
			//上传操作
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			
			List items = upload.parseRequest(request);
			if(null != items){
				Iterator itr = items.iterator();
				while(itr.hasNext()){
					FileItem item = (FileItem) itr.next();
					if(item.isFormField()){
						continue;
					}else{
						//获取文件名
						String name = item.getName();
						//从后面往前找.
						int i = name.lastIndexOf(".");
						//截取文件格式名
						String ext = name.substring(i, name.length());
						
						//文件重命名
						fileName = new Date().getTime() + ext;
						File saveFile = new File(dirPath,fileName);
						//上传文件
						item.write(saveFile);
						
						//格式化时间类型
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						String nowTime = sdf.format(new Date());
						
						map.put("oldname", item.getName());
						map.put("newName", fileName);
						map.put("url", "upload/"+fileName);
						map.put("size", format(item.getSize()));
						map.put("time", nowTime);
					}
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return map;
		
	}
	/**
	 * 将文件的字节数转换成文件的大小
	 * com.krry.uitl 
	 * 方法名：format
	 * @author krry 
	 * @param size
	 * @return String
	 * @exception 
	 * @since  1.0.0
	 */
	public static String format(long size){
		float fsize = size;
		String fileSizeString;
		if (fsize < 1024) {
			fileSizeString = String.format("%.2f", fsize) + "B"; //2f表示保留两位小数
		} else if (fsize < 1048576) {
			fileSizeString = String.format("%.2f", fsize/1024) + "KB";
		} else if (fsize < 1073741824) {
			fileSizeString = String.format("%.2f", fsize/1024/1024) + "MB";
		} else if (fsize < 1024 * 1024 * 1024) {
			fileSizeString = String.format("%.2f", fsize/1024/1024/1024) + "GB";
		} else {
			fileSizeString = "0B";
		}
		return fileSizeString;
	}
}






