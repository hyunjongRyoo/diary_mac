<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	String diaryDate =request.getParameter("diaryDate");
	String title = request.getParameter("title");
	String weather = request.getParameter("weather");
	String content= request.getParameter("content");
	
	//디버깅코드
	System.out.println(diaryDate + "<--diaryDate");
 	System.out.println(title + "<--title");
 	System.out.println(weather + "<--weather");
 	System.out.println(content + "<--content");
 	
 	// 데이터를 수정 
 	
 	String sql = "update diary set title=?, weather=?, content=? where diary_Date=?"; 
 	Class.forName("org.mariadb.jdbc.Driver");
 	Connection conn = null;
 	PreparedStatement stmt=null;
 	int row = 0 ;
 	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "guswhd6656");
  	stmt = conn.prepareStatement(sql);
 	stmt.setString(1,title);
 	stmt.setString(2,weather);
  	stmt.setString(3,content);
  	stmt.setString(4,diaryDate);
  	
  	row =stmt.executeUpdate();
	
  	 //3번 결과값 성공 or 실패 반복문 사용 
    //성공하면 board/boardList.jsp 
    //실패하면 updateBoardFrom.jsp로 이동 
    
    if(row==1) {
    	response.sendRedirect(
    			"/diary/diaryOne.jsp?diaryDate=" + diaryDate);
    }else{
    	response.sendRedirect(
    			"/diary/updateDairyForm.jsp="+diaryDate);
    	
    }


%>