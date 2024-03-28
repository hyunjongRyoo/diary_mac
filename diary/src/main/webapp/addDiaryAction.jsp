<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.net.*" %>
<%@ page import ="java.sql.*" %>
<%
	String diaryDate = request.getParameter("diaryDate");
	String feeling= request.getParameter("feeling");
	String title = request.getParameter("title");
	String weather= request.getParameter("weather");
	String content = request.getParameter("content");
	
	//디버깅 코드 
	
	System.out.println(diaryDate + "<--diaryDate");
	System.out.println(feeling + "<--feeling");
	System.out.println(title + "<--title");
	System.out.println(weather + "<--weather");
	System.out.println(content + "<--content");
	
	//데이터베이스 연결 후 입력값을 넣어줌 
	
	String sql = "Insert Into diary (diary_date,feeling,title,weather,content,update_date,create_date )VALUES(? , ? , ? ,? ,?,NOW(),NOW())";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "guswhd6656");
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, diaryDate);
	stmt.setString(2, feeling);
	stmt.setString(3, title);
	stmt.setString(4, weather);
	stmt.setString(5, content);
	System.out.println(stmt);
	
	int row=stmt.executeUpdate();
	if(row == 1){
		System.out.println("입력되었습니다");
	}else{
		System.out.println("입력실패하였습니다");
	}
	//목록으로 돌아감 
	response.sendRedirect("/diary/diary.jsp");
	







%>