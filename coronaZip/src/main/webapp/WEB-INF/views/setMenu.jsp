<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="common/header.jsp"%>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"/>
<link rel="stylesheet" href="dist/css/bootstrap-iconpicker.min.css"/>

<style>
.menuData:hover{color: #337ab7; cursor:pointer;}
a{color: #337AB3;}
.dropdown-toggle::after {
    display: none;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	$('button[role="iconpicker"]').find('input').attr('name','icon');
});
function changeMenu(idx){
	$('#menuDetail').css({'display':'block'});
	$('#addMenuSetting').css({'display':'none'});
	$('#idx').val(idx);
	$.ajax({
		url:'menuSelect?idx='+idx,
		dataType:'json',
		success:function(data){
			if($('#menuTop').length > 0) $('#menuTop').remove();
			if($('#menuTop2').length > 0) $('#menuTop2').remove();
			$('#name').val(data.name);
			$("input[name='type'][value='"+data.type+"']").prop("checked", true);
			let icon = '';
			if(!!data.icon && data.icon.length > 0) icon = data.icon;
			else icon = 'empty';
			$('button[role="iconpicker"]').find('i').attr('class',icon);
			$('button[role="iconpicker"]').find('input').val(icon);
			
			if(data.type > 0 && data.groupnum == 0){
				$('#bottomMenu').css({'display':'block'});
				$('#menuValue').attr('name',data.type);
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
		const str = '<div id="addMenu" class="menuData" onclick="addMenuSetting()">새 메뉴</div>';
		$('#menuList').append(str);
	}
}
function addMenuSetting(){
	$('#menuDetail').css({'display':'none'});
	$('#addMenuSetting').css({'display':'block'});
	$('button[role="iconpicker"]').find('i').attr('class','empty');
	$('button[role="iconpicker"]').find('input').val('empty');
}
function changeMenuName(){
	$('#addMenu').text($('#name2').val());
}
function addBottomMenu(){
	if($('#addMenu').length > 0){
		alert('이미 추가한 새메뉴가 존재합니다.');
		return;
	}
	const type = $('#menuValue').attr('name');
	const target = $('div[id^="menu'+type+'-"]');
	const targetNum = target.length - 1;
	const str = '<div id="addTopMenu" class="menuData" onclick="addMenuSetting()">└ 새 하위메뉴</div>';
	const str2 = '<div id="menuTop">'+
				'	<label>상위 메뉴</label>'+
					$('#menu'+type+'-0').html() +
				'</div>';
	$($('div[id^="menu'+type+'-"]')[targetNum]).after(str);
	$('#topMenu2').append(str2);
}
function temporary(){
	alert("현재는 메뉴 수정만 가능합니다.");
	return false;
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
				<input type="hidden" name="idx" id="idx">
				<div>
					<label>메뉴 이름</label>
					<!-- <input type="text" name="name" id="name"> -->
					<div class="input-group" style="display: inline-flex; width: 70%;">
					    <span class="input-group-prepend">
					        <button class="btn btn-secondary" data-icon="empty" role="iconpicker"></button>
					    </span>
					    <input type="text" class="form-control" name="name" id="name">
					</div>
				</div>
				<div style="margin-top: 10px">
					<label>메뉴 타입</label>
					일반 <input type="radio" name="type" value="0" onclick="return(false);">
					  그룹 <input type="radio" name="type" value="1" onclick="return(false);">
					  마이페이지 <input type="radio" name="type" value="2" onclick="return(false);">
					  관리페이지 <input type="radio" name="type" value="3" onclick="return(false);">
				</div>
				<div id="topMenu" style="margin-top: 10px"></div>
				
				<div style="float: right; margin-top: 30px; display: none;" id="bottomMenu">
					<div id="menuValue"></div>
					<input type="button" onclick="addBottomMenu()" value="하위 메뉴 추가">
				</div>
				<div style="float:left; margin-top: 30px;">
					<input type="submit" value="수정">
				</div>
			</form>
		</div>
		
		<div id="addMenuSetting" style="display: none;">
			<form action="addMenu" method="post" onsubmit="return temporary()">
				<div>
					<label>메뉴 이름</label>
					<!-- <input type="text" name="name" id="name2" value="새메뉴" onchange="changeMenuName()"> -->
					<div class="input-group" style="display: inline-flex; width: 70%;">
					    <span class="input-group-prepend">
					        <button class="btn btn-secondary" data-icon="empty" role="iconpicker"></button>
					    </span>
					    <input type="text" class="form-control" name="name2" id="name">
					</div>
				</div>
				<div>
					<label>메뉴 타입</label>
					일반 <input type="radio" name="type2" value="0">
					  그룹 <input type="radio" name="type2" value="1">
					  마이페이지 <input type="radio" name="type2" value="2">
					  관리페이지 <input type="radio" name="type2" value="3">
				</div>
				
				<div id="topMenu2" style="margin-top: 10px"></div>
				
				<div style="float:left; margin-top: 30px;">
					<input type="submit" value="추가">
				</div>
			</form>
		</div>
	</div>	
</div>

<%@include file="common/footer.jsp"%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="dist/js/bootstrap-iconpicker.bundle.min.js"></script>
</body>
</html>