<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	page import ="java.sql.*"%>
<%
	//session.removeAttribute("loginMember");	


	System.out.println(session.getId()+"<--session.invalidate()호출전");
	session.invalidate(); // 세션공간을 초기화 하였다.(포맷))

	response.sendRedirect("/diary/loginForm.jsp");
 %>