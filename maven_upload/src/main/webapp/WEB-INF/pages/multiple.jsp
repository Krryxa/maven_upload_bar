<%@page import="org.apache.struts2.json.JSONUtil"%>
<%@page import="com.krry.util.UploadUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	/*每成功上传一个文件就调用，批量上传，多次调用*/
	HashMap<String,Object> map = UploadUtil.uploadFiles(request, response);
	out.print(JSONUtil.serialize(map));
%>