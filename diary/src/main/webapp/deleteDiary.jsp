<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*"%>
<%
	String diaryDate =request.getParameter("diaryDate");
	
	String sql="delete from diary where diary_Date=?";
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn =DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "guswhd6656");
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1 , diaryDate);
	int row = stmt.executeUpdate();
	
	if(row==1) {  
		response.sendRedirect("/diary/diaryList.jsp?");
	}

%>