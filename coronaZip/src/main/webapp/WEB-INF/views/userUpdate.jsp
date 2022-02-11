<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="common/header.jsp"%>

<c:if test="${empty user }">
	<script type="text/javascript">
		alert("정보수정은 로그인 후에 이용할수있습니다.");
		location.href='index';
	</script>
</c:if>

<style>
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
  padding-left: 7px;
}
.navbar-right>li.active>a, .navbar-right>li.active>a:focus, .navbar-right>li.active>a:hover {
    color: #555;
    cursor: default;
    background-color: #fff;
    border: 1px solid #ddd;
    border-bottom-color: transparent;
}
#menuJoin>a{
	padding: 10px;
}
</style>

<%@include file="common/menu.jsp"%>

<div style="text-align: center; margin-top: 30px; margin-bottom: 60px;">
	<form action="userUpdate" method="post" name="frm" onsubmit="return subChk()">
		<input type="hidden" name="id" value="${user.id }">
		<div style="margin: 37px 0px;">
			<h2 style="font-weight: bold;">정보수정</h2>
			<p style="color: #918f8f;">사용자의 개인정보를 수정할수있습니다.</p>
		</div>  
		<table style="border: none; margin: 0 auto; width: 80%;" border="1">
			<tr><th>이름</th><td>${user.name }</td></tr>
			<tr><th>생년월일</th><td>${user.birth }</td></tr>
			<tr><th>성별</th><td>${user.sex }</td></tr>
			<tr><th>비밀번호 변경</th><td><input type="password" id="pw" name="pw"></td></tr>
			<tr>
				<th>비밀번호 변경 확인</th>
				<td>
				 	<input type="password" id="pw2" name="pw2" onkeyup="pwChk()">
				 	<span id="pwAlert"></span>
				</td>
			</tr>
			<tr><th>닉네임</th><td><input type="text" name="nickname" value="${user.nickname }"></td></tr>
			<tr><th>이메일</th><td><input type="email" name="email" value="${user.email }"></td></tr>
			<tr>
			 	<th>주소</th>
			  	<td style="padding: 7px;">
					<input type="text" id="postcode" name="postcode" readonly="readonly"style="width: 90px; background-color: #fbfafa; border: 1px solid;" value="${user.postcode }">
					<input type="button" value="🔍️주소검색" onclick="findAddr()"><br>
					<input type="text" id="bs_addr" name="bs_addr" readonly="readonly" style="width: 400px; margin-top: 4px; margin-bottom: 4px; background-color: #fbfafa; border: 1px solid;" value="${user.bs_addr }"><br>
					<input type="text" id="dt_addr" name="dt_addr" style="width: 400px;" value="${user.dt_addr }">
			  	</td>
			</tr>
			<tr>
				<th>백신접종</th>
			  	<td>
			    	<select id="vaccine" name="vaccine">
			      		<c:if test="${user.vaccine == '미접종' }"><option value="미접종" selected="selected">미접종</option></c:if>
			      		<c:if test="${user.vaccine == '화이자-1차' }"><option value="화이자-1차" selected="selected">화이자-1차</option></c:if>
			      		<c:if test="${user.vaccine == '화이자-2차' }"><option value="화이자-2차" selected="selected">화이자-2차</option></c:if>
			      		<c:if test="${user.vaccine == '모더나-1차' }"><option value="모더나-1차" selected="selected">모더나-1차</option></c:if>
			      		<c:if test="${user.vaccine == '모더나-2차' }"><option value="모더나-2차" selected="selected">모더나-2차</option></c:if>
			      		<c:if test="${user.vaccine == 'AZ-1차' }"><option value="AZ-1차" selected="selected">AZ-1차</option></c:if>
			      		<c:if test="${user.vaccine == 'AZ-2차' }"><option value="AZ-2차" selected="selected">AZ-2차</option></c:if>			      		
			      		<option value="미접종">미접종</option>
			      		<option value="화이자-1차">화이자-1차</option>
			      		<option value="화이자-2차">화이자-2차</option>
			      		<option value="모더나-1차">모더나-1차</option>
			      		<option value="모더나-2차">모더나-2차</option>
			      		<option value="AZ-1차">AZ-1차</option>
			      		<option value="AZ-2차">AZ-2차</option>
			    	</select>
			  	</td>
			</tr>
			<tr>
				<td style="text-align: right;" colspan="2">
				 	<button type="submit" class="btn btn-info">수정</button>
				</td>
			</tr>
		</table>
	</form>
</div>

<%@include file="common/footer.jsp"%>

<script>
  function findAddr(){
    new daum.Postcode({
          oncomplete: function(data) {
        	  var roadAddr = data.roadAddress; // 도로명 주소 변수
              var jibunAddr = data.jibunAddress; // 지번 주소 변수
        	  document.getElementById('postcode').value = data.zonecode;
              if(roadAddr !== ''){
                  document.getElementById('bs_addr').value = roadAddr;
              } 
              else if(jibunAddr !== ''){
                  document.getElementById('bs_addr').value = jibunAddr;
              }
              document.getElementById('dt_addr').focus();
          }
      }).open();
  }
  function subChk() {
		if(frm.pw.value != frm.pw2.value){
			alert("비밀번호가 일치하지 않습니다");
			return false;
		}
		return true;
  }
  function pwChk(){
	  var pwAlert = document.getElementById('pwAlert');
	  var pw = document.getElementById('pw').value;
	  var pw2 = document.getElementById('pw2').value;
	  if(pw == pw2){
		  pwAlert.innerHTML = "비밀번호가 일치합니다.";
		  pwAlert.style.color = "#08A600";
	  }else if(pw != pw2){
		  pwAlert.innerHTML = "비밀번호가 일치하지 않습니다.";
		  pwAlert.style.color = "red";
	  }
  }
var obj = {};
$("select").children("option").each(function(){
 let val = $(this).attr("value");
 if(obj[val]){
   if($(this).is(":selected")){
    obj[val].remove();
    obj[val] = $(this);
   }else if(obj[val].is(":selected")){
    $(this).remove()
   }else{
    $(this).remove();
   }
 }
 obj[val] = $(this);
});	
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</body>
</html>