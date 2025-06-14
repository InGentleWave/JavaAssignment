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
.detail{

}
.update{
	display:none;
}
</style>
</head>
<body>
	<form action="${pageContext.request.contextPath }/update.do" method="post">
		<table>
			<tr class="detail">
				<th>회원ID</th><td><c:out value='${data.memId}'/></td>
			</tr>
			<tr class="update">
				<th>회원ID</th><td><input type="text" id="memId" name="memId" value="<c:out value='${data.memId}'/>" required>
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
						<button type="reset" class="btn">취소</button>
						<button type="button" id="memberListBtn" class="btn">회원목록</button>
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
			})
			
		// 유효성 검사 체크용 변수 및 함수
			// 유효성 검사 체크용 변수
			let isPwCheckOk = false;
			let isIdAvailable = false;
			const submitBtn = document.querySelector("#submitBtn");
			// 유효성 검사 전 제출 버튼 비활성화
			submitBtn.disabled = true;
			// 유효성 검사 후 제출 버튼 활성화 함수
			function isInputOk(){
				if( isPwCheckOk && isIdAvailable ){
					submitBtn.disabled = false;
				} else {
					submitBtn.disabled = true;
				}
			}
			// 취소(리셋) 버튼 클릭 시 tr-hidden 숨기기, 저장 버튼 비활성화
			document.querySelector("button[type='reset']").addEventListener("click",function(){
				document.querySelector("#tr-id-hidden").style.display="none";
				document.querySelector("#tr-pw-hidden").style.display="none";
				document.querySelector("#tr-file-hidden").style.display="none";
				submitBtn.disabled = true;
			})
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
			// 비밀번호 및 비밀번호 확인 작성시 실시간 유효성 검사
			document.querySelector("#memPass").addEventListener("input",pwCheckMsg)
			document.querySelector("#passwordCheck").addEventListener("input",pwCheckMsg)
			// ID 사용가능 여부 출력용 함수
			function idAvailableMsg(data){
				const idAvailableMsg = document.querySelector("#idAvailableMsg");
				const msgStyle = idAvailableMsg.style;
				let msg="";
				if(data === "empty"){
					msgStyle.color = "red";
					msg = "아이디를 입력 후 중복확인이 가능합니다.";
					isIdAvailable = false;
				} else if(data){
					msgStyle.color = "green";
					msg = "사용 가능한 아이디입니다."
					isIdAvailable = true;
				} else {
					msgStyle.color = "red";
					msg ="사용할 수 없는 아이디입니다.";
					isIdAvailable = false;
				}
				
				idAvailableMsg.innerText = msg;
				document.querySelector("#tr-id-hidden").style.display="table-row";
				// 유효성 검사
				isInputOk();
			}
			// ID 중복확인 버튼에 비동기 요청 이벤트 설정하기
			document.querySelector("#isIdAvailableBtn").addEventListener("click",function(){
				const memId = document.querySelector("#memId").value;
				// 아이디 미입력 시 출력 및 함수 종료
				if(memId==null||memId===""){
					idAvailableMsg("empty");
					document.querySelector("#memId").focus();
					return;
				}
				// 아이디 중복 검사 비동기 요청
				fetch(contextPath + "/insert.do?memId="+memId,{
					headers :{
						'Content-Type':'application/json',
						'X-Requested-With' : 'XMLHttpRequest'
					}
				})
					.then(res=>res.json())
					.then(function(data){
						// 결과 출력
						idAvailableMsg(data.isIdAvailable);
					})
					.catch(error => console.error(error))
			});
			// 회원목록 버튼 이벤트 설정(클릭 시 리스트 화면으로 이동)
			document.querySelector("#memberListBtn").addEventListener("click",function(){
				window.location.href=contextPath+"/list.do";
			});
			// 등록 실패 시 알림과 함께 요소 채우기
			if("${msg}"&&"${msg}" === "회원 등록에 실패했습니다."){
				alert("${msg}");
			}
		})
	</script>
</body>
</html>