<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</style>
</head>
<body>
	<div class="container">
	    <div style="margin-top: 10px;" class="w3-container w3-lobster">
	      <img src="img/파란마스크.png" alt="" width="60" height="">
	      <span><span style="color: #8fd5ff;" class="w3-xxlarge font-effect-shadow-multiple">CORONA</span><span style="font-size: 20px;">.ZIP</span></span>
	    </div>
	    <ul class="nav navbar-nav navbar-right">
	        <li><a href="#"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
	        <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
	    </ul>
	    <ul class="nav nav-tabs">
	        <li><a href="/"><i class='fas fa-home' style='font-size:15px'></i> Home</a></li>
	        <li><a href="#"><i class='fas fa-map-marker-alt' style='font-size:15px'></i> 예방접종센터</a></li>
	        <li class="dropdown">
	            <a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class='fas fa-globe' style='font-size:15px'></i> 커뮤니티<span class="caret"></span></a>
	            <ul class="dropdown-menu">
	                <li><a href="#">코로나 증상</a></li>
	                <li><a href="#">백신 후기</a></li>
	                <li><a href="#">자유게시판</a></li>                          
	            </ul>
	        </li>
	        <li><a href="#"><i class='far fa-envelope' style='font-size:15px'></i> 쪽지함</a></li>
	    </ul>
	
	  <div style="text-align: center; margin-top: 30px;">
	    <form action="">
	        <table>
	          <tr><td>이름</td><td><input type="text"></td></tr>
	          <tr><td>생년월일</td><td><input type="text"></td></tr>
	          <tr><td>아이디</td><td><input type="text"></td></tr>
	          <tr><td>비밀번호</td><td><input type="text"></td></tr>
	          <tr><td>비밀번호 확인</td><td><input type="text"></td></tr>
	          <tr><td>닉네임</td><td><input type="text"></td></tr>
	          <tr><td>성별</td><td><input type="text"></td></tr>
	          <tr><td>이메일</td><td><input type="text"></td></tr>
	          <tr><td>주소</td><td><input type="text"></td></tr>
	          <tr><td>상세주소</td><td><input type="text"></td></tr>
	          <tr><td>백신유무</td><td><input type="text"></td></tr>
	          <tr>
	            <td>
	              <button type="submit" class="btn btn-info">가입</button>
	            </td>
	          </tr>
	          </table>
	    </form>
	  </div>
	
	
	  <div class="footer">
	    <p>&copy copyright is reserved by 시작</p>
	    <a href="https://blog.naver.com/rladbtjq18" target="_blank " style="font-size: 17px;"><i class='fab fa-blogger' style='font-size:24px'></i> Blog</a>
	    <a href="https://github.com/start0ys" target="_blank " style="font-size: 17px; margin-left: 20px;"><i class='fab fa-github-square' style='font-size:24px'></i> Github</a>
	  </div>
	
	</div>
</body>
</html>