<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
</head>
<body>
	<div class="container">
    <div style="margin-top: 10px;" class="w3-container w3-lobster">
      <img src="img/파란마스크.png" alt="" width="60" height="">
      <span><span style="color: #8fd5ff;" class="w3-xxlarge font-effect-shadow-multiple">CORONA</span><span style="font-size: 20px;">.ZIP</span></span>
    </div>
    <ul class="nav navbar-nav navbar-right">
      <c:if test="${empty user }">
	      <li><a href="/login" style="padding-top: 10px;"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
   		  <li id="menuJoin"><a href="/join" style="padding-top: 10px;"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
      </c:if>
      <c:if test="${not empty user }">
      	  <div style="padding-top: 10px;">
		      <span style="color: #717171;">[${user.vaccine }]${user.nickname } 님 반갑습니다.</span>
		      <span style="margin-right: 25px; margin-left: 7px;"><a href="/logout" style="text-decoration: none;">로그아웃</a></span>
      	  </div>
      </c:if>
    </ul>
    <ul class="nav nav-tabs" style="height: 42px;">
      <c:forEach var="menu" items="${menuList }">
      	  <c:if test="${menu.type == 0 }">
      	  	 <li id="${menu.id }"><a href="${menu.link }">
      	  	 <c:if test="${not empty menu.icon }">
	      	  	 <i class='${menu.icon }'></i>
      	  	 </c:if>
      	  	 ${menu.name }</a></li>
      	  </c:if>
      	  <c:if test="${menu.type == 1 && menu.groupnum == 0}">
      	  	 <li class="dropdown" id="${menu.id }">
             	<a class="dropdown-toggle" data-toggle="dropdown" href="#">
             	<c:if test="${not empty menu.icon }">
             		<i class='${menu.icon }'></i>
             	</c:if>
             	${menu.name }<span class="caret"></span></a>
           		<ul class="dropdown-menu" style="color: #337ab7;">
          </c:if>
          <c:if test="${menu.type == 1 && menu.groupnum > 0}">
            	<li><a href="${menu.link }">
            	<c:if test="${not empty menu.icon }">
            		<i class="${menu.icon }"></i>
            	</c:if>
            	${menu.name }</a></li>
          </c:if>
          <c:if test="${menu.type == 1 && menu.groupnum == 99 }">
              	</ul>
      		 </li>
      	  </c:if>
      	  <c:if test="${not empty user && user.id != 'admin'}">
      	 		<c:if test="${menu.type == 2 && menu.groupnum == 0}">
	      	  	 	<li class="dropdown" id="${menu.id }">
		             	<a class="dropdown-toggle" data-toggle="dropdown" href="#">
		             	<c:if test="${not empty menu.icon }">
		             		<i class='${menu.icon }'></i>
		             	</c:if>
		             	${menu.name }<span class="caret"></span></a>
		           		<ul class="dropdown-menu" style="color: #337ab7;">
		         </c:if>
		         <c:if test="${menu.type == 2 && menu.groupnum > 0}">
		            	<li><a href="${menu.link }">
		            	<c:if test="${not empty menu.icon }">
		            		<i class="${menu.icon }"></i>
		            	</c:if>
		            	${menu.name }</a></li>
		         </c:if>
		         <c:if test="${menu.type == 2 && menu.groupnum == 99 }">
		              	</ul>
	      		 	</li>
      	  	  </c:if>
      	  </c:if>
      	  <c:if test="${not empty user && user.id == 'admin' }">
      	 		<c:if test="${menu.type == 3 && menu.groupnum == 0}">
	      	  	 	<li class="dropdown" id="${menu.id }">
		             	<a class="dropdown-toggle" data-toggle="dropdown" href="#">
		             	<c:if test="${not empty menu.icon }">
		             		<i class='${menu.icon }'></i>
		             	</c:if>
		             	${menu.name }<span class="caret"></span></a>
		           		<ul class="dropdown-menu" style="color: #337ab7;">
		         </c:if>
		         <c:if test="${menu.type == 3 && menu.groupnum > 0}">
		            	<li><a href="${menu.link }">
		            	<c:if test="${not empty menu.icon }">
		            		<i class="${menu.icon }"></i>
		            	</c:if>
		            	${menu.name }</a></li>
		         </c:if>
		         <c:if test="${menu.type == 3 && menu.groupnum == 99 }">
		              	</ul>
	      		 	</li>
      	  	  </c:if>
      	  </c:if>
      </c:forEach> 
    </ul>