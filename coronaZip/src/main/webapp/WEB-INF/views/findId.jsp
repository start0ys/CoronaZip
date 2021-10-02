<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<title>아이디 찾기</title>
<style>
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
	<div style="width: 80%; margin: 0 auto; border: 0.1px solid rgb(175, 169, 169); margin-top: 10px;">
	    <form action="/findId" method="post" style="text-align: center;">
	        <div><input type="text" name="name" placeholder="이름" required="required" style="margin-top: 40px; margin-bottom: 13px;"></div>
	        <div><input type="email" name="email" placeholder="이메일" required="required"></div>
	        <input type="submit" value="아이디 찾기" class="btn btn-info" style="width: 65%; margin-top: 13px; margin-bottom: 40px; height: 50px;">
	    </form>
	</div>
	<div style="text-align: center;margin-top: 20px;"><a href="/findPw">비밀번호 찾기</a></div>
</body>
</html>