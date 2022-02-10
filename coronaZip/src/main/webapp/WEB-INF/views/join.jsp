<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="common/header.jsp"%>

<c:if test="${not empty user }">
	<script type="text/javascript">
		alert("로그인 상태로는 회원가입을 이용할수없습니다.");
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
	<form action="/join" method="post" name="frm" onsubmit="return subChk()">
		<div style="margin: 37px 0px;">
			<h2 style="font-weight: bold;">회원가입</h2>
			<p style="color: #918f8f;">회원가입을 통해 회원들과 다양한 코로나 정보를 공유해보세요.</p>
		</div>  
		<table style="border: none; margin: 0 auto; width: 80%;" border="1">
			<tr><th>이름</th><td><input type="text" name="name" required="required" style="margin-left: 7px;"></td></tr>
			<tr>
				<th>생년월일</th>
				<td>
					<input type="text" name="birth" maxlength="6" required="required" style="margin-left: 7px;">
					<span style="margin-left: 17px; font-size: 13px; color: #adacac;">ex)960307</span>
				</td>
			</tr>
			<tr>
				<th>성별</th>
			  	<td>
			    	<input type="radio" name="sex" value="남자" style="margin-left: 10px;">남자&nbsp;&nbsp;
			    	<input type="radio" name="sex" value="여자">여자
			  	</td>
			</tr>
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" id="id" name="id" required="required" style="margin-left: 7px;">
					<input type="hidden" id="sameChk" name="sameChk" value="0">
					<input type="button" value="✔️중복확인" onclick="idChk()">
				 	<span id="idAlert"></span>
				</td>
			</tr>
			<tr><th>비밀번호</th><td><input type="password" id="pw" name="pw" required="required" style="margin-left: 7px;"></td></tr>
			<tr>
				<th>비밀번호 확인</th>
				<td>
				 	<input type="password" id="pw2" name="pw2" required="required" onkeyup="pwChk()" style="margin-left: 7px;">
				 	<span id="pwAlert"></span>
				</td>
			</tr>
			<tr><th>닉네임</th><td><input type="text" name="nickname" required="required" style="margin-left: 7px;"></td></tr>
			<tr><th>이메일</th><td><input type="email" name="email" required="required" style="margin-left: 7px;"></td></tr>
			<tr>
			 	<th>주소</th>
			  	<td style="padding: 7px 0px;">
					<input type="text" id="postcode" name="postcode" readonly="readonly" placeholder="우편번호" style="margin-left: 7px; width: 90px; background-color: #fbfafa; border: 1px solid;">
					<input type="button" value="🔍️주소검색" onclick="findAddr()"><br>
					<input type="text" id="bs_addr" name="bs_addr" readonly="readonly" placeholder="주소" style="margin-left: 7px; width: 400px; margin-top: 4px; margin-bottom: 4px;background-color: #fbfafa; border: 1px solid;"><br>
					<input type="text" id="dt_addr" name="dt_addr" placeholder="상세주소" required="required" style="margin-left: 7px; width: 400px;">
			  	</td>
			</tr>
			<tr>
				<th>백신접종</th>
			  	<td>
			    	<select style="margin-left: 7px;" id="vaccine" name="vaccine" onchange="vc()" required="required">
			      		<option value="선택" selected="selected">선택</option>
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
				 	<button type="submit" class="btn btn-info">가입</button>
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
		if(!frm.sex.value){
			alert("성별을 선택해주세요");
			return false;
		}
		if(!frm.postcode.value){
			alert("주소를 작성해주세요");
			return false;
		}
		if(frm.vaccine.value == '선택'){
			alert("백신접종 여부를 선택해주세요");
			return false;
		}
		if(frm.pw.value != frm.pw2.value){
			alert("비밀번호가 일치하지 않습니다");
			return false;
		}
		if(frm.sameChk.value == 0){
			alert("아이디 중복체크를 확인해주세요");
			return false;
		}
		return true;
  }
  function vc(){
	  $("#vaccine option[value='선택']").remove();
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
  function idChk(){
	  if(!frm.id.value){
		  $('#idAlert').html("아이디를 입력하지 않았습니다.");
    	  $('#idAlert').css('color','red');
	  }else{
		 $.ajax({
	          url : "/idChk",
	          type : "POST",
	          dataType :"JSON",
	          data : {"id2" : $("#id").val()},
	          success : function (data) {
	              if(data == 0) {
	            	  $('#idAlert').html("사용 가능한 아이디입니다.");
	            	  $('#idAlert').css('color','#08A600');
	            	  $("#sameChk").val('1');
	              }else {
	            	  $('#idAlert').html("중복된 아이디가 존재합니다.");
	            	  $('#idAlert').css('color','red');
	              }
	          }

	      })  
	  }
  }
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</body>
</html>