<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@include file="common/header.jsp"%>

<c:if test="${empty user }">
	<script type="text/javascript">
		alert("커뮤니티는 로그인 후에 이용할수있습니다.");
		location.href='index';
	</script>
</c:if>


<style>
	.hiddenText {
   		display: none;
	}
	textarea{
		width: 90%;
		resize: none;
	}
	.btn1{
		background-color: white;
		border: 0;
		font-weight: bold;
	}
	.btn{
		background: black;
		color: white;
		border-radius: 10px;
	}
</style>
<script type="text/javascript">
var b = "a";
function re(id) {
	var content2 = document.getElementById(b);
    content2.style.display = "none";
	var a = "a" + id;
	var content = document.getElementById(a);
    content.style.display = "block";
	b=a;
}
function del() {
	const del =  confirm("해당 게시글을 삭제하시겠습니까?");
	if(del){
		location.href='bDelete?b_idx=${board.b_idx }&b_type=${board.b_type}&currentPage=${currentPage}';
	}
}
function redel(id) {
	const redel =  confirm("해당 댓글을 삭제하시겠습니까?");
	var c_idx = id;
	if(redel){
		location.href='reDelete?c_idx='+c_idx+'&b_idx=${board.b_idx }&b_type=${board.b_type}&currentPage=${currentPage}';
	}
}
var cmt = 0;
function remd(c_idx) {
	if(cmt > 0){
		$('#cmt'+cmt).children().css('display','block');
		$('#formCmt'+cmt).remove();
	}
	const id = 'cmt'+c_idx;
	const txt = $('#content'+c_idx).text();
	$('#'+id).children().css('display','none');
	const str = '<form action="reUpdate" method="post" id="formCmt'+c_idx+'" style="width: 90%; margin: 10px auto;">'+  
					'<input type="hidden" name="b_idx" value="${board.b_idx }">'+
					'<input type="hidden" name="c_idx" value="'+c_idx+'">'+
					'<input type="hidden" name="b_type" value="${board.b_type }">'+
					'<input type="hidden" name="currentPage" value="${currentPage}">'+
					'<div style="border: 1px dotted black; ">'+
						'<div style="margin: 11px 0 0 11px;">👤[${user.vaccine }]${user.nickname }</div>'+
			    		'<div style="margin: 10px 0 0 20px;"><textarea name="c_content" id="c_content" maxlength="2000" style="height:100px; border: 0px;" required="required">'+txt+'</textarea></div>'+        
			    		'<div style="margin: 0  0 11px 11px; width: 97px; border: 1px dotted; padding: 5px; border-radius: 10px;">'+
			    			'<input style="padding: 5px;" class="btn" type="submit" value="수정">'+
			    			'<input style="padding: 5px; margin-left: 5px;" class="btn" type="button" onclick="cancel()" value="취소">'+
						'</div>'
				'</form>';
	$('#'+id).append(str);
	cmt = c_idx;
}
function cancel(){
	if(cmt > 0){
		$('#cmt'+cmt).children().css('display','block');
		$('#formCmt'+cmt).remove();
	}
}
</script>

<%@include file="common/menu.jsp"%>

<div id="a"></div>
<div style="margin: 0 auto; width: 90%">
	<h3 style="margin-top: 40px;">
		<c:choose>
			<c:when test="${board.b_type == 0 }">[코로나 증상]</c:when>
			<c:when test="${board.b_type == 1 }">[백신 후기]</c:when>
			<c:otherwise>[자유게시판]</c:otherwise>
		</c:choose>
		${board.b_title}
	</h3>
	<div style="margin-top: 10px;">
		<span>👤${board.b_nickname }</span>
	</div>
	<div style="border: 0; border-bottom: 2px solid black;">
		<span style=" font-size: 13px; color: gray;">${board.b_regdate }</span>
		<span style=" font-size: 13px; color: gray;">조회수 : ${board.b_count }</span>
		<span style=" font-size: 15px; color: gray; float: right;">댓글 <b>${cListTotal}</b></span>
	</div>
	<c:if test="${not empty board.b_upload }">
		<div style="float: left;">
			첨부파일 : <a href="fileDownLoad?fileName=${board.b_upload}" style="text-decoration: none; color: black;">📁${fn:substringAfter(board.b_upload, '_') }</a>
		</div>
	</c:if>
	<div style="float: right;">
		<c:if test="${board.id == user.id }">
			<button class="btn btn-info" onclick="location.href='bUpdate?b_type=${board.b_type }&b_idx=${board.b_idx }&currentPage=${currentPage}'" style="background-color: #9acad8;">수정</button>
			<button class="btn btn-info" onclick="del()" style="background-color: #9acad8;">삭제</button>
		</c:if>
		<button class="btn btn-info" onclick="location.href='board?currentPage=${currentPage}&b_type=${board.b_type }'" style="background-color: #9acad8;">목록</button>
	</div>
	<div style="min-height: 300px;margin-top: 40px;">${board.b_content }</div>
	
	<div style="border-top: 2px solid black; margin-top: 40px;">
		<c:forEach var="comment" items="${cList}">
			<div id="cmt${comment.c_idx }">
				<c:if test="${comment.re_level > 0 }">
					<img src="img/level.gif" width="${comment.re_level*10 }">
					<img src="img/re.gif">
					<span style="margin: 11px 0 0 0;">👤[${comment.c_vaccine}]${comment.c_nickname }</span>
				</c:if> 
				<c:if test="${comment.re_level == 0 }">
					<div style="margin: 11px 0 0 11px;">👤[${comment.c_vaccine}]${comment.c_nickname }</div>
				</c:if>
				<div style="margin-left: ${comment.re_level*15 }px; ">
					<div style="margin: 5px 0 0 11px;" id="content${comment.c_idx }">${comment.c_content }</div>
					<div style="font-size: 13px; color: gray; margin: 0  0 5px 11px;">${comment.c_regdate }</div>
					<div style="margin: 0  0 11px 0; border-bottom: 1px dotted;">
						<input style="margin-left: 11px" class="btn1" type="button" value="답글" onclick="re(${comment.c_idx})">
						<c:if test="${comment.id == user.id }">
							<input class="btn1" type="button" value="수정" onclick="remd(${comment.c_idx })">
						</c:if>
						<c:if test="${comment.id == user.id}">
							<input class="btn1" type="button" value="삭제" onclick="redel(${comment.c_idx })">
						</c:if>
					</div>
				</div>
			</div>
			
			<div style="margin-left: ${comment.re_level*15 }px; ">
				<div class="hiddenText" id="a${comment.c_idx }">
					<form action="reWrite" method="post" name="frm1" id="frm1">
						<input type="hidden" name="c_nickname" value="${user.nickname }">
						<input type="hidden" name="id" value="${user.id }">
						<input type="hidden" name="b_idx" value="${board.b_idx }">
						<input type="hidden" name="c_idx" value="${comment.c_idx }">
						<input type="hidden" name="b_type" value="${board.b_type }">
						<input type="hidden" name="ref" value="${comment.ref }">
						<input type="hidden" name="re_level" value="${comment.re_level }">
						<input type="hidden" name="re_step" value="${comment.re_step }">
						<input type="hidden" name="c_vaccine" value="${user.vaccine}">
						<input type="hidden" name="currentPage" value="${currentPage}">
						<span><img src="img/re.gif"></span>
						<span style="margin: 11px 0 0 0;">👤[${user.vaccine }]${user.nickname }</span>
						<div style="margin: 11px 0 0 11px;"><textarea name="c_content" id="c_content" maxlength="2000" style="height:100px;" required="required" placeholder="댓글을 입력해주세요"></textarea></div>
						<div style="margin: 0  0 11px 11px;"><input style="padding: 5px;" class="btn" type="submit" value="등록"></div>
					</form>
				</div>	    
			</div>
		</c:forEach>
		
		<form action="reWrite" method="post" name="frm2">  
			<input type="hidden" name="c_nickname" value="${user.nickname }">
			<input type="hidden" name="id" value="${user.id }">
			<input type="hidden" name="b_idx" value="${board.b_idx }">
			<input type="hidden" name="c_idx" value="${c_idx }">
			<input type="hidden" name="b_type" value="${board.b_type }">
			<input type="hidden" name="ref" value="${ref }">
			<input type="hidden" name="re_level" value="${re_level }">
			<input type="hidden" name="re_step" value="${re_step }">
			<input type="hidden" name="c_vaccine" value="${user.vaccine}">
			<input type="hidden" name="currentPage" value="${currentPage}">
			<div style="border: 1px dotted black; ">
				<div style="margin: 11px 0 0 11px;">👤[${user.vaccine }]${user.nickname }</div>
				<div style="margin: 20px 0 0 20px;"><textarea name="c_content" id="c_content" maxlength="2000" style="height:100px; border: 0px;" required="required" placeholder="댓글을 입력해주세요"></textarea></div>        
				<div style="margin: 0  0 11px 11px; width: 56px; border: 1px dotted; padding: 5px; border-radius: 10px;"><input style="padding: 5px;" class="btn" type="submit" value="등록"></div>
			</div>
		</form>	
	</div>
</div>

<%@include file="common/footer.jsp"%>

</body>
</html>