<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% 
   //로그인(인증) 분기
   // diary.login.my_session => "ON" 일땐 redirect("/diary/diary.jsp");
   // 테이블 이름 / 칼럼이름
   //on일때는 로그인 되어있는거 off일때는 로그인 안되어있는것 
   //그래서 loginForm에는 on일 상태에는 갈필요가 없다.
   
   String sql = "SELECT my_session mySession FROM login";
   //로그인테이블로부터 my_session 값을 가져오는데 별칭으로 가져옴 : mySession

   
   Class.forName("org.mariadb.jdbc.Driver");
   Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "guswhd6656");
   PreparedStatement stmt = null;
   stmt = conn.prepareStatement(sql);
   ResultSet rs = null;
   rs = stmt.executeQuery();
   
   String mySession = null;
   
   if(rs.next()){
      mySession = rs.getString("mySession");
         
   }
   
   if(mySession.equals("ON")){
      response.sendRedirect("/diary/diary.jsp");
      
      //자원 반납
      rs.close();
      stmt.close();
      conn.close();
      
      return;
   }
   
   // 요청값 받기
   String errMsg = request.getParameter("errMsg");
   
   //디버깅
   System.out.println(errMsg + " <-- loginForm param errMsg");
   
   //if문 안걸릴 시 자원 반납
   rs.close();
   stmt.close();
   conn.close();
   
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
<!-- Latest compiled and minified CSS -->
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
      
   }

   header {
      height: 100px;
      background-color: ##F6F6F6;
   }
   
   a {
      text-decoration: none;
   }
</style>
</head>
<body class="container">
   <div class="row">
      <div class="col"></div>
      <div class="mt-5 col-4 " style="color: #000000">
         <div class="mt-2">
            <%
               if(errMsg != null) {
            %>
                  <%=errMsg %>
            <%
               } else {
            %>
                  <div>&nbsp;</div>
            <%
               }
            %>
         </div>
         <h1 class="text-center mt-4 fw-bold " style="color: #FFFFFF" >My Diary</h1>
         <form method="post" action="/diary/loginAction.jsp">
              <div class="ms-5 mb-3 mt-3 w-75">
                <label class="form-label">🌞</label>
                <input type="text" class="form-control rounded-pill" name="memberId">
              </div>
              <div class="ms-5 mb-3 w-75">
                <label class="form-label">🗝️</label>
                <input type="password" class="form-control rounded-pill" name="memberPw">
              </div>
            <button type="submit" class="ms-5 mt-3 w-75 btn" style="background-color: #27B1CD">확인</button>
         </form>
            </div>
      <div class="col"></div>
   </div>
</body>
</html>