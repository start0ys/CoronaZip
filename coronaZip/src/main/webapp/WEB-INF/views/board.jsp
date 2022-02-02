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
	a{
		text-decoration: none;
		color:black;
	}
	th{ 
    	background-color:#6c6b6b;
    	border-top:solid 2px #aaaaaa;
    	color: white;
    	text-align: center;
	}
	tr{
		height:30px; 
	}
	td{
		border-bottom:solid 1px #dddddd;
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
	      <span style="margin-right: 25px; margin-left: 7px;"><a href="/logout" style="text-decoration: none; color: #337ab7;">로그아웃</a></span>
      </c:if>
    </ul>
    <ul class="nav nav-tabs">
      <li><a href="/index" style="color: #337ab7;"><i class='fas fa-home' style='font-size:15px'></i> Home</a></li>
      <li><a href="/center" style="color: #337ab7;"><i class='fas fa-map-marker-alt' style='font-size:15px'></i> 예방접종센터</a></li>
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
        <a class="dropdown-toggle" data-toggle="dropdown" href="#" style="color: #337ab7;"><i class="fas fa-user-circle"></i> 마이페이지<span class="caret"></span></a>
        <ul class="dropdown-menu" style="color: #337ab7;">
          <li><a href="/update"><i class="fas fa-address-card"></i> &nbsp;정보수정</a></li>
          <li><a href="/msg"><i class="fas fa-envelope"></i> &nbsp;쪽지함</a></li>  
        </ul>
      </li>
      </c:if>
    </ul>
	
	<div>
		<div style="margin: 37px 0px; text-align: center;">
			<c:if test="${b_type == 0 }">
				<h2 style="font-weight: bold;"><i class="fas fa-head-side-virus"></i> &nbsp;코로나 증상</a></h2>
				<p style="color: #918f8f;">코로나 증상에 대하여 회원들과 정보를 공유해보세요.</p>
			</c:if>
			<c:if test="${b_type == 1 }">
				<h2 style="font-weight: bold;"><i class="fas fa-comment-medical"></i> &nbsp;백신 후기</a></h2>
				<p style="color: #918f8f;">백신 접종에 관하여 회원들과 정보를 공유해보세요.</p>
			</c:if>
			<c:if test="${b_type == 2 }">
				<h2 style="font-weight: bold;"><i class="fas fa-users"></i> &nbsp;자유게시판</a></h2>
				<p style="color: #918f8f;">회원들과 다양한 소통을 해보세요.</p>
			</c:if>
		</div>
		<table style="text-align: center;margin: 0 auto; width: 100%; border-collapse:collapse;">
			<tr>
				<th>제목</th><th>작성자</th><th>작성일</th><th>조회수</th>
			</tr>
			<c:forEach var="board" items="${boardList }"> 
				<tr>
					<td style="width: 60%;  font-size: 16px; text-align: initial;">
						<a style="margin-left: 20px;" href="bView?b_idx=${board.b_idx}&b_type=${b_type}&currentPage=${currentPage}">${board.b_title }</a>
					</td>
					<td style="width: 20%;">👤${board.b_nickname }</td>
					<td style="width: 10%;">${board.b_regdate }</td>
					<td style="width: 10%;">${board.b_count }</td>
				</tr>
			</c:forEach>
		</table>
		<div style="float: right;">
			<button class="btn btn-info" onclick="location.href='bWrite?b_type=${b_type }'" style="background-color: #9acad8;">✏️작성</button>
		</div>
	    <div class="w3-center" style="margin-left: 92.15px;">
			<div class="w3-bar w3-border" style=" margin: 10px 0px;border: 1px solid #7d97a5;">
				<c:if test="${pg.startPage > pg.pageBlock }">
					<a href="board?currentPage=${pg.startPage-pg.pageBlock}&b_type=${b_type}" class="w3-bar-item w3-button">&laquo;</a>
				</c:if>
				<c:forEach var="i" begin="${pg.startPage }" end="${pg.endPage }">
					<c:if test="${pg.currentPage == i }">
						<a href="board?currentPage=${i}&b_type=${b_type}" class="w3-bar-item w3-button" style="background-color: #6c6b6b; color: white;">${i}</a>
					</c:if>
					<c:if test="${pg.currentPage != i }">
						<a href="board?currentPage=${i}&b_type=${b_type}" class="w3-bar-item w3-button">${i}</a>
					</c:if>
				</c:forEach>
				<c:if test="${pg.endPage < pg.totalPage }">
					<a href="board?currentPage=${pg.startPage+pg.pageBlock}&b_type=${b_type}" class="w3-bar-item w3-button">&raquo;</a>
				</c:if>
			</div>
		</div>
	</div>

	
	  <div class="footer">
	    <p>&copy copyright is reserved by 시작</p>
	    <a href="https://blog.naver.com/rladbtjq18" target="_blank " style="font-size: 17px; color: #337ab7;"><i class='fab fa-blogger' style='font-size:24px'></i> Blog</a>
	    <a href="https://github.com/start0ys" target="_blank " style="font-size: 17px; margin-left: 20px; color: #337ab7;"><i class='fab fa-github-square' style='font-size:24px'></i> Github</a>
	  </div>
	
	</div>
	
</body>
</html>