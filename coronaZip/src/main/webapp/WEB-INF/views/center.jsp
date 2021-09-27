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
	        <li class="active"><a href="#"><i class='fas fa-map-marker-alt' style='font-size:15px'></i> 예방접종센터</a></li>
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
	
	  <div class="w3-card-4" style="width: 520px; height: 380px; margin: 60px auto; padding-top: 5px;">  
	    <div id="map" style="width:510px;height:370px; margin: 0 auto;" ></div>
	  </div>
	
	  <div class="footer">
	    <p>&copy copyright is reserved by 시작</p>
	    <a href="https://blog.naver.com/rladbtjq18" target="_blank " style="font-size: 17px;"><i class='fab fa-blogger' style='font-size:24px'></i> Blog</a>
	    <a href="https://github.com/start0ys" target="_blank " style="font-size: 17px; margin-left: 20px;"><i class='fab fa-github-square' style='font-size:24px'></i> Github</a>
	  </div>
	
	</div>
	
	<script> 
	    $.ajax({
	        url:"https://api.odcloud.kr/api/15077586/v1/centers?page=1&perPage=280&serviceKey=4GfH2i3tXiTAlgB1urJs7gd3SalAlH0w9dTp3ytpzhhhq8CcaYTF0rMwwVtATbZVLNUw1hLIc1as6IHBPxFvMA%3D%3D",
	        dataType:'json',
	        success:function(data){
	            var arr = [];
	            for(var i = 0; i < data["data"].length;i++){
	                var list = data["data"][i];
	                var address     = list["address"];
	                var faciliyName = list["facilityName"];
	                var lat         = list["lat"];
	                var lng         = list["lng"];
	                var phoneNumber = list["phoneNumber"];
	                var text = "<div style='width:280px;'><h3>"+faciliyName+"</h3>"+"<p>주소 : "+address+"</p>"+"<p>전화번호 : "+phoneNumber+"</p></div>";
	                arr.push(lat,lng,text);
	            }
	            
	            var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	            mapOption = {
	            center: new kakao.maps.LatLng(35.82650, 128.19161), // 지도의 중심좌표
	            level: 14, // 지도의 확대 레벨
	            mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
	            }; 
	        
	
	            // 지도를 생성한다 
	            var map = new kakao.maps.Map(mapContainer, mapOption); 
	            // 마커 클러스터러를 생성합니다 
	            var clusterer = new kakao.maps.MarkerClusterer({
	                map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
	                averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
	                minLevel: 10 // 클러스터 할 최소 지도 레벨 
	            });
	
	            var markers = [];
	            for(var i = 0; i< (arr.length/3); i++){
	                // 지도에 마커를 생성하고 표시한다
	                var marker = new kakao.maps.Marker({
	                position: new kakao.maps.LatLng(arr[3*i], arr[3*i+1]), // 마커의 좌표
	                map: map // 마커를 표시할 지도 객체
	                });
	            
	                // 인포윈도우를 생성합니다
	                var infowindow = new kakao.maps.InfoWindow({
	                    content : arr[3*i+2]
	                });
	
	
	                markers.push(marker);
	                kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
	                kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
	                // 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
	                function makeOverListener(map, marker, infowindow) {
	                    return function() {
	                        infowindow.open(map, marker);
	                    };
	                }
	                
	                // 인포윈도우를 닫는 클로저를 만드는 함수입니다 
	                function makeOutListener(infowindow) {
	                    return function() {
	                        infowindow.close();
	                };
	                }
	                
	            }
	            clusterer.addMarkers(markers);
	        }
	    });
	    
	</script>
</body>
</html>