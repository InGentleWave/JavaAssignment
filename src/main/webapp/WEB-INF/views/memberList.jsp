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
	<table>
		<thead>
			<tr>
				<td colspan="5" >
					<div class="btn-right">
				    	<button type="button" id="addMemberBtn" style="margin:3px;">회원추가</button>
				    </div>
				</td>
			</tr>
			<tr>
				<th>ID</th>
				<th>비밀번호</th>
				<th>이 름</th>
				<th>전화</th>
				<th>주 소</th>
			</tr>
		</thead>
		<tbody id="memberListTable">
			<!-- 동적으로 내용 추가하는 부분 -->
		</tbody>
		
	</table>
	<script>
		const contextPath = '${pageContext.request.contextPath}';
	</script>
	<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
	<script>
		$(function(){
			renderMemberList();
		})
		function renderMemberList(){
			let html = "";
			fetch(contextPath+"/list.do",{
				headers: {
				    "X-Requested-With": "XMLHttpRequest" // 핵심 헤더 추가
				}
			})
				.then(res => res.json())
				.then(data => {
					data.forEach(member =>{
						html +=`
							<tr>
								<td>\${member.memId}</td>
								<td>\${member.memPass}</td>
								<td>\${member.memName}</td>
								<td>\${member.memTel}</td>
								<td>\${member.memAddr}</td>
							</tr>
							`;
					})
					document.querySelector("#memberListTable").innerHTML=html;
				})
				.catch(error =>{
					console.error("에러 발생 =>", error);
				});
		}
	</script>
</body>
</html>