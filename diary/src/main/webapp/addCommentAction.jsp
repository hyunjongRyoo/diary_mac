<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%

//0.인코딩 설정
   request.setCharacterEncoding("utf-8");
   
   //1.입력값을 받는다 
   String  diaryDate=request.getParameter("diaryDate");
   String memo =request.getParameter("memo");
   
   //디버깅 코드
   System.out.println(diaryDate + " <-- diaryDate");
   System.out.println(memo + " <-- memo");

//데이터 베이스연결 후 입력값 입력  insert문 
   Class.forName("org.mariadb.jdbc.Driver");
   String sql="INSERT INTO COMMENT(diary_Date,memo,update_date,create_date) VALUES(?, ?,now(),now())";
   Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "guswhd6656");
   Connection con = null;
   PreparedStatement stmt= null; 
   ResultSet rs = null;
   stmt = conn.prepareStatement(sql);
   stmt.setString(1, diaryDate);
   stmt.setString(2, memo);
   //디버깅
   System.out.println(stmt);
   
   
   
   int row=stmt.executeUpdate();
      if(row==1) {
         System.out.println("댓글을 달았습니다");
      }else{
         System.out.println("댓글을 달지 못했습니다");
      }

// 3, 목록(boardListOne.jsp)로 돌아감 
   response.sendRedirect("/diary/diaryOne.jsp?diaryDate="+ diaryDate);
%>
