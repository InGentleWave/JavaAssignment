<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table, th, td{
	border: 1px solid blue;
}
.btn-right {
	display: flex;
  	justify-content: flex-end; /* 오른쪽 정렬 */
}
</style>
</head>
<body>
	<form>
		<table>
			<tr>
				<td colspan="5" >
					<div class="btn-right">
				    	<button type="button" id="addMemberBtn" style="margin:3px;">회원추가</button>
				    </div>
				</td>
			</tr>
			<tr>
				<th>회원ID</th><td><input type="text" id="memId" name="memId"><input type="button" value="중복확인" id="isIdAvailableBtn"></td>
			</tr>
			<tr>
				<th>비밀번호</th><td><input type="text" id="password" name="memPass"></td>
			</tr>
			<tr>
				<th>비밀번호 확인</th><td><input type="text" id="passwordCheck"></td>
			</tr>
			<tr>
				<th>회원이름</th><td><input type="text" name="memName"></td>
			</tr>
			<tr>
				<th>전화번호</th><td><input type="text" name="memTel"></td>
			</tr>
			<tr>
				<th>회원주소</th><td><input type="text" name="memAddr"></td>
			</tr>
			<tr>
				<th>프로필 사진</th><td><input type="file">
			</tr>
			<tr>
				<div>
					<button type="submit">저장</button>
					<button type="reset">취소</button>
					<button type="button" id="memberListBtn">회원목록</button>
				</div>
			</tr>
	</table>
	</form>
	<script>
		const contextPath = '${pageContext.request.contextPath}';
	</script>
	<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
	<script>
		$(function(){
			$(document).off("click","#isIdAvailableBtn").on("click","#isIdAvailableBtn",function(){
				const memId = document.querySelector("#memId").value;
				fetch(contextPath + "/insert.do",{
					headers :{
						'Content-Type':'application/json',
						'X-Requested-With' : 'XMLHttpRequest'
					},
					body : JSON.stringify({key:memId})
				})
			});
		})
	</script>
</body>
</html>