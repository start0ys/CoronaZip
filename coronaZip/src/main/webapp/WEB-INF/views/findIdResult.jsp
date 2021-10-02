<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<style type="text/css">
a{
	color: black;
	text-decoration: none;
}
a:hover{
	color: #337ab7;
}
</style>
</head>
<body>
	<c:if test="${not empty result }">
		<h3 style="margin-top: 70px; text-align: center;">회원님의 아이디는 <b style="color: #337ab7;">${result }</b> 입니다.</h3>
		<div style="text-align: center;">
			<div><a href="/findPw">비밀번호 찾기</a></div>
			<div style="margin-top: 15px;"><button onclick="window.close();">닫기</button></div>
		</div>
	</c:if>
	<c:if test="${empty result }">
		<script type="text/javascript">
			alert("이름 또는 이메일이 올바르지않습니다.");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>