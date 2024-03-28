<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	page import ="java.sql.*"%>
<%
	// on ->off (로그아웃 과정)
	// 로그인 (인증) 분기 
	//diary.login.my_ssesion  => OFF=>redirect("loginForm.jsp") 
	//테이블 이름 / 칼럼이름
	
	//on일때는 로그인 되어있는거 off일때는 로그인 안되어있는것 
	//그래서 loginForm에는 on일 상태에는 갈필요가 없다.
	String sql1="select my_session mySession from login";  //로그인테이블로부터 my_session 값을 가져오는데 별칭으로 가져옴 : mySession
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null; 
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn= DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary", "root", "guswhd6656");
	stmt1 = conn.prepareStatement(sql1);
	rs1= stmt1.executeQuery();
	String mySession = null;
	if(rs1.next()) {
			mySession = rs1.getString("mySession"); // 
	}
	if(mySession.equals("OFF")) {
		String errMsg = URLEncoder.encode("잘못된 접근입니다. 로그인 먼저해주세요", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg=" +errMsg);
		return;  // 코드 진행을 끝내는 문법  ex) 메소드 끝낼때 return을 사용함 
	}
	//현재값이 off 아니고 on이면 -->  off변경후 loginForm으로 redirect
	String sql2 =  "update login set my_session='OFF' ,off_date=now()";
	PreparedStatement stmt2 = null;
	stmt2 = conn.prepareStatement(sql2);
	int row = stmt2.executeUpdate();
	System.out.print(row+ "<-- row");
	
	response.sendRedirect("/diary/loginForm.jsp");
 %>