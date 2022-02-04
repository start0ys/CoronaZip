<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="common/header.jsp"%>

<link rel="stylesheet" href="cv.css?ver=12">
<style>
   .frame{
     width: 28%; 
     height: 340px; 
     margin-top: 20px; 
     border: 1px solid black;
     border-radius:25px;
     box-shadow: 0 4px 10px 0 rgb(0 0 0 / 20%), 0 4px 20px 0 rgb(0 0 0 / 19%);
   }
 </style>

<%@include file="common/menu.jsp"%>

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
              <c:forEach var="cnList" items="${cnList}">
                    <c:choose>
                    	<c:when test="${cnList.city == '합계' }">
	                    	<div class="item active">
	                    </c:when>
	                    <c:otherwise>
                    		<div class="item">
                    	</c:otherwise>
                    </c:choose>
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
	                           <%-- <div>치료중 : ${cnList.recovery }</div> --%>
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

<%@include file="common/footer.jsp"%>
<script src="cv.js"></script>
</body>
</html>