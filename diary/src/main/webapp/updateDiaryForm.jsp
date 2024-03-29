<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<% 
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
Connection conn =null;
conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "guswhd6656");

String diaryDate = request.getParameter("diaryDate");
System.out.println(diaryDate + "<--diaryDate");

String sql= "SELECT diary_Date diaryDate , title , weather , content , update_date updateDate , create_date createDate FROM diary WHERE diary_Date = ?";
PreparedStatement stmt = null;
ResultSet rs =  null;
stmt =conn.prepareStatement(sql);
stmt.setString(1, diaryDate);

rs=stmt.executeQuery();

if(rs.next()) {
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
		  font-weight: 400;
		  font-style: normal;
		}
		
		body {
     	 background-image: url("img/sky.jpg");
   		background-size: cover;
        height: 100vh;
        display: flex;
        flex-direction: column;
        justify-content: center;
   }
</style>
</head>
<body>
<div class="container">
		<div class="row">
			<div class="col"></div>
				<div class="mt-5 col-7 bg-white border shadow p-3 mb-5 bg-body-tertiary rounded">
					<h1>일기 수정하기</h1>
							<form method="post" action="/diary/updateDiaryAction.jsp">
								<div>
									<label class="form label">diaryDate</label>
									<input type="text" class=form-control name="diaryDate"
									value="<%=rs.getString("diaryDate")%>" readonly="readonly">  
									</div>
									<div>
									<label class="form-label">title	</label>
									 <input type="text" class="form-control"  name="title" 
									 value='<%=rs.getString("title")%>'>
									</div>
									
									<div class="mb-3">
					           		🌈 
					               <select name="weather" class="form-select">
					                  <option value="맑음">☀️</option>
					                  <option value="흐림">☁️</option>
					                  <option value="비">☂</option>
					                  <option value="눈">❄️</option>
					               </select>
					           		 </div>
									
									<div class="mb-3 mt-3">
									<label class="form-label">content	</label>
									 <input type="text" class="form-control"  name="content" 
									 value='<%=rs.getString("content")%>'>
									</div>
									
									<div style="text-align: right">
									<button type="submit" class="btn btn-block btn- info border">수정하기</button>
									</div>
							
						</form>						
				</div>
			<div class="col"></div>
					
		</div>
	</div>
</body>
</html>
<%
}
%>