<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사용자 입력</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
	
</head>
<body>
	<div class="container">
		<br>
		<h2 class="text-center font-weight-bold">로그인</h2>
		<hr/>
<% String id = (String)session.getAttribute("id");
	if(id!=null){
%>    
		<form action="logout.jsp" method="post">
		 <%=(String)session.getAttribute("id") %>님 로그인
	      <input type="submit" class="btn btn-secondary"  value="로그아웃">
				<button type="button" class="btn btn-secondary" onclick="location.href='updateForm.jsp?id=<%=id%>'">회원정보 수정</button>
		</form>
<%}else{ %>		
		
		<form action="loginPro.jsp" method="post">
		  <div class="form-group">
	      <label for="id">ID:</label>
	      <input type="text" class="form-control" id="id" name="id">
	    </div>
	    <div class="form-group">
	      <label for="pwd">PASSWORD:</label>
	      <input type="password" class="form-control" id="pwd" name="pwd">
	    </div>
	    <br>
	    <div class="text-center">
				<button  type="submit" class="btn btn-secondary">로그인</button>
				<button  type="button" class="btn btn-secondary" onclick="location.href='insertForm.jsp'">회원가입</button>
			</div>
		</form>
<%} %>
	</div>
</body>
</html>


