<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%
String sql1 ="SELECT my_session mySession FROM login";
//디버깅 코드
System.out.println(sql1);

Class.forName("org.mariadb.jdbc.Driver");
Connection conn= null;
PreparedStatement stmt1 = null;
ResultSet rs1 = null;

conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "guswhd6656");
stmt1 = conn.prepareStatement(sql1);


rs1 = stmt1.executeQuery();

String mySession = null;

if(rs1.next()){
	mySession = rs1.getString("mySession");
	
}

if(mySession.equals("OFF")) {
	String errMsg = URLEncoder.encode("잘못된 접근입니다. 로그인 먼저해주세요", "utf-8");
	response.sendRedirect("/diary/loginForm.jsp?errMsg=" +errMsg);
	return;  // 코드 진행을 끝내는 문법  ex) 메소드 끝낼때 return을 사용함 
             //로그인이 되어있지 않을때  로그인폼으로 이동하여  로그인먼저 실행 
}
%>
<%
String lunchDate =request.getParameter("lunchDate");
String sql2="SELECT lunch_date lunchDate, menu FROM lunch WHERE lunch_date =  ?";
PreparedStatement stmt2 = null;
ResultSet rs2 = null;




%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>투표메뉴</title>
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
<body><div class="container">
  		<div class="row">
    		<div class="col">
      
			    	</div>
			    	<form method="post" action="/diary/lunchResult.jsp">   
				   
				    <div class="col-8">
				             
			    		<h1>원하시는 점심 메뉴를 골라주세요!</h1>
		    		
			    		<div><label for="양식">- 양식</label>
			    			<input type="checkbox" name="lunch" id="양식" value="양식">
			    		</div><br>
			    		
						<div><label for="일식">- 일식</label>
			    			<input type="checkbox" name="lunch" id="일식" value="일식">
			    		</div><br>
			    	
						<div><label for="중식">- 중식</label>
			    			<input type="checkbox" name="lunch" id="중식" value="중식">
			    		</div><br>
			    		
						<div><label for="한식">- 한식</label>
			    			<input type="checkbox" name="lunch" id="한식" value="한식">
		    			</div><br>
		    			
			    		<button type = "submit" class="btn btn-outline-info">투표!</button>
		   			</div>
			   	 </form>
		    	<div class="col">
      
			 </div>
  		</div>
	</div>

</body>
</html>