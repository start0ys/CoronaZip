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
 <link rel="stylesheet" href="cv.css?ver=12">
 <style>
   .w3-lobster {
     font-family: "Lobster", Sans-serif;
   }
   .nav {
     color:#337ab7;
     font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
     font-size: 14px;
   }
   .frame{
     width: 28%; 
     height: 340px; 
     margin-top: 20px; 
     border: 1px solid black;
     border-radius:25px;
     box-shadow: 0 4px 10px 0 rgb(0 0 0 / 20%), 0 4px 20px 0 rgb(0 0 0 / 19%);
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
      <li class="active"><a href="#"><i class='fas fa-home' style='font-size:15px'></i> Home</a></li>
      <li><a href="/center"><i class='fas fa-map-marker-alt' style='font-size:15px'></i> 예방접종센터</a></li>
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


   
    <div class="row" style="margin-top: 40px;">
      <div class="col-sm-1" style="width: 70%;padding-right: 0px;">
        <img src="img/메인.jpg" alt="" width="100%" class="img-responsive" style="height: 205px;">
        <a href='https://kr.freepik.com/vectors/cover' class="carousel-caption" style="font-size: 6px;">Cover 벡터는 rawpixel.com - kr.freepik.com가 제작함</a>
      </div>
      <div class="col-sm-1" style="background-color:#abe6de; width: 30%; height: 205px;">
        <div id="carousel-example" class="carousel slide" data-ride="carousel">
          <div class="row">
            <div class="col-xs-offset-3 col-xs-6" style="margin-left: 0; width: 100%;">
              <div class="carousel-inner">
                <div class="item active">
                  <div class="carousel-content">
                      <div>
                          <h3>기준 날짜 : ${cn.stateDt }</h3>
                          <div>확진자 수 : ${cn.totCnt }</div>
                          <div>검사 중 : ${cn.exam }</div>
                          <div>격리 해제 : ${cn.clear }</div>
                          <div>사망자 : ${cn.death }</div>
                      </div>
                  </div>
                </div>
              <c:forEach var="cnList" items="${cnList}">
                    <div class="item">
                       <div class="carousel-content">
                           <div>
                               <c:choose>
                               	  <c:when test="${cnList.city == '합계' }">
                               	  	 <h3>지역 전체</h3>
                               	  </c:when>
                               	  <c:otherwise>
			                         <h3>${cnList.city }</h3>
                               	  </c:otherwise>
                               </c:choose>
	                           <div>총 확진자 : ${cnList.total }</div>
	                           <div>추가 확진자 : ${cnList.add }</div>
	                           <div>지역발생 : ${cnList.local }</div>
	                           <div>해외유입 : ${cnList.over }</div>
	                           <div>치료중 : ${cnList.recovery }</div>
                           </div>
                        </div>
                    </div>
              </c:forEach>
              </div>
            </div>
          </div>
          <a class="left carousel-control" href="#carousel-example" data-slide="prev">
          <span class="glyphicon glyphicon-chevron-left"></span>
          </a>
          <a class="right carousel-control" href="#carousel-example" data-slide="next">
          <span class="glyphicon glyphicon-chevron-right"></span>
          </a>
        </div>
      </div>
      <c:forEach var="news" items="${news}">
		 <a href="${news.link }" target="_blank ">
		 	<div class="col-sm-1 frame" style="margin-left: 4%;">
		 		<h4 style="padding-top: 25px; font-weight: bold; height: 110px;">${news.title }</h4>
		 		<div style="height: 230px; border-top: 1px solid;padding-top: 10px;">${news.content }</div>
		 	</div>
		 </a>   
      </c:forEach>
    </div>
    
    <div class="footer">
      <p>&copy copyright is reserved by 시작</p>
      <a href="https://blog.naver.com/rladbtjq18" target="_blank " style="font-size: 17px;"><i class='fab fa-blogger' style='font-size:24px'></i> Blog</a>
      <a href="https://github.com/start0ys" target="_blank " style="font-size: 17px; margin-left: 20px;"><i class='fab fa-github-square' style='font-size:24px'></i> Github</a>
    </div>

  
  </div>

 
  <script src="cv.js"></script>
</body>
</html>