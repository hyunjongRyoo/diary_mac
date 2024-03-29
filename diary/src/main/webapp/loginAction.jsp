<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.net.*"%>
<%
	// 로그인 (인증) 분기 
	//0-1 	로그인(인증) 분기 session 사용으로 변경
   //로그인 성공시 세션에 loginmember라는 변수를 만들고 값으로 로그인 아이디를 저장
   String loginMember = (String)(session.getAttribute("loginMember")); //세션안에서 로그인멤버라는 변수를 가져오기
   // (session.getAttribute()//찾는 변수가 없으면 null값을 반환한다
   // null이면 로그아웃 상태이고 null이 아니면 로그인 상태 
	 	System.out.println(loginMember + "<--loginMember");
   
   //loginForm페이지는 로그아웃상태에서만 출력되는 페이지
  	if(loginMember != null) {
		response.sendRedirect("/diary/diary.jsp");
		return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return사용
  	}
   
   // loginMember 가 null 이다 ->세션 공간에 loginMember 변수를 생성
	%>
	
	
	<%
	// 1. 요청값 분석 -로그인 성공 -> session에 로그인멤버 변수를 생성
	String memberid = request.getParameter("memberId");   //getParameter("a")의 값과 결과 값이 일치해야함 
	System.out.println(memberid+ "<--memberId"); // 디버깅 코드 , 결과 값이랑 스펠링 같은지 확인 
	String memberPw = request.getParameter("memberPw");
	System.out.println(memberPw +"<--memberPw");

	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null; 
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;  // db에 있는  테이블 1줄을 넣는다고 생각 칼럼의 값을 (데이터에 1줄 )
	conn= DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary", "root", "guswhd6656");
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
		/*
		String sql3 = "update login set my_session = 'ON' , on_date=NOW()";
		PreparedStatement stmt3 = conn.prepareStatement(sql3);
		int row = stmt3.executeUpdate();
		System.out.println(row+"<--row");
		*/
		//로그인 성공시 db값 설정-->  세션변수 설정 
		session.setAttribute("loginMember", rs2.getString("memberId"));
		response.sendRedirect("/diary/diary.jsp");
	}else{
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("check your Id & Pw", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg=" +errMsg);
	
	}
	

%>