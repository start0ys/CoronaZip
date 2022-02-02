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
	
	/*  */
	.hiddenText {
   		display: none;
	}
	textarea{
		width: 90%;
		resize: none;
	}
	.btn1{
		background-color: white;
		border: 0;
		font-weight: bold;
	}
	.btn{
		background: black;
		color: white;
		border-radius: 10px;
	}
</style>
<script type="text/javascript">
var b = "a";
function re(id) {
	var content2 = document.getElementById(b);
    content2.style.display = "none";
	var a = "a" + id;
	var content = document.getElementById(a);
    content.style.display = "block";
	b=a;
}
function del() {
	const del =  confirm("해당 게시글을 삭제하시겠습니까?");
	if(del){
		location.href='bdelete.do?b_idx=${board.b_idx }&pageNum=${pageNum }';
	}
}
function redel(id) {
	const redel =  confirm("해당 댓글을 삭제하시겠습니까?");
	var c_idx = id;
	if(redel){
		location.href='reDelete?c_idx='+c_idx+'&b_idx=${board.b_idx }&b_type=${board.b_type}&currentPage=${currentPage}';
	}
}

function remd(id) {
	var popupX = (document.body.offsetWidth / 2) - (200 / 2);
	var popupY= (window.screen.height / 2) - (300 / 2);
	var c_idx = id;
	window.open("reUpdate?c_idx="+c_idx,"","width=500,height=300, left="+ popupX + ", top="+ popupY);
}
</script>
</head>
<body>
	<div id="a"></div>
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
    
	<div style="margin: 0 auto; width: 90%">
		<h3 style="margin-top: 40px;">
        	<c:choose>
       			<c:when test="${board.b_type == 0 }">[코로나 증상]</c:when>
        		<c:when test="${board.b_type == 1 }">[백신 후기]</c:when>
        		<c:otherwise>[자유게시판]</c:otherwise>
     		</c:choose>
     		${board.b_title}
		</h3>
		<div style="margin-top: 10px;">
			<span>👤${board.b_nickname }</span>
		</div>
		<div style="border: 0; border-bottom: 2px solid black;">
			<span style=" font-size: 13px; color: gray;">${board.b_regdate }</span>
			<span style=" font-size: 13px; color: gray;">조회수 : ${board.b_count }</span>
			<span style=" font-size: 15px; color: gray; float: right;">댓글 <b>${cListTotal}</b></span>
		</div>
		<div style="float: right;">
			<button class="btn btn-info" onclick="location.href='board?b_type=${board.b_type }&currentPage${currentPage}'" style="background-color: #9acad8;">이전</button>
			<c:if test="${board.id == user.id }">
				<button class="btn btn-info" onclick="location.href='bUpdate?b_type=${board.b_type }&b_idx=${board.b_idx }&currentPage${currentPage}'" style="background-color: #9acad8;">수정</button>
			</c:if>
		</div>
		<div style="height: 300px;margin-top: 40px;">${board.b_content }</div>
		<div style="border-top: 2px solid black;">
			<c:forEach var="comment" items="${cList}">
				<c:if test="${comment.re_level > 0 }">
					<img src="img/level.gif" width="${comment.re_level*10 }">
					<img src="img/re.gif">
					<span style="margin: 11px 0 0 0;">👤[${comment.c_vaccine}]${comment.c_nickname }</span>
				</c:if> 
				<c:if test="${comment.re_level == 0 }">
					<div style="margin: 11px 0 0 11px;">👤[${comment.c_vaccine}]${comment.c_nickname }</div>
				</c:if>
				<div style="margin-left: ${comment.re_level*15 }px; ">
					<div style="margin: 5px 0 0 11px;">${comment.c_content }</div>
					<div style="font-size: 13px; color: gray; margin: 0  0 5px 11px;">${comment.c_regdate }</div>
				    <div style="margin: 0  0 11px 0; border-bottom: 1px dotted;">
					    <input style="margin-left: 11px" class="btn1" type="button" value="답글" onclick="re(${comment.c_idx})">
						<c:if test="${comment.id == user.id }">
							<input class="btn1" type="button" value="수정" onclick="remd(${comment.c_idx })">
						</c:if>
						<c:if test="${comment.id == user.id}">
							<input class="btn1" type="button" value="삭제" onclick="redel(${comment.c_idx })">
						</c:if>
				    </div>
	
					<div class="hiddenText" id="a${comment.c_idx }">
						<form action="reWrite" method="post" name="frm1" id="frm1">
						    <input type="hidden" name="c_nickname" value="${user.nickname }">
							<input type="hidden" name="id" value="${user.id }">
							<input type="hidden" name="b_idx" value="${board.b_idx }">
							<input type="hidden" name="c_idx" value="${comment.c_idx }">
							<input type="hidden" name="b_type" value="${board.b_type }">
							<input type="hidden" name="ref" value="${comment.ref }">
							<input type="hidden" name="re_level" value="${comment.re_level }">
							<input type="hidden" name="re_step" value="${comment.re_step }">
							<input type="hidden" name="c_vaccine" value="${user.vaccine}">
							<input type="hidden" name="currentPage" value="${currentPage}">
					       	<span><img src="img/re.gif"></span>
							<span style="margin: 11px 0 0 0;">👤[${user.vaccine }]${user.nickname }</span>
							<div style="margin: 11px 0 0 11px;"><textarea name="c_content" id="c_content" maxlength="2000" style="height:100px;" required="required"
							                 placeholder="댓글을 입력해주세요"></textarea></div>
							<div style="margin: 0  0 11px 11px;"><input style="padding: 5px;" class="btn" type="submit" value="등록"></div>
						 </form>
					</div>	    
				</div>
			</c:forEach>
			
			<form action="reWrite" method="post" name="frm2">  
 					<input type="hidden" name="c_nickname" value="${user.nickname }">
					<input type="hidden" name="id" value="${user.id }">
					<input type="hidden" name="b_idx" value="${board.b_idx }">
					<input type="hidden" name="c_idx" value="${c_idx }">
					<input type="hidden" name="b_type" value="${board.b_type }">
					<input type="hidden" name="ref" value="${ref }">
					<input type="hidden" name="re_level" value="${re_level }">
					<input type="hidden" name="re_step" value="${re_step }">
					<input type="hidden" name="c_vaccine" value="${user.vaccine}">
					<input type="hidden" name="currentPage" value="${currentPage}">
					<div style="border: 1px dotted black; ">
						<div style="margin: 11px 0 0 11px;">👤[${user.vaccine }]${user.nickname }</div>
					    <div style="margin: 20px 0 0 20px;"><textarea name="c_content" id="c_content" maxlength="2000" style="height:100px; border: 0px;" required="required"
				                               placeholder="댓글을 입력해주세요"></textarea></div>        
					    <div style="margin: 0  0 11px 11px; width: 56px; border: 1px dotted; padding: 5px; border-radius: 10px;"><input style="padding: 5px;" class="btn" type="submit" value="등록"></div>
					</div>
				
			</form>	
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