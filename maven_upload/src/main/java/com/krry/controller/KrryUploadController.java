package com.krry.controller;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts2.json.JSONException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.krry.util.UploadUtil;

/**
 * 文件上传类
 * KrryUploadController
 * @author krry
 * @version 1.0.0
 *
 */
@Controller
@RequestMapping("/upload")
public class KrryUploadController {
	
	//单文件上传
	@ResponseBody /*上传成功以后以response.getWriter()进入输出数据*/
	@RequestMapping(value = "/file")
	public String krryupload(@RequestParam("doc") MultipartFile file, HttpServletRequest request) throws IllegalStateException, IOException, JSONException{
		//调用工具类完成上传
		return UploadUtil.simUpload(file, request);
	}
	
}
