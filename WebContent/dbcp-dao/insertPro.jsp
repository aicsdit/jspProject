<%@page import="cs.dit.LoginDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   
   <fmt:requestEncoding value="utf-8"/>
   <c:set var="id" value="${param.id}"/>
   <c:set var="name" value="${param.name}"/>
   <c:set var="pwd" value="${param.pwd}"/>
   
   <jsp:useBean id="dto" class="cs.dit.LoginDto">
   	<jsp:setProperty name="dto" property="id" value="${id}"/>
   	<jsp:setProperty name="dto" property="name" value="${name}"/>
   	<jsp:setProperty name="dto" property="pwd" value="${pwd}"/>
   </jsp:useBean>
<%
	LoginDao dao = new LoginDao();
	dao.insert(dto);
	response.sendRedirect("list.jsp");
%>
