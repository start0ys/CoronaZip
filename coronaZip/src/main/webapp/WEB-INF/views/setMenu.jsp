<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="common/header.jsp"%>

<style>
.menuData:hover{color: #337ab7; cursor:pointer;}
</style>
<script type="text/javascript">
function changeMenu(idx){
	$('#menuDetail').css({'display':'block'});
	$('#addMenuSetting').css({'display':'none'});
	$.ajax({
		url:'menuSelect?idx='+idx,
		dataType:'json',
		success:function(data){
			if($('#menuTop').length > 0) $('#menuTop').remove();
			$('#name').val(data.name);
			$("input[name='type'][value='"+data.type+"']").prop("checked", true);
			if(!!data.icon && data.icon.length > 0){
				if($('#iconY').length > 0) $('#iconY').remove();
				$('#icon').append('<i class="'+data.icon+'" id="iconY"></i>');
			}
			if(data.type > 0 && data.groupnum == 0){
				$('#bottomMenu').css({'display':'block'});
			}else{
				$('#bottomMenu').css({'display':'none'});
			}
			if(!!data.groupnum && data.groupnum > 0){
				const str = '<div id="menuTop">'+
							'	<label>상위 메뉴</label>'+
								$('#menu'+data.type+'-0').html() +
							'</div>';
				$('#topMenu').append(str);
			}
		}
	});		
}
function addMenu(){
	if($('#addMenu').length > 0){
		alert('이미 추가한 새메뉴가 존재합니다.');
	}else{		
		const str = '<div id="addMenu" class="menuData" onclick="addMenuSetting()">새메뉴</div>';
		$('#menuList').append(str);
	}
}
function addMenuSetting(){
	$('#menuDetail').css({'display':'none'});
	$('#addMenuSetting').css({'display':'block'});
}
function changeMenuName(){
	$('#addMenu').text($('#name2').val());
}
</script>

<%@include file="common/menu.jsp"%>

<div style="margin-top: 37px; text-align: center;">
	<h2 style="font-weight: bold;"><i class="fas fa-cog"></i>메뉴 관리</h2>
	<p style="color: #918f8f;">메뉴를 추가,삭제,변경 할수있습니다.</p>
</div>
<div style="width: 90%; margin: 0 auto; height: 360px; padding: 30px">
	<div id="menuList" style="width: 50%; height: 300px; float: left; border: 1px solid black; overflow: auto; padding-top: 10px; padding-left: 10px;">
		<div style="float: right; margin-top: -10px;">
			<button onclick="addMenu()">추가</button>
			<button>제거</button>
		</div>
		<c:forEach var="menu" items="${menuList }">
			<div class="menuData" onclick="changeMenu(${menu.idx})" id="menu${menu.type }-${menu.groupnum}">
				<c:choose>
					<c:when test="${menu.groupnum == 0 }">${menu.name }</c:when>
					<c:otherwise>└${menu.name }</c:otherwise>
				</c:choose>
				<c:if test="${not empty menu.icon }">
             		<i class='${menu.icon }' style="margin-left: 5px;"></i>
             	</c:if>
			</div>
		</c:forEach>
	</div>
	<div style="width: 50%; height: 300px; float: right; padding-top: 10px; padding-left: 10px;">
		<div id="menuDetail">
			<form action="updateMenu" method="post">
				<div style="float: right; margin-top: -3px; display: none;" id="bottomMenu">
					<button onclick="addBottomMenu()">하위 메뉴 추가</button>
				</div>
				<div>
					<label>메뉴 이름</label>
					<input type="text" name="name" id="name">
				</div>
				<div>
					<label>메뉴 타입</label>
					일반 <input type="radio" name="type" value="0">
					  그룹 <input type="radio" name="type" value="1">
					  마이페이지 <input type="radio" name="type" value="2">
					  관리페이지 <input type="radio" name="type" value="3">
				</div>
				<div id="topMenu"></div>
				<div id="icon">
					<label>아이콘</label>
				</div>
				<div style="text-align: center; margin-top: 30px;">
					<input type="submit" value="수정">
				</div>
			</form>
		</div>
		
		<div id="addMenuSetting" style="display: none;">
			<form action="addMenu" method="post">
				<div>
					<label>메뉴 이름</label>
					<input type="text" name="name" id="name2" value="새메뉴" onchange="changeMenuName()">
				</div>
				<div>
					<label>메뉴 타입</label>
					일반 <input type="radio" name="type2" value="0">
					  그룹 <input type="radio" name="type2" value="1">
					  마이페이지 <input type="radio" name="type2" value="2">
					  관리페이지 <input type="radio" name="type2" value="3">
				</div>
				<div id="icon">
					<label>아이콘</label>
				</div>
				<div style="text-align: center; margin-top: 30px;">
					<input type="submit" value="추가">
				</div>
			</form>
		</div>
	</div>	
</div>

<%@include file="common/footer.jsp"%>

</body>
</html>