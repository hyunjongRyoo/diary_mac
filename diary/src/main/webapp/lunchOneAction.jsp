<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<% 
	String lunchDate=request.getParameter("lunchDate");
	String menu= request.getParameter("menu");
	//디버깅 코드
	System.out.println(menu+"<--lunchDate");
	System.out.println(menu+"<--menu");
	
	String sql = "INSERT INTO lunch(lunch_date,menu,update_date,create_date) VALUES(?, ?, NOW(), NOW())";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn =DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "guswhd6656");
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, lunchDate);
	stmt.setString(2, menu);
	System.out.println(stmt);
	
	int row =0;
	row = stmt.executeUpdate();
	
	if(row ==1 ) {
		System.out.println("투표 완료");
		response.sendRedirect("lunchOne.jsp?lunchDate="+lunchDate);
	}else{
		System.out.println("투표실패");
		response.sendRedirect("lunchOne.jsp?lunchDate="+lunchDate);
	}


%>