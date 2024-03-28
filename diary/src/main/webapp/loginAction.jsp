<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.net.*"%>

<%
	// 로그인 (인증) 분기 
	//diary.login.my_ssesion  => OFF=>redirect("loginForm.jsp")
	//테이블 이름 / 칼럼이름
	
	//on일때는 로그인 되어있는거 off일때는 로그인 안되어있는것 
	//그래서 loginForm에는 on일 상태에는 갈필요가 없다.
	String sql1="select my_session mySession from login";  //로그인테이블로부터 my_session 값을 가져오는데 별칭으로 가져옴 : mySession
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null; 
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;  // db에 있는  테이블 1줄을 넣는다고 생각 칼럼의 값을 (데이터에 1줄 )
	conn= DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary", "root", "guswhd6656");
	stmt1 = conn.prepareStatement(sql1);
	rs1= stmt1.executeQuery(); //값을 받아오고 
	String mySession = null;
	if(rs1.next()) { // 값을 실행을 하고 
			mySession = rs1.getString("mySession"); // 
	}
	if(mySession.equals("ON")) {         
		response.sendRedirect("/diary/loginForm.jsp");
		return;  // 코드 진행을 끝내는 문법  ex) 메소드 끝낼때 return을 사용함  
	}
	
	// 1. 요청값 분석 
	String memberid = request.getParameter("memberId");   //getParameter("a")의 값과 결과 값이 일치해야함 
	System.out.println(memberid+ "<--memberId"); // 디버깅 코드 , 결과 값이랑 스펠링 같은지 확인 
	String memberPw = request.getParameter("memberPw");
	System.out.println(memberPw +"<--memberPw");

	String sql2 ="select member_id memberId from member where member_id=? and member_pw = ?";
	PreparedStatement stmt2 = null; 
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, memberid);
	stmt2.setString(2, memberPw);
	rs2=stmt2.executeQuery();
		
	if(rs2.next()) {
		
		System.out.println("로그인 성공");
		// 로그인 성공  
		// dairy.login.my_session을 -> on으로 바꿔주고 업데이트 해줌 
		String sql3 = "update login set my_session = 'ON' , on_date=NOW()";
		PreparedStatement stmt3 = conn.prepareStatement(sql3);
		int row = stmt3.executeUpdate();
		System.out.println(row+"<--row");
		response.sendRedirect("/diary/diary.jsp");
	}else{
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("check your Id & Pw", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg=" +errMsg);
	
	}
	

%>