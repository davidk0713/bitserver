<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%@ include file="header.jsp"%>
 
 
<body>
<br>

<!-- 세션에 id값이 저장되어 있는 경우 로그아웃 버튼과 로그인한 아이디가 출력되도록 코드를 작성함 -->
 
<c:if test = "${sessionScope.user_id != null}">
 
<span style="color: black; font-weight: bold;">(일반)${sessionScope.user_id}님이 로그인 하셨습니다.</span><br><br>
 
<form action = "logout.do" method = "post">
<button type = "submit" name = "submit" class="btn btn-primary">로그아웃</button></form><br><br>
 
<form action = "member_profile.do" method = "post">
<button type = "submit" name = "submit" class = "btn btn-primary">나의 프로필 확인</button></form><br><br>
 
 
</c:if>
 
 
<c:if test = "${sessionScope.navername != null}">
 
<span style="color: black; font-weight: bold;">(네이버)${sessionScope.navername}님이 로그인 하셨습니다.</span><br><br>
 
<form action = "naver_logout.do" method = "post">
<button type = "submit" name = "submit" class="btn btn-primary">로그아웃</button></form><br><br>
 
<form action = "authentication.do" method = "post">
<button type = "submit" name = "submit" class = "btn btn-primary">회원 인증하기 (인증을 해야 각종 기능들 사용 가능)</button></form><br><br>
 
<form action = "naver_member_profile.do" method = "post">
<button type = "submit" name = "submit" class = "btn btn-primary">나의 프로필 확인</button></form><br><br>
 
</c:if>
 
 
<c:if test = "${sessionScope.kakaonickname != null}">
 
<span style="color: black; font-weight: bold;">(카카오톡)${sessionScope.kakaonickname}님이 로그인 하셨습니다.</span><br><br>
 
<form action = "kakao_logout.do" method = "post">
<button type = "submit" name = "submit" class="btn btn-primary">로그아웃</button></form><br><br>
 
<form action = "authentication.do" method = "post">
<button type = "submit" name = "submit" class = "btn btn-primary">회원 인증하기 (인증을 해야 각종 기능들 사용 가능)</button></form><br><br>
 
<form action = "kakao_member_profile.do" method = "post">
<button type = "submit" name = "submit" class = "btn btn-primary">나의 프로필 확인</button></form><br><br>
 
</c:if>
 
 
 
<c:if test = "${sessionScope.facebookname != null}">
 
<span style="color: black; font-weight: bold;">(페이스북)${sessionScope.facebookname}님이 로그인 하셨습니다.</span><br><br>
 
<form action = "facebook_logout.do" method = "post">
<button type = "submit" name = "submit" class="btn btn-primary">로그아웃</button></form><br><br>
 
 
<form action = "authentication.do" method = "post">
<button type = "submit" name = "submit" class = "btn btn-primary">회원 인증하기 (인증을 해야 각종 기능들 사용 가능)</button></form><br><br>
 
<form action = "facebook_member_profile.do" method = "post">
<button type = "submit" name = "submit" class = "btn btn-primary">나의 프로필 확인</button></form><br><br>
 
</c:if>
 
 
<c:if test = "${sessionScope.admin_id != null}">
 
<span style="color: black; font-weight: bold;">(관리자)${sessionScope.admin_id}님이 로그인 하셨습니다.</span><br><br>
 
<form action = "logout.do" method = "post">
<button type = "submit" name = "submit" class="btn btn-primary">로그아웃</button></form><br><br>
 
 
</c:if>
 
 
 
 
<c:if test = "${sessionScope.user_id == null and sessionScope.navername == null and sessionScope.kakaonickname == null and sessionScope.facebookname == null and sessionScope.admin_id == null}">
 
<%
//url로 보낸 아이디를 세션에 저장하기 위해 변수에 저장함
String navername = request.getParameter("navername");
String kakaonickname = request.getParameter("kakaonickname");
String facebookname = request.getParameter("facebookname");
String normalname = request.getParameter("user_id");
String admin_id = request.getParameter("admin_id");
 
 
//url로 보낸 이메일를 세션에 저장하기 위해 변수에 저장함
String navere_mail = request.getParameter("navere_mail");
String kakaoe_mail = request.getParameter("kakaoe_mail");
String facebooke_mail = request.getParameter("facebooke_mail");
 
%>    
 
 
<%
//아이디를 세션에 저장
session.setAttribute("navername", navername);
session.setAttribute("kakaonickname", kakaonickname);
session.setAttribute("facebookname", facebookname);
session.setAttribute("normalname", normalname);
session.setAttribute("admin_id", admin_id);
 
 
//이메일을 세션에 저장
session.setAttribute("navere_mail", navere_mail);
session.setAttribute("kakaoe_mail", kakaoe_mail);
session.setAttribute("facebooke_mail", facebooke_mail);
 
 
if (navername == null && kakaonickname == null && facebookname == null && normalname == null && admin_id == null) {
    
%>
 
<span style="color: black; font-weight: bold;">(guest)님 방문을 환영합니다.</span><br><br>
                                
                                
<span style="color: black; font-weight: bold;">로그인을 하셔야 다른 기능을 정상적으로 이용하실 수 있습니다.</span><br>
        
    <%@ include file="../member/login_form.jsp"%><br>
    
<%
 
    } 
 
%>
    
    
    </c:if>
 
</body>
</html>
