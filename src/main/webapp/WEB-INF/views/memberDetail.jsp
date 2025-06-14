<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table, th, td{
	border: 1px solid blue;
	border-collapse: collapse;
}
#form-update{
	display:none;
}
#tr-file-hidden, #tr-pw-hidden {
	display:none;
}
.btn{
	margin-right: 10px;
	cursor: pointer;
}
.btn:disabled {
	cursor: default;
}
.hiddenMsg{
	color:red;
	text-align: center;
	font-size : 10pt;
}
</style>
</head>
<body>
	<table id="table-detail">
		<tr>
			<td colspan="2" style="text-align:center;color:red;">프로필 사진 미구현</td>
		</tr>
		<tr>
			<th>회원ID</th><td><c:out value='${data.memId}'/></td>
		</tr>
		<tr>
			<th>비밀번호</th><td><c:out value='${data.memPass}'/></td>
		</tr>
		<tr>
			<th>회원이름</th><td><c:out value='${data.memName}'/></td>
		</tr>
		<tr>
			<th>전화번호</th><td><c:out value='${data.memTel}'/></td>
		</tr>
		<tr>
			<th>회원주소</th><td><c:out value='${data.memAddr}'/></td>
		</tr>
		<tr>
			<td colspan='2'>
				<div style="display:flex; justify-content:center;">
					<button type="button" class="btn" id="updateBtn">수정</button>
					<button type="button" class="btn" id="deleteBtn">삭제</button>
					<button type="button" class="btn memberListBtn">회원목록</button>
				</div>
			</td>
		</tr>
	</table>
	<form action="${pageContext.request.contextPath }/update.do" method="post" id="form-update">
		<table>
			<tr>
				<td colspan="2" style="text-align:center;color:red;">프로필 사진 미구현</td>
			</tr>
			<tr>
				<th>회원ID</th><td><c:out value='${data.memId}'/></td>
			</tr>
			<tr>
				<th>비밀번호</th><td><input type="text" id="memPass" name="memPass" class="text" required></td>
			</tr>
			<tr>
				<th>비밀번호 확인</th><td><input type="text" id="passwordCheck"  class="text"  required></td>
			</tr>
			<tr id="tr-pw-hidden" class="tr-hidden">
				<td id="pwCheckMsg" class="hiddenMsg" colspan='2'>
					<!-- 비밀번호 확인 여부를 동적으로 표시할 부분 -->
				</td>
			</tr>
			<tr>
				<th>회원이름</th><td><input type="text" name="memName"  class="text" value="<c:out value='${data.memName}'/>" required></td>
			</tr>
			<tr>
				<th>전화번호</th><td><input type="text" name="memTel"  class="text" value="<c:out value='${data.memTel}'/>" required></td>
			</tr>
			<tr>
				<th>회원주소</th><td><input type="text" name="memAddr"  class="text" value="<c:out value='${data.memAddr}'/>" required></td>
			</tr>
			<tr>
				<th>프로필 사진</th><td><input type="file" name="memPhoto">
			</tr>
			<tr id="tr-file-hidden" class="tr-hidden">
				<td class="hiddenMsg" colspan='2'>
					미구현
				</td>
			</tr>
			<tr>
				<td colspan='2'>
					<div style="display:flex; justify-content:center;">
						<button type="submit" class="btn" id="submitBtn">저장</button>
						<button type="button" class="btn" id="cancleBtn">취소</button>
						<button type="button" class="btn memberListBtn">회원목록</button>
					</div>
				</td>
			</tr>
		</table>
	</form>
	<script>
		const contextPath = '${pageContext.request.contextPath}';
	</script>
	<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
	<script>
		document.addEventListener("DOMContentLoaded",function(){
			console.log("문서 로드 완료");
			// 첨부파일 미구현
			document.querySelector("input[type='file']").addEventListener("click", function(e){
				e.preventDefault();
				let trHiddenStyle = document.querySelector("#tr-file-hidden").style;
				// 메세지 출력
				trHiddenStyle.display="table-row";
				// 일정 시간 후 숨김
				setTimeout(function(){
					trHiddenStyle.display="none";
				},1100);
			});
			// 이벤트 위임
			document.addEventListener("click",function(e){
				const memId = "${data.memId}";
				if(e.target.id ==="updateBtn"){
					e.preventDefault();
					document.querySelector("#table-detail").style.display="none";
					document.querySelector("#form-update").style.display="block";
				} else if(e.target.id ==="deleteBtn"){
					if(confirm("회원 정보를 삭제할까요?")){
						window.location.href=contextPath+"/delete.do?memId="+memId;
					} 
				} else if(e.target.classList.contains("memberListBtn")){
					e.preventDefault();
					window.location.href=contextPath+"/list.do";
				} else if(e.target.id === "cancleBtn"){
					e.preventDefault();
					document.querySelector("#table-detail").style.display="table-row";
					document.querySelector("#form-update").style.display="none";
				}
			});
			document.addEventListener("input",function(e){
				// 비밀번호 및 비밀번호 확인 작성시 실시간 유효성 검사
				if(e.target.id ==="memPass"||e.target.id ==="passwordCheck"){
					e.preventDefault();
					pwCheckMsg();
				}
			});
			
		// 유효성 검사 체크용 변수 및 함수
			// 유효성 검사 체크용 변수
			let isPwCheckOk = false;
			const submitBtn = document.querySelector("#submitBtn");
			// 유효성 검사 전 제출 버튼 비활성화
			submitBtn.disabled = true;
			// 유효성 검사 후 제출 버튼 활성화 함수
			function isInputOk(){
				if( isPwCheckOk ){
					submitBtn.disabled = false;
				} else {
					submitBtn.disabled = true;
				}
			}
			// 취소(리셋) 버튼 클릭 시 tr-hidden 숨기기, 저장 버튼 비활성화
			document.querySelector("button[type='reset']").addEventListener("click",function(){
				document.querySelector("#tr-pw-hidden").style.display="none";
				document.querySelector("#tr-file-hidden").style.display="none";
				submitBtn.disabled = true;
			});
			// 비밀번호 확인 여부 출력용 함수
			function pwCheckMsg(){
				const pwCheckMsg = document.querySelector("#pwCheckMsg");
				const msgStyle = pwCheckMsg.style;
				let pw = document.querySelector("#memPass").value;
				let pwCk = document.querySelector("#passwordCheck").value;
				let pwCheck = pw === pwCk ? true : false;
				// 비밀번호 확인란 입력시에만 함수 적용
				if(pwCk === ""){
					isPwCheckOk = false;
					document.querySelector("#tr-pw-hidden").style.display="none";
					isInputOk();
					return;
				}
				// 메세지 출력
				let msg="";
				if(pwCheck){
					msgStyle.color = "green";
					msg = "비밀번호와 일치합니다."
					isPwCheckOk = true;
				} else {
					msgStyle.color = "red";
					msg ="비밀번호와 일치하지 않습니다.";
					isPwCheckOk = false;
				}
				
				pwCheckMsg.innerText = msg;
				document.querySelector("#tr-pw-hidden").style.display="table-row";
				// 유효성 검사
				isInputOk();
			}
			
			// 등록 실패 시 알림과 함께 요소 채우기
			if("${msg}"&&"${msg}" === "회원 등록에 실패했습니다."){
				alert("${msg}");
			}
		});
	</script>
</body>
</html>