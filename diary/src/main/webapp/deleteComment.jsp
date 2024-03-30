<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("utf-8");

	String diaryDate = request.getParameter("diaryDate");
	
	System.out.println(diaryDate + "<--diaryDate");
	
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	
	System.out.println(commentNo +"<--commentNo");
	
	Class.forName("org.mariadb.jdbc.Driver");
	String sql = "DELETE FROM comment WHERE comment_no=?";
	Connection con = null;
	PreparedStatement stmt= null; 
	ResultSet rs = null;
	con = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "guswhd6656");
	stmt = con.prepareStatement(sql);
	stmt.setInt(1, commentNo);
	//디버깅
	System.out.println(stmt);
	
	int row = stmt.executeUpdate();
	
	response.sendRedirect("./diaryOne.jsp?diaryDate=" + diaryDate);
	
%>