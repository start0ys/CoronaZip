<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CoronaZip</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster&effect=shadow-multiple">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<c:if test="${not empty user }">
	<script type="text/javascript">
		alert("로그인 상태에서는 로그인을 이용할수없습니다.");
		history.go(-1);
	</script>
</c:if>
<style>
body{
    margin: 0;
    padding: 0;
    background-color: #ececee;
}
#wrapper{
    width: 50%;
    height: 100vh;
    margin: 0 auto;
    background-color: white;
}
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
input{
    width: 65%;
    height: 40px;
    font-size: 15px;
    border: 0.5px solid gray;
}
a{
    color: black;
    text-decoration: none;
}
</style>
</head>
<body>
    <div id="wrapper">
        <div style="background-color: white; height: 70px;"></div>
        <div style="text-align: center;" class="w3-container w3-lobster">
            <div style="margin-top: 70px;">
                <img src="img/파란마스크.png" alt="" width="60" height="" style="margin-bottom: 44px;">
                <span><span style="color: #8fd5ff;font-size: 63px;" class="w3-xxlarge font-effect-shadow-multiple">CORONA</span><span style="font-size: 30px;">.ZIP</span></span>
            </div>
        </div>
        <div style="width: 80%; margin: 0 auto; border: 0.1px solid rgb(175, 169, 169);">
            <form action="/login" method="post" style="text-align: center;">
                <div><input type="text" name="id" placeholder="👤아이디" style="margin-top: 40px; margin-bottom: 13px;"></div>
                <div><input type="password" name="pw" placeholder="🔑비밀번호"></div>
                <input type="submit" value="로그인" class="btn btn-info" style="width: 65%; margin-top: 13px; margin-bottom: 40px; height: 50px;">
            </form>
        </div>
        <div style="text-align: center; margin-top: 20px;">
            <a href="findId">아이디 찾기</a> | <a href="findPw">비밀번호 찾기</a>
        </div>
    </div>
</body>
</html>