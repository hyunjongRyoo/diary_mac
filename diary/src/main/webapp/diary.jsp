<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<% 
   //로그인(인증) 분기
   // diary.login.my_session => "OFF" 일땐 redirect("loginForm.jsp")
   //테이블 이름/칼럼이름
   //on일때는 로그인 되어있는거 off일때는 로그인 안되어있는것 
   //그래서 loginForm에는 on일 상태에는 갈필요가 없다
   
   String sql1 = "SELECT my_session mySession FROM login"; //로그인테이블로부터 my_session 값을 가져오는데 별칭으로 가져옴 : mySession
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
   
   if(mySession.equals("OFF")){
      String errMsg = URLEncoder.encode("잘못된 접근입니다. 로그인 먼저 해주세요", "utf-8");
      response.sendRedirect("/diary/loginForm.jsp?errMsg=" + errMsg);
      return; //코드 진행을 끝내는 문법 
   }
%>
<%
   
   //달력 API
   
   String targetYear = request.getParameter("targetYear");
   String targetMonth = request.getParameter("targetMonth");
   
   //디버깅코드 작성 
   System.out.println(targetYear + "<-- targetYear");
   System.out.println(targetMonth + "<-- targetMonth");
  
   
   Calendar target = Calendar.getInstance();
   
   
   if(targetYear != null || targetMonth != null){
      target.set(Calendar.YEAR, Integer.parseInt(targetYear));
      target.set(Calendar.MONTH, Integer.parseInt(targetMonth));
   }
   target.set(Calendar.DATE, 1); //시작 공백의 갯수는 1일의 요일 필요 
   
   
   	int tYear = target.get(Calendar.YEAR);
	int tMonth = target.get(Calendar.MONTH);
   
   
   int yoNum = target.get(Calendar.DAY_OF_WEEK); //달력 타이틀로 출력할 변수 
   //디버깅
   System.out.println(yoNum + " <-- yoNum");  //시작공백의 갯수 :일요일 공백이 없고 월요일은 1칸 화요일은 2칸  yoNum -1 이 공백의 갯수 
   
   int startBlank = yoNum - 1;
   
   int lastDate = target.getActualMaximum(Calendar.DATE);   //target달의 마지막 날짜 반환 
   //디버깅
   System.out.println(lastDate + " <-- lastDate");
   int countDiv = startBlank + lastDate;
   
   	// tyear와 tmonth에 해당되는 diary목록 추출 
   	String sql2 = "select diary_date diaryDate, day(diary_date) day,feeling, left(title,5) title from diary where year(diary_date)=? and month(diary_date)=?"; //검색결과를 찾는 sql이다 결과값은 diaryDate가 되어야함 날짜에서 일기를 찾는 기능을 만들기 위해 구현함 
   	PreparedStatement stmt2 = null;
   	ResultSet rs2 = null;
   	stmt2 = conn.prepareStatement(sql2);
   	stmt2.setInt(1,tYear);
	stmt2.setInt(2,tMonth+1);
	System.out.println(stmt2);
	
	rs2 = stmt2.executeQuery();
	//현재 3월달의 모든일기 
	
	
   	
   	
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
            float: left;
            width: 13%;
            height: 80px; 
            border-radius: 10px;
            margin: 3px;
            text-align: center;
            border: 1px solid #FFFFFF;

   }
   
   .sun {
      clear: both;
      color: #FF0000;
   }
   
   .satur {
      color: #0000FF;
   }
   
   .yocell{
   
      float: left;
      width: 13%;
      height: 40px;
      margin: 3px;
      padding: 7px;
     
      border-radius: 10px;
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
        justify-content: center;
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
               <a class="" href="/diary/addDiaryForm.jsp">일기추가</a><br>
               <a href="/diary/lunchOne.jsp">오늘의 점심</a>
            </div>
         </div>
         <div class="col">
            <div style="">
               <a class="" href="/diary/logout.jsp">로그아웃</a>
            </div>
            
         </div>
      </div>
      </div>
      <div class="mt-4 col-9">
            <div class="mb-4 text-center">
               <h1>
                  <a class="me-5" href="/diary/diary.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth-1 %>">←</a>
                  <%=tYear %>년 <%=tMonth+1 %>월
                  <a class="ms-5" href="/diary/diary.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth+1 %>">→</a>
               </h1>
            </div>
            
            
         <div class="ms-5 ">
        <div class="yocell sun">Sun</div>
      	<div class="yocell">Mon</div>
       	<div class="yocell">Tue</div>
        <div class="yocell">Wed</div>
        <div class="yocell">Thu</div>
        <div class="yocell">Fri</div>
        <div class="yocell satur">Sat</div>

            <!-- DATE값이 들어갈 DIV -->
            <%
               for(int i=1; i<=countDiv; i=i+1) {
                  
                  if(i%7 == 1) {
            %>
                     <div class="ps-2 cell sun">
            <%         
                  } else if(i%7 == 0){
                  
            %>
                     <div class="ps-2 cell satur">
            <%
                  }else {
            %>
                     <div class="ps-2 cell">
            <%            
                  }
					if(i-startBlank > 0) {   
				%>
						<%=i-startBlank%><br>
				<%
						// 현재날짜(i-startBlank)의 일기가 rs2목록에 있는지 비교
						while(rs2.next()) {
							// 날짜에 일기가 존재한다
							if(rs2.getInt("day") == (i-startBlank)) {
				%>
								<div>
								<span><%=rs2.getString("feeling")%></span>
									<a href='/diary/diaryOne.jsp?diaryDate=<%=rs2.getString("diaryDate")%>'>   <!-- 검색결과 값은 day /   spl2랑 맞춰줘야함  -->
										<%=rs2.getString("title")%>...
									</a>
								</div>
				<%				
								break;    //일치하는 데이터가 있으면 멈춤 그리고 처음으로 되돌아감 
							}
						}
						rs2.beforeFirst(); // ResultSet의 커스 위치를 처음으로...  
					} else {
				%>
						&nbsp;
				<%		
					}
				%>
			</div>
	<%		
		}
	%>
         </div>
      </div>
      <div class="col"></div>
   </div>
</body>
</html>