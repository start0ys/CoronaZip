<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
</head>
<body>
	<c:if test="${result == 2 }">
		<h3 style="margin-top: 70px; text-align: center;">임시 비밀번호를 <b style="color: #337ab7;">이메일</b>로 전송 하였습니다.</h3>
		<div style="text-align: center;">
			<div>임시 비밀번호를 확인하여 로그인 하신 후</div>
			<div style="color: red;">꼭 비밀번호를 변경해주세요.</div>
			<div style="margin-top: 15px;"><button onclick="window.close();">닫기</button></div>
		</div>
	</c:if>
	<c:if test="${result == 1 }">
		<script type="text/javascript">
			alert("아이디 또는 이메일이 올바르지않습니다.");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>