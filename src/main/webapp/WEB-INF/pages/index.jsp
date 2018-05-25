<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+path+"/";
	pageContext.setAttribute("basePath", basePath);
%>
<!DOCTYPE HTML>
<html>
  <head>
  	<title>文件上传（进度条）</title>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<meta name="keywords" content="keyword1,keyword2,keyword3">
	<meta name="description" content="This is my page">
	<link rel="stylesheet" href="${basePath}/resource/js/upload/upload.css"/>
	<link type="text/css" rel="stylesheet" href="${basePath}/resource/sg/css/sg.css"/>
	<style>
		*{padding: 0;margin:0}
		ul,li{list-style:none;}
		a{color:#333;text-decoration: none;}
		.hidden{display:hidden;}
		input{border:0;outline:0;}
		.clear{clear:both;}
		body{font-size:14px;font-family: "微软雅黑";background:#333}
		.container{width:1080px;margin:80px auto;}
		
		.formbox{float:left;text-align:center;width:300px;}
		.title{color:#fff;font-size:24px;margin-bottom:20px;}
		.formbox .f_btn{width:100px;height:40px;background:#0c0;color:#fff;font-size:14px;font-family:"微软雅黑";cursor:pointer;font-weight:bold;}
		.massage p{color:#fff;text-align:left;}
		.sinimg{width:300px;height:300px;line-height:300px;color:#fff;}

		.formmutibox{float:left;width: 424px;margin: 0 28px 0;text-align:center;}
		.formmutibox .title{color:#fff;font-size:24px;margin-bottom:20px;}
		.formmutibox .f_btn{width:100px;height:40px;background:#0c0;color:#fff;font-size:14px;font-family:"微软雅黑";cursor:pointer;font-weight:bold;}
		.files table td{color:#fff;width:135px;}

		#box{width:300px;text-align:center;float:right;color:#fff;position:relative;}
		#box ul{background:#fff;height:200px;position:relative;z-index: 2}
		#box ul li{float:left;height:56px;width:96px;margin:10px 5px 0px 0;}
		#box ul li:nth-child(3n){margin-right:0px;}
		#box ul li img{height:50px;width:75px;}
		#box .uppadbox{height:235px;background:#eaeaea;position:relative;z-index: 2;}
		#box .uppadbox h3{line-height: 235px;font-size:24px;color:#c5c5c5;text-shadow: 1px 1px 1px #999;}
		#box .uppadbox p{color:#c5c5c5}

	</style>
  </head>
  <body>
  	<div class="container">
		<!--单文件上传-->
		<div class="formbox">
			<p class="title">单个文件上传</p>
			<input type="file" style="display:none;" id="fileupone" name="fileup" accept="image/jpeg,image/png" onchange="uploadFile(this)"/>
			<input type="button" class="f_btn" id="singleup" value="上传图片">
			<div class="massage">
				<p>文件名：<span class="filename"></span></p>
				<p>大小：<span class="filesize"></span></p>
				<p>文件格式：<span class="fileext"></span></p>
				<p>预览：</p>
				<div class="sinimg">
					预览图
				</div>
			</div>
		</div>
		
		<!--多文件上传-->
		<div class="formmutibox">
			<p class="title">多个文件上传</p>
			<input type="file" style="display:none;" id="fileup" name="fileup" accept="image/jpeg,image/png" onchange="uploadFile(this)" />
			<input type="button" class="f_btn" id="upload_btn" value="上传图片">
			
			<!--files start-->
			<div class="files">
				<table>
					<thead>
						<tr>
							<td class="filelook2">文件预览</td>
							<td class="filename2">文件名</td>
							<td class="filesize2">大小</td>
						</tr>
					</thead>
					<tbody id="f_tbody">
					</tbody>
				</table>
			</div>
		</div>
	
		<!--拖拽上传-->
	  	<div id="box">
	  		<p class="title">拖拽上传</p>
	  		<ul>
	  			<li><img src="${basePath}/resource/images/1.jpg" width="75" height="75"/></li>
	  			<li><img src="${basePath}/resource/images/2.jpg" width="75" height="75"/></li>
	  			<li><img src="${basePath}/resource/images/3.jpg" width="75" height="75"/></li>
	  			<li><img src="${basePath}/resource/images/4.jpg" width="75" height="75"/></li>
	  			<li><img src="${basePath}/resource/images/5.jpg" width="75" height="75"/></li>
	  			<li><img src="${basePath}/resource/images/6.jpg" width="75" height="75"/></li>
	  			<li><img src="${basePath}/resource/images/7.jpg" width="75" height="75"/></li>
	  			<li><img src="${basePath}/resource/images/8.jpg" width="75" height="75"/></li>
	  			<li><img src="${basePath}/resource/images/9.jpg" width="75" height="75"/></li>
	  		</ul>
	  		<div class="uppadbox" id="file_uploadarea">
	  			<h3 onselectstart="return false">将文件拖放该区域</h3>
	  		</div>
	  	</div>
	  	<div class="clear"></div>
	</div>
  	
  	<script type="text/javascript" src="${basePath}/resource/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="${basePath}/resource/js/krry_upload.js"></script>
	<script type="text/javascript" src="${basePath}/resource/js/upload/krry_upload.js"></script>
	<script type="text/javascript" src="${basePath}/resource/sg/tz_util.js"></script>
	<script type="text/javascript" src="${basePath}/resource/sg/sg.js"></script>
	<script type="text/javascript">var basePath = "${basePath}";</script>
  	<script type="text/javascript">
  		
  		var closeupload = true;
  		//点击单文件上传
		$("#singleup").click(function(){
			if(closeupload){
				$("#fileupone").click();
			}else{
				$.tzAlert({content:"请等待文件上传成功后",title:"Krry的温馨提示"});
			}
		});
		
  		//成功上传文件的方法
		function krry_uploadsuccess(jdata){
			closeupload = true; //解锁
			$("#aspupload").animate({"height":0},function(){
				$(this).remove();
			});
			$("#file_uploadarea h3").text("将文件拖放该区域");
			$(".filename").text(jdata.oldname);
			$(".filesize").text(jdata.size);
			$(".fileext").text(jdata.ext);
			var imgString = "<img alt='预览图' src='"+jdata.url+"' width='300'>";
			$(".sinimg").html(imgString);
			loading("图片上传完毕",3);
		}

		//拖拽图片的上传
		var krryDragUpload = {
			init:function(){
			  	//鼠标拖离事件
			  	document.ondragleave = function(e){
			  		e.preventDefault();//阻止浏览器的默认行为
			  	};
			  	
			  	//拖放后事件
			  	document.ondrop = function(e){
			  		e.preventDefault();//阻止浏览器的默认行为
			  	};
			  	//鼠标拖动按下去的时候
			  	document.ondragover = function(e){
			  		e.preventDefault();
			  	};
			  	//鼠标拖动按下去的时候
			  	document.ondragenter = function(e){
			  		e.preventDefault();
			  	};
			  	
			  	var fileboxDom = document.getElementById("file_uploadarea");
		  		fileboxDom.ondragenter = function(){
					$("#file_uploadarea h3").text("松开，上传文件");
		  		};
		  		
		  		fileboxDom.ondragleave = function(){
		  			$("#file_uploadarea h3").text("将文件拖放该区域");
		  		};
				//在内部移动的时候，阻止默认行为
				fileboxDom.ondragover = function(e){
					e.preventDefault();
				};
				fileboxDom.addEventListener("drop",function(e){
					//调用上传文件的方法
					uploadFile(e.dataTransfer);
				});
			},
		};
		//拖拽图片的上传
		krryDragUpload.init();
		
		//多个文件的上传，可选择单文件和一次性选择多文件上传
		$.tmUpload({
			btnId:"upload_btn",
			url:"/maven_upload/multiple.jsp",
			limitSize:"10 MB",
			btnImage: "resource/js/upload/btn_wj.jpg",//对应的上传图标
			fileTypes:"*.jpg;*.gif;*.png",
			multiple : true, //true表示可选多文件，false表示单文件上传
			callback:function(serverData,file){
				var jsonData = eval("("+serverData+")");//eval函数里面必须是个小括号，能把String类型转变成json对象

				$("#f_tbody").append("<tr class='f_item'>"+
									"<td><img src='"+jsonData.url+"' alt='预览图像' width='40' height='40' /></td>"+
									"<td>"+jsonData.oldname+"</td>"+
									"<td>"+jsonData.size+"</td>"
								);
			}
			
		});	
		

  	</script>
  </body>
</html>
