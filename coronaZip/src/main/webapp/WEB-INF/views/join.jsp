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
   td,th{
      text-align: initial;
    }
    th{
      background-color:#fbfafa;
      height: 45px;
      font-size: 13px;
      width: 130px;
      font-weight: normal;
      vertical-align: top;
      padding: 11px 0 10px 18px;
    }
    td{
      width: 80%;
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
        <li><a href="/login"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
        <li><a href="/join"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
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
        <table border="1" style="border: none; margin: 0 auto; width: 80%;">
          <tr><th>이름</th><td><input type="text" style="margin-left: 7px;"></td></tr>
          <tr><th>생년월일</th><td><input type="text" style="margin-left: 7px;"></td></tr>
          <tr>
            <th>성별</th>
            <td>
              <input type="radio" style="margin-left: 63px;">남자&nbsp;&nbsp;
              <input type="radio">여자
            </td>
          </tr>
          <tr><th>아이디</th><td><input type="text" style="margin-left: 7px;"><button>중복확인</button></td></tr>
          <tr><th>비밀번호</th><td><input type="text" style="margin-left: 7px;"></td></tr>
          <tr><th>비밀번호 확인</th><td><input type="text" style="margin-left: 7px;"></td></tr>
          <tr><th>닉네임</th><td><input type="text" style="margin-left: 7px;"></td></tr>
          <tr><th>이메일</th><td><input type="text" style="margin-left: 7px;"></td></tr>
          <tr>
            <th>주소</th>
            <td>
              <input type="text" id="ps_addr" readonly style="margin-left: 7px; width: 25%;"><button onclick="findAddr()">우편번호</button><br>
              <input type="text" id="bs_addr" readonly placeholder="기본주소" style="margin-left: 7px; width: 85%;"><br>
              <input type="text" id="dt_addr" placeholder="상세주소" style="margin-left: 7px; width: 85%;">
            </td>
          </tr>
          <tr>
            <th>백신유무</th>
            <td>
              <select style="margin-left: 7px;">
                <option>미접종</option>
                <option>화이자-1차</option>
                <option>화이자-2차</option>
                <option>모더나-1차</option>
                <option>모더나-2차</option>
                <option>AZ-1차</option>
                <option>AZ-2차</option>
              </select>
            </td>
          </tr>
          <tr>
            <td style="text-align: right;" colspan="2">
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


<script>
  function findAddr(){
    new daum.Postcode({
          oncomplete: function(data) {
            
            console.log(data);      
              // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
              // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
              // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
              var roadAddr = data.roadAddress; // 도로명 주소 변수
              var jibunAddr = data.jibunAddress; // 지번 주소 변수
              // 우편번호와 주소 정보를 해당 필드에 넣는다.
              document.getElementById('ps_addr').value = data.zonecode;
              if(roadAddr !== ''){
                  document.getElementById("bs_addr").value = roadAddr;
              } 
              else if(jibunAddr !== ''){
                  document.getElementById("bs_addr").value = jibunAddr;
              }
          }
      }).open();
  }
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>