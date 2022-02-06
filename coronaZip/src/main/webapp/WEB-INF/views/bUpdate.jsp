<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="common/header.jsp"%>

<c:if test="${empty user }">
	<script type="text/javascript">
		alert("커뮤니티는 로그인 후에 이용할수있습니다.");
		location.href='index';
	</script>
</c:if>

<script type="text/javascript" src="/smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<style>
	.fileBox .fileName {
		display:inline-block;
		width:170px;
		height:30px;
		padding-left:10px;
		margin-right:5px;
		line-height:30px;
		border:1px solid #aaa;
		background-color:#fff;
		vertical-align:middle;
		border-radius: 10px;
	}
	.fileBox .btn_file {
		display:inline-block;
		border:2px solid #66677f;
		border-top-width: 0px;
		border-left-width: 0px;
		width:100px;
		height:30px;
		line-height:30px;
		text-align:center;
		vertical-align:middle;
		background-color: #3C3530;
		color:white;
		border-radius: 6px;
	}
	.fileBox input[type="file"] {
		position:absolute;
		width:1px;
		height:1px;
		padding:0;
		margin:-1px;
		overflow:hidden;
		clip:rect(0,0,0,0);
		border:0
	}
	 .fbtn{
	   display:inline-block;
		border:2px solid #66677f;
		border-top-width: 0px;
		border-left-width: 0px;
		width:50px;
		height:30px;
		line-height:30px;
		text-align:center;
		vertical-align:middle;
		background-color: #3C3530;
		color:white;
		border-radius: 6px;
	 }
	 iframe {
	 	height: 442px;
	 }
</style>

<%@include file="common/menu.jsp"%>

<div style="margin: 30px 0px 90px 0px;">
	<h2 style="font-weight: bold; text-align: center;">글 작성</h2>
	<p style="color: #918f8f; text-align: center; margin-bottom: 20px;">글 내용에 맞는 게시판을 선택하여 글을 작성해주세요.</p>
	<form action="bUpdate" method="post" id="frm" style="text-align: center; width: 80%; margin: 0 auto;">
		<input type="hidden" name="id" value="${user.id }">
		<input type="hidden" name="b_nickname" value="[${user.vaccine }]${user.nickname }">
		<input type="hidden" name="b_idx" value="${board.b_idx}">
		<input type="hidden" name="currentPage" value="${currentPage}">
		<div>
			<select name="b_type" style="width: 18%; height: 35px;">
				<c:if test="${board.b_type == 0 }"><option value="0" selected="selected">코로나 증상</option></c:if>
				<c:if test="${board.b_type == 1 }"><option value="1" selected="selected">백신 후기</option></c:if>
				<c:if test="${board.b_type == 2 }"><option value="2" selected="selected">자유게시판</option></c:if>
				<option value="0">코로나 증상</option>
				<option value="1">백신 후기</option>
				<option value="2">자유게시판</option>
			</select>
			<input type="text" name="b_title" placeholder="제목" style="width: 81%; height: 35px;" value="${board.b_title }">
		</div>
		<div style="float: right; margin: 5px 0px;">
			<div class="fileBox">
				<input type="text" class="fileName" readonly="readonly" value="${board.b_upload }">
				<label for="uploadBtn" class="btn_file">파일 업로드</label>
				<input type="file" id="uploadBtn" class="uploadBtn" name="file1">
				<label class="fbtn" onclick="fdel()">제거</label>
			</div>
		</div>
		<div>
			<textarea id="b_content"  name="b_content" style="width: 100%;">${board.b_content }</textarea>
		</div>
		<div style="float: right;"><input type="button" onclick="save();" value="수정" class="btn btn-info"></div>
	</form>
</div>

<%@include file="common/footer.jsp"%>

<script type="text/javascript">
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
	
	var uploadFile = $('.fileBox .uploadBtn');
	uploadFile.on('change', function(){
		if(window.FileReader){
			var filename = $(this)[0].files[0].name;
		} else {
			var filename = $(this).val().split('/').pop().split('\\').pop();
		}
		$(this).siblings('.fileName').val(filename);
	});
	
	function fdel(){
	    $('.fileName').val('');
		var agent = navigator.userAgent.toLowerCase();
		//파일초기화
		if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
			$("#uploadBtn").replaceWith($("#uploadBtn").clone(true));
		}else{
		    $("#uploadBtn").val("");
		}	
	}
	
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors,
	    elPlaceHolder: "b_content",  //textarea ID 입력
	    sSkinURI: "/smarteditor/SmartEditor2Skin.html?ver=6",  //martEditor2Skin.html 경로 입력
	    fCreator: "createSEditor2",
	    htParams : { 
	        bUseToolbar : true,           // 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
			bUseVerticalResizer : true,  // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
			bUseModeChanger : false       // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
	    }
	});
	
	var frm = document.getElementById("frm");
	function save(){
		oEditors.getById["b_content"].exec("UPDATE_CONTENTS_FIELD", []);  //스마트 에디터 값을 텍스트컨텐츠로 전달
		frm.submit(); // submit
		return; 
	}
</script>

</body>
</html>