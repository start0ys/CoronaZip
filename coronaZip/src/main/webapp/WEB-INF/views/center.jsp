<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="common/header.jsp"%>

<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=9617e5ff316756ebbb3a571e76b07bbb&libraries=clusterer"></script>

<%@include file="common/menu.jsp"%>

<div class="w3-card-4" style="width: 520px; height: 380px; margin: 60px auto; padding-top: 5px;">  
	<div id="map" style="width:510px;height:370px; margin: 0 auto;" ></div>
</div>

<%@include file="common/footer.jsp"%>

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