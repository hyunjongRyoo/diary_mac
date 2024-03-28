
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
	// 0. 로그인(인증) 분기
	// diary.login.my_session => 'OFF' => redirect("loginForm.jsp")
	
	String sql1 = "select my_session mySession from login";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary", "root", "guswhd6656");
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	String mySession = null;
	if(rs1.next()) {
		mySession = rs1.getString("mySession");
	}
	// diary.login.my_session => 'OFF' => redirect("loginForm.jsp")
	if(mySession.equals("OFF")) {
		String errMsg = URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
		return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return사용
	}
	%>
	
	<%
	// 출력 리스트 모듈
	int currentPage = 1;
	if(request.getParameter("currentPage")!= null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + " <-- currentPage");
	int rowPerPage = 10;
	/*
	if(request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	*/
	
	int startRow = (currentPage-1)*rowPerPage; // 1-0, 2-10, 3-20, 4-30,....
	
	String searchWord = "";
	if(request.getParameter("searchWord") != null) {
		searchWord = request.getParameter("searchWord");
	}
	/*
		select diary_date diaryDate, title
		from diary
		where title like ?
		order by diary_date desc
		limit ?, ?
	*/
	String sql2 = "select diary_date diaryDate, title from diary where title like ? order by diary_date desc limit ?, ?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, "%"+searchWord+"%");
	stmt2.setInt(2, startRow);
	stmt2.setInt(3, rowPerPage);
	rs2 = stmt2.executeQuery();
%>

<%
	// lastPage 모듈
	String sql3 = "select count(*) cnt from diary where title like ?";
	PreparedStatement stmt3 = null;
	ResultSet rs3 = null;
	stmt3 = conn.prepareStatement(sql3);
	stmt3.setString(1, "%"+searchWord+"%");
	rs3 = stmt3.executeQuery();
	int totalRow = 0;
	if(rs3.next()) {
		totalRow = rs3.getInt("cnt");
	}
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap" rel="stylesheet">
<style>
	 * {
		  font-family: "Gowun Batang", serif;
		  font-weight: 700;
		  font-style: normal;
		}
   
   		
   		 body {
     	 background-image: url("img/sky.jpg");
   		background-size: cover;
        height: 100vh;
        display: flex;
        flex-direction: column;
        
   }
   a{
      text-decoration: none;
      color: #000000;
   }
</style>
</head>
<body class="container">
  <div class="row">
  	<div class="col">
  	<div class="row">
         <div class="col">
            <h1 class=>Category</h1>
         </div>
         <div class="col-">
            <div style="">
               <a class="" href="/diary/diary.jsp">달력</a><br>
               <a class="" href="/diary/diaryList.jsp">목록</a><br>
               <a class="" href="/diary/addDiaryForm.jsp">일기 추가</a>
            
         </div>
         <div class="col">
            <div style="">
               <a class="" href="/diary/logout.jsp">로그아웃</a>
            </div>
            
         </div>
      </div>
  	</div>
  	</div>
    <div class="col-6">
		<h1 style="text-align: left">일기 목록</h1>
		
		<table class="ms-8 col-7 bg-white rounded" style="text-align: center ">
		<tr>
				<th>날짜</th>
				
				<th>제목</th>
			</tr>
		<%
				while(rs2.next()) {
		%>
					<tr>
						<td><%=rs2.getString("diaryDate")%><td>
						<td><a href="/diary/diaryOne.jsp?diaryDate=<%=rs2.getString("diaryDate")%>">
						<%=rs2.getString("title")%></a></td>
					</tr>
		<%		
				}
		%>
				</table>
	<%
			if(currentPage>1){
		%>
				<a href="./diaryList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}else{
		%>
				<a href="./diaryList.jsp?currentPage=<%=currentPage+1%>">다음</a>  
		<% 
			}
		%>
		<form method="get" action="/diary/diaryList.jsp">
			<div class="position-absolute bottom-0 start-50 translate-middle-x">
				제목
				<input type="text" name="searchWord">
				<button type="submit"  class="btn btn-outline-info " style="color:black;">검색</button>
			</div>
		</form>
	</div>
	<div class="col">
    </div>
  </div>
</body>
</html>
