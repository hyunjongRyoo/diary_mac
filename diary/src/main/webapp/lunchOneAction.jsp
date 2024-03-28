<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<% 
	String  lunchDate= request.getParameter("lunchDate");
	//디버깅 코드
	System.out.println(lunchDate+ "<-lunchDate");
	
	String sql = "INSERT INTO lunch(lunch_date,menu,update_date,create_date) VALUES(CURDATE(), ?, NOW(), NOW())";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn =DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "guswhd6656");
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	stmt.setString(1, lunchDate);
	System.out.println(stmt);
	
	int row = stmt.executeUpdate();
	if(row ==1 ) {
		System.out.println("투표 완료");
	}else{
		System.out.println("투표실패");
	}

	response.sendRedirect("lunchOne.jsp");

%>