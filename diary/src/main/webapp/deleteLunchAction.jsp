<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*"%>
<%
	String  lunchDate=request.getParameter("=lunchDate");
	
	String sql="DELETE FROM lunch WHERE lunch_date = ?";
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn =DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "guswhd6656");
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1 , lunchDate);
	int row = stmt.executeUpdate();
	
	if(row==1) {  
		response.sendRedirect("/diary/diary.jsp");
	}else{
		response.sendRedirect("/diary/lunchOne.jsp");
	}
	

%>