<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page import="java.net.URLEncoder"%>
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
 Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "guswhd6656");
   
   
   String checkDate = request.getParameter("checkDate");
   if(checkDate == null) {
      checkDate = "";
   }
   String ck = request.getParameter("ck");
   if(ck == null) {
      ck = "";
   }
   
   System.out.println(checkDate + " <--addDiaryForm param checkDate");
   System.out.println(ck + " <-- addDiaryForm param ck");
   
   String msg = "";
   if(ck.equals("T")) {
      msg = "입력이 가능한 날짜입니다";
   } else if(ck.equals("F")){
      msg = "일기가 이미 존재하는 날짜입니다";
   }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<!-- Latest compiled and minified CSS -->
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
        justify-content: center;
        
   }

   
   a {
      text-decoration: none;
        color: #000000;
   }
</style>
</head>
<body class="container" >
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
      <div class="mt-5 col-6 bg-white rounded align-center">
         <h1 class="mt-4 text-center">오늘의 기록</h1>
         
         <form method="post" action="/diary/checkDateAction.jsp">   
              <div class="mb-3 mt-3">
                <label class="">check Date</label>
                <input type="date" class="form-control" name="checkDate" value="<%=checkDate%>">
                <span><%=msg%></span>
              </div>
            <button type="submit" class="btn btn-outline-info">날짜 확인</button>
         </form>
         
         <hr>
         
         <form method="post" action="/diary/addDiaryAction.jsp">
            <div class="mb-3 mt-3">
               📅 
               <%
                  if(ck.equals("T")) {
               %>
                     <input value="<%=checkDate%>" type="text" class="form-control" name="diaryDate" readonly="readonly">
               <%      
                  } else {
               %>
                     <input value="" type="text" class="form-control" name="diaryDate" readonly="readonly">            
               <%      
                  }
               %>
            </div>
              <div class="mb-3">
                <label class="form-label">✏️</label>
                <input type="text" class="form-control" name="title">
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
                <div class="mb-3">
              🤫
               <br>
               <input type="radio" name="feeling" value="&#128512">&#128512;
               <input type="radio" name="feeling" value="&#128546">&#128546;
               <input type="radio" name="feeling" value="&#128548">&#128548;
               <input type="radio" name="feeling" value="&#129392">&#129392;
               <input type="radio" name="feeling" value="&#128560">&#128560;
               <input type="radio" name="feeling" value="&#128545">&#128545;
               </div>
              <div>
               📖 
               <textarea rows="5" cols="50" class="form-control" name="content"></textarea>
            </div>
            
            <button type="submit" class="mt-3 mb-4 btn btn-outline-info">입력</button>
         </form>
      </div>
      <div class="col"></div>
   </div>
</body>
</html>