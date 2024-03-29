<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
	// 0. 로그인(인증) 분기
 	//로그인(인증) 분기
	String loginMember =(String) (session.getAttribute("loginMember"));

   
   if(loginMember == null){ //로그인 멤버 값이 null 이라면 
      String errMsg = URLEncoder.encode("잘못된 접근입니다. 로그인 먼저 해주세요", "utf-8");
      response.sendRedirect("/diary/loginForm.jsp?errMsg=" + errMsg);
      return; //코드 진행을 끝내는 문법 
   }

	%>
	<%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary", "root", "guswhd6656");

	String checkDate = request.getParameter("checkDate");
	
	String sql2 = "select diary_date diaryDate from diary where diary_date=?";
	// 결과가 있으면 이미 이날짜에 일기가 있다 -> 이날짜로는 입력X
	
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, checkDate);
	rs2 = stmt2.executeQuery();
	if(rs2.next()) {
	//  이날짜 일기 기록 불가능(이미존재)
		response.sendRedirect("/diary/addDiaryForm.jsp?checkDate="+checkDate+"&ck=F");
	} else {
		//  이날짜 일기 기록 가능
		response.sendRedirect("/diary/addDiaryForm.jsp?checkDate="+checkDate+"&ck=T");
	}
	
%>