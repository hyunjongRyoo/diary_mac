<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<% 
//로그인(인증)분기
 	String loginMember = (String)(session.getAttribute("loginMember"));

	if(loginMember == null) { // 로그인 멤버값이 null 이라면
		String errMsg = URLEncoder.encode("잘못된 접근입니다. 로그인 먼저 해주세요", "utf-8");
	    response.sendRedirect("/diary/loginForm.jsp?errMsg=" + errMsg);
	    return; //코드 진행을 끝내는 문법 
	}
%>

<%
//diary 에서 받아온 값 처리
String diaryDate =request.getParameter("diaryDate");  //date는 string으로 받아와도 된다
//디버깅 코드
System.out.println(diaryDate+"<--diaryDate"); 

Class.forName("org.mariadb.jdbc.Driver");
Connection conn= null;
conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "guswhd6656");



String sql = "select diary_date diaryDate,title,weather,content,update_date updateDate,create_date createDate from diary where diary_date= ?";

PreparedStatement stmt = null;
stmt=conn.prepareStatement(sql);
stmt.setString(1,diaryDate);

System.out.println(stmt);
ResultSet rs = null;
rs= stmt.executeQuery();


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>diary</title>
<!--부트스트랩,CSS -->
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
   
   
   .cell {
      background-color: #FFFFFF;
      float: left;
      width: 120px;
      height: 90px;
      border: 1px solid #F6F6F6;
      margin: 3px;
       border-radius: 10px;
   }
   
   .sun {
      clear: both;
      color: #FF0000;
   }
   
   .satur {
      color: #0000FF;
   }
   
   .yocell{
      background-color: #F6F6F6;
      float: left;
      width: 120px;
      height: 40px;
      margin: 3px;
      padding: 7px;
      border-radius: 2px;
      text-align: center;
   }
   a{
      text-decoration: none;
      color: #000000;
   }
   
    body {
     	 background-image: url("img/sky.jpg");
   		background-size: cover;
        height: 100vh;
        display: flex;
        flex-direction: column;
        
   }

   


   
</style>
</head>
<body class="container">
   <div class="row">
     <div class="col">
          <div class="row">
         <div class="col">
            <h1 class="">Category</h1>
         </div>
         <div class="col-">
            <div style="">
               <a class="" href="/diary/diary.jsp">달력</a><br>
               <a class="" href="/diary/diaryList.jsp">목록</a><br>
               <a class="" href="/diary/addDiaryForm.jsp">일기추가</a>
            </div>
         </div>
         <div class="col">
            <div style="">
               <a class="" href="/diary/logout.jsp">로그아웃</a>
            </div>
            
         </div>
      </div>
      </div>
    <div class="col-6 bg-black border shadow p-3 mb-5 bg-body-tertiary rounded">
   		<h1><%=diaryDate%> Diary</h1>
   		<hr>
   			<%
   			
   			if(rs.next()) {
   			String title=rs.getString("title");
   			String weather=rs.getString("weather");
   			String content=rs.getString("content");
   			String updateDate=rs.getString("updateDate");
   			String createDate=rs.getString("createDate");
   			
   			
			%>
			
			<div>✏️<%=title%></div>
			<div>🌈 <%=weather %></div>
			<div>📖 <%=content %></div>
			<div>수정시간:<%=updateDate %></div>
			<div>작성시간:<%=createDate %></div>
			
   		<%
   		}
   		 %>	
   		 <!-- 댓글 추가 폼 -->
   		 	<div>
   		 		<form method="post" action="/diary/addCommentAction.jsp">
   		 			<input type="hidden" name="diaryDate" value="<%=diaryDate%>>">
   		 			<textarea row="2" cols="50" name="memo"></textarea>
   		 			<button type="submit">확인</button>
   		 		</form>
   		 		<!-- 댓글 리스트 -->
   		 		<%
   		 			
   		 			String sql2 ="select comment_no commentNo,memo,create_date createDate from comment where diary_date=?";
   		 			PreparedStatement stmt2 = null;
   		 			ResultSet rs2 = null;
   		 			
   		 			stmt2=conn.prepareStatement(sql2);
   		 			stmt2.setString(1,diaryDate);
   		 			rs2=stmt2.executeQuery();
   		 		%>
   		 			<table border="1">
   				 <%
   		 			while(rs2.next()){
   		 	%>
   		 				<tr>
   		 					<td><%=rs2.getString("memo")%></td>
   		 					<td><%=rs2.getString("createDate")%></td>
   		 					<td><a href="/diary/deleteComment.jsp?commentNo=<%=rs2.getInt("commentNo")%>">수정</a></td>
   		 				</tr>
   		 	<% 
   		 			}
   		 	%>
   		 </table>
   		 	</div>
   		 <a href="/diary/updateDiaryForm.jsp?diaryDate=<%=diaryDate%>" class="mt-3 mb-4 btn btn-outline-info">일기수정</a>
		 <a href="/diary/deleteDiary.jsp?diaryDate=<%=diaryDate%>" class="mt-3 mb-4 btn btn-outline-info">일기삭제</a>
    		</div>
    
    
		 <div class="col"></div>
  
   </div>

</body>
</html>