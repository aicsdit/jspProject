<%@page import="cs.dit.LoginDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	
	LoginDao dao = new LoginDao();
	int i = dao.loginCheck(id, pwd);
	if(i==1){
		session.setAttribute("id", id);
		response.sendRedirect("welcome.jsp");
	}else{
		out.println("유효한 사용자가 아닙니다.");
	}
%>

