<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
      <li id="menuHome"><a href="/index"><i class='fas fa-home' style='font-size:15px'></i> Home</a></li>
      <li id="menuCenter"><a href="/center"><i class='fas fa-map-marker-alt' style='font-size:15px'></i> 예방접종센터</a></li>
      <li class="dropdown" id="menuBorder">
        <a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class='fas fa-globe' style='font-size:15px'></i> 커뮤니티<span class="caret"></span></a>
        <ul class="dropdown-menu" style="color: #337ab7;">
          <li><a href="/board?b_type=0"><i class="fas fa-head-side-virus"></i> &nbsp;코로나 증상</a></li>
          <li><a href="/board?b_type=1"><i class="fas fa-comment-medical"></i> &nbsp;백신 후기</a></li>
          <li><a href="/board?b_type=2"><i class="fas fa-users"></i> &nbsp;자유게시판</a></li>                      
        </ul>
      </li>
      <c:if test="${not empty user }">
      <li class="dropdown" id="menuMyPage">
        <a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class="fas fa-user-circle"></i> 마이페이지<span class="caret"></span></a>
        <ul class="dropdown-menu" style="color: #337ab7;">
          <li><a href="/update"><i class="fas fa-address-card"></i> &nbsp;정보수정</a></li>
          <li><a href="/msg"><i class="fas fa-envelope"></i> &nbsp;쪽지함</a></li>  
        </ul>
      </li>
      </c:if>
    </ul>