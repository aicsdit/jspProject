<%@page import="cs.dit.LoginDao"%>
<%@page import="cs.dit.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import ="java.sql.*" %>
<%	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id"); 
	String name = request.getParameter("name"); 
	String pwd = request.getParameter("pwd"); 

	LoginDto dto = new LoginDto(id, name, pwd);
	new LoginDao().update(dto);

%>

<script>
	let ans = alert("변경되었습니다!");
	if (!ans){
		location.href='list.jsp';
	}
</script>

