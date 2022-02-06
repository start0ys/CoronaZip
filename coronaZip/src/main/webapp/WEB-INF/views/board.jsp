<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="common/header.jsp"%>

<style>
	td>a, w3-border>a{
		text-decoration: none;
		color:black;
	}
	th{ 
    	background-color:#6c6b6b;
    	border-top:solid 2px #aaaaaa;
    	color: white;
    	text-align: center;
	}
	tr{
		height:30px; 
	}
	td{
		border-bottom:solid 1px #dddddd;
	}
</style>

<%@include file="common/menu.jsp"%>

<div>
	<div style="margin: 37px 0px; text-align: center;">
		<c:if test="${b_type == 0 }">
			<h2 style="font-weight: bold;"><i class="fas fa-head-side-virus"></i> &nbsp;코로나 증상</a></h2>
			<p style="color: #918f8f;">코로나 증상에 대하여 회원들과 정보를 공유해보세요.</p>
		</c:if>
		<c:if test="${b_type == 1 }">
			<h2 style="font-weight: bold;"><i class="fas fa-comment-medical"></i> &nbsp;백신 후기</a></h2>
			<p style="color: #918f8f;">백신 접종에 관하여 회원들과 정보를 공유해보세요.</p>
		</c:if>
		<c:if test="${b_type == 2 }">
			<h2 style="font-weight: bold;"><i class="fas fa-users"></i> &nbsp;자유게시판</a></h2>
			<p style="color: #918f8f;">회원들과 다양한 소통을 해보세요.</p>
		</c:if>
	</div>
	
	<table style="text-align: center;margin: 0 auto; width: 100%; border-collapse:collapse;">
		<tr>
			<th>제목</th><th>작성자</th><th>작성일</th><th>조회수</th>
		</tr>
		<c:forEach var="board" items="${boardList }"> 
			<tr>
				<td style="width: 60%;  font-size: 16px; text-align: initial;">
					<a style="margin-left: 20px;" href="bView?b_idx=${board.b_idx}&b_type=${b_type}&currentPage=${currentPage}">${board.b_title }</a>
				</td>
				<td style="width: 20%;">👤${board.b_nickname }</td>
				<td style="width: 10%;">${board.b_regdate }</td>
				<td style="width: 10%;">${board.b_count }</td>
			</tr>
		</c:forEach>
	</table>
	
	<div style="float: right;">
		<button class="btn btn-info" onclick="location.href='bWrite?b_type=${b_type }'" style="background-color: #9acad8;">✏️작성</button>
	</div>
	
	<div class="w3-center" style="margin-left: 92.15px;">
		<div class="w3-bar w3-border" style=" margin: 10px 0px;border: 1px solid #7d97a5;">
			<c:if test="${pg.startPage > pg.pageBlock }">
				<a href="board?currentPage=${pg.startPage-pg.pageBlock}&b_type=${b_type}" class="w3-bar-item w3-button">&laquo;</a>
			</c:if>
			<c:forEach var="i" begin="${pg.startPage }" end="${pg.endPage }">
				<c:if test="${pg.currentPage == i }">
					<a href="board?currentPage=${i}&b_type=${b_type}" class="w3-bar-item w3-button" style="background-color: #6c6b6b; color: white;">${i}</a>
				</c:if>
				<c:if test="${pg.currentPage != i }">
					<a href="board?currentPage=${i}&b_type=${b_type}" class="w3-bar-item w3-button">${i}</a>
				</c:if>
			</c:forEach>
			<c:if test="${pg.endPage < pg.totalPage }">
				<a href="board?currentPage=${pg.startPage+pg.pageBlock}&b_type=${b_type}" class="w3-bar-item w3-button">&raquo;</a>
			</c:if>
		</div>
	</div>
</div>

<%@include file="common/footer.jsp"%>

</body>
</html>