<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${result == 2 }">
		<script type="text/javascript">
			alert("비밀번호를 다시 확인해주세요.");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result == 1 }">
		<script type="text/javascript">
			alert("존재하지 않는 아이디입니다.");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>