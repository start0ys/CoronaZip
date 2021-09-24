function map(size,rs){
    var a = rs;
    var b = a.replace( /&#39;/gi, "").replace( /&lt;/gi, "<").replace( /&gt;/gi, ">").replace( /\[/gi, "").replace( /\]/gi, "").replace( /\'/gi, "");
    var result = []
    result = b.split(",");
    if(size == 0){
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = {
        center: new kakao.maps.LatLng(35.82650, 128.19161), // 지도의 중심좌표
        level: 14, // 지도의 확대 레벨
        mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
    }; 
    } else {
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = {
            center: new kakao.maps.LatLng(result[0], result[1]), // 지도의 중심좌표
            level: 9, // 지도의 확대 레벨
            mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
        }; 
    }

    // 지도를 생성한다 
    var map = new kakao.maps.Map(mapContainer, mapOption); 
    // 마커 클러스터러를 생성합니다 
    var clusterer = new kakao.maps.MarkerClusterer({
        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
        minLevel: 10 // 클러스터 할 최소 지도 레벨 
    });

    var markers = [];
    for(var i = 0; i< (result.length/3); i++){
        // 지도에 마커를 생성하고 표시한다
        var marker = new kakao.maps.Marker({
        position: new kakao.maps.LatLng(result[3*i], result[3*i+1]), // 마커의 좌표
        map: map // 마커를 표시할 지도 객체
        });
    
        // 인포윈도우를 생성합니다
        var infowindow = new kakao.maps.InfoWindow({
            content : result[3*i+2]
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