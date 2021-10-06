<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CoronaZip</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster&effect=shadow-multiple">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=9617e5ff316756ebbb3a571e76b07bbb&libraries=clusterer"></script>
<script type="text/javascript"
src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="/smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<c:if test="${empty user }">
	<script type="text/javascript">
		alert("커뮤니티는 로그인 후에 이용할수있습니다.");
		history.go(-1);
	</script>
</c:if>
<style>
	.w3-lobster {
	  font-family: "Lobster", Sans-serif;
	}
	.nav {
	  color:#337ab7;
	  font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
	  font-size: 14px;
	}
	.footer{
	  border-top: 1px solid #ddd; 
	  margin: 20px 0; 
	  text-align: center;
	  color:#337ab7;
	  font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
	  padding-top: 10px;
	}
	
	.fileBox .fileName {
		display:inline-block;
		width:170px;
		height:30px;
		padding-left:10px;
		margin-right:5px;
		line-height:30px;
		border:1px solid #aaa;
		background-color:#fff;
		vertical-align:middle;
		border-radius: 10px;
	}
	.fileBox .btn_file {
		display:inline-block;
		border:2px solid #66677f;
		border-top-width: 0px;
		border-left-width: 0px;
		width:100px;
		height:30px;
		line-height:30px;
		text-align:center;
		vertical-align:middle;
		background-color: #3C3530;
		color:white;
		border-radius: 6px;
	}
	.fileBox input[type="file"] {
		position:absolute;
		width:1px;
		height:1px;
		padding:0;
		margin:-1px;
		overflow:hidden;
		clip:rect(0,0,0,0);
		border:0
	}
	 .fbtn{
	   display:inline-block;
		border:2px solid #66677f;
		border-top-width: 0px;
		border-left-width: 0px;
		width:50px;
		height:30px;
		line-height:30px;
		text-align:center;
		vertical-align:middle;
		background-color: #3C3530;
		color:white;
		border-radius: 6px;
	 }
</style>
</head>
<body>
	<div class="container">
	    <div style="margin-top: 10px;" class="w3-container w3-lobster">
	      <img src="img/파란마스크.png" alt="" width="60" height="">
	      <span><span style="color: #8fd5ff;" class="w3-xxlarge font-effect-shadow-multiple">CORONA</span><span style="font-size: 20px;">.ZIP</span></span>
	    </div>
	     <ul class="nav navbar-nav navbar-right">
      <c:if test="${empty user }">
	      <li><a href="/login"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
   		  <li><a href="/join"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
      </c:if>
      <c:if test="${not empty user }">
	      <span style="color: #717171;">[${user.vaccine }]${user.nickname } 님 반갑습니다.</span>
	      <span style="margin-right: 25px; margin-left: 7px;"><a href="/logout" style="text-decoration: none;">로그아웃</a></span>
      </c:if>
    </ul>
    <ul class="nav nav-tabs">
      <li><a href="/index"><i class='fas fa-home' style='font-size:15px'></i> Home</a></li>
      <li><a href="/center"><i class='fas fa-map-marker-alt' style='font-size:15px'></i> 예방접종센터</a></li>
      <li class="dropdown active">
        <a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class='fas fa-globe' style='font-size:15px'></i> 커뮤니티<span class="caret"></span></a>
        <ul class="dropdown-menu" style="color: #337ab7;">
          <li><a href="/board?b_type=0"><i class="fas fa-head-side-virus"></i> &nbsp;코로나 증상</a></li>
          <li><a href="/board?b_type=1"><i class="fas fa-comment-medical"></i> &nbsp;백신 후기</a></li>
          <li><a href="/board?b_type=2"><i class="fas fa-users"></i> &nbsp;자유게시판</a></li>                        
        </ul>
      </li>
      <c:if test="${not empty user }">
      <li class="dropdown">
        <a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class="fas fa-user-circle"></i> 마이페이지<span class="caret"></span></a>
        <ul class="dropdown-menu" style="color: #337ab7;">
          <li><a href="/update"><i class="fas fa-address-card"></i> &nbsp;정보수정</a></li>
          <li><a href="/msg"><i class="fas fa-envelope"></i> &nbsp;쪽지함</a></li>  
        </ul>
      </li>
      </c:if>
    </ul>
	
	<div style="margin: 30px 0px 90px 0px;">
		<h2 style="font-weight: bold; text-align: center;">글 작성</h2>
        <p style="color: #918f8f; text-align: center; margin-bottom: 20px;">글 내용에 맞는 게시판을 선택하여 글을 작성해주세요.</p>
		<form action="" method="post" id="frm" style="text-align: center; width: 80%; margin: 0 auto;">
			<div>
				<select name="b_type" style="width: 18%; height: 35px;">
					<c:if test="${b_type == 0 }"><option value="0" selected="selected">코로나 증상</option></c:if>
					<c:if test="${b_type == 1 }"><option value="1" selected="selected">백신 후기</option></c:if>
					<c:if test="${b_type == 2 }"><option value="2" selected="selected">자유게시판</option></c:if>
					<option value="0">코로나 증상</option>
					<option value="1">백신 후기</option>
					<option value="2">자유게시판</option>
				</select>
				<input type="text" name="b_title" placeholder="제목" style="width: 81%; height: 35px;">
			</div>
			<div style="float: right; margin: 5px 0px;">
				<div class="fileBox">
					<input type="text" class="fileName" readonly="readonly">
					<label for="uploadBtn" class="btn_file">파일 업로드</label>
					<input type="file" id="uploadBtn" class="uploadBtn" name="b_upload">
					<label class="fbtn" onclick="fdel()">제거</label>
				</div>
			</div>
			<div>
				<textarea id="b_content"  name="b_content" style="width: 100%;"></textarea>
			</div>
			<div style="float: right;"><input type="button" onclick="save();" value="작성" class="btn btn-info"></div>
		</form>

	
	</div>

	
	  <div class="footer">
	    <p>&copy copyright is reserved by 시작</p>
	    <a href="https://blog.naver.com/rladbtjq18" target="_blank " style="font-size: 17px;"><i class='fab fa-blogger' style='font-size:24px'></i> Blog</a>
	    <a href="https://github.com/start0ys" target="_blank " style="font-size: 17px; margin-left: 20px;"><i class='fab fa-github-square' style='font-size:24px'></i> Github</a>
	  </div>
	
	</div>
	
	
	<script type="text/javascript">
		var obj = {};
		$("select").children("option").each(function(){
		 let val = $(this).attr("value");
		 if(obj[val]){
		   if($(this).is(":selected")){
		    obj[val].remove();
		    obj[val] = $(this);
		   }else if(obj[val].is(":selected")){
		    $(this).remove()
		   }else{
		    $(this).remove();
		   }
		 }
		 obj[val] = $(this);
		});	
		
		var uploadFile = $('.fileBox .uploadBtn');
		uploadFile.on('change', function(){
			if(window.FileReader){
				var filename = $(this)[0].files[0].name;
			} else {
				var filename = $(this).val().split('/').pop().split('\\').pop();
			}
			$(this).siblings('.fileName').val(filename);
		});
		
		function fdel(){
		    $('.fileName').val('');
			var agent = navigator.userAgent.toLowerCase();
			//파일초기화
			if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
				$("#uploadBtn").replaceWith($("#uploadBtn").clone(true));
			}else{
			    $("#uploadBtn").val("");
			}	
		}
		
		var oEditors = [];
		nhn.husky.EZCreator.createInIFrame({
		    oAppRef: oEditors,
		    elPlaceHolder: "b_content",  //textarea ID 입력
		    sSkinURI: "/smarteditor/SmartEditor2Skin.html",  //martEditor2Skin.html 경로 입력
		    fCreator: "createSEditor2",
		    htParams : { 
		        bUseToolbar : true,           // 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
				bUseVerticalResizer : false,  // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
				bUseModeChanger : false       // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
		    }
		});
		
		var frm = document.getElementById("frm");
		function save(){
			oEditors.getById["b_content"].exec("UPDATE_CONTENTS_FIELD", []);  //스마트 에디터 값을 텍스트컨텐츠로 전달
			frm.submit(); // submit
			return; 
		}
	</script>
</body>
</html>