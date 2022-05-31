<%@page import="cs.dit.LoginDto"%>
<%@page import="cs.dit.LoginDao"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix ="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>  
<%
	//ArrayList<LoginDto> dtos = new LoginDao().list();
	LoginDao dao = new LoginDao();
	ArrayList<LoginDto> dtos = dao.list();
	pageContext.setAttribute("dtos", dtos);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사용자 목록</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container"><br>	
	<h1 class="text-center font-weight-bold">로그인 정보</h1>
	<br>
	<table class="table table-hover">
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>비밀번호</th>
		</tr>

		<c:forEach var='dto' items='${dtos}'>
			<tr>
				<td><a href="updateForm.jsp?id=${dto.id }">${dto.id }</a></td>
				<td>${dto.name}</td>
				<td>${dto.pwd}</td>
			</tr>
		</c:forEach>
	</table>
	</div>	
</body>
</html>