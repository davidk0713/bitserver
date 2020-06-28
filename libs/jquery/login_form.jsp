<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id" content="576736845363-o0474pib5q69qlcv6lm7o42hs6lu5u59.apps.googleusercontent.com">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name = "viewport" content = "user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0,
width=device-width" />
 
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
 
<title>Insert title here</title>

//디자인을 설정하기위해 stylesheet 추가함/
<link rel = "stylesheet" href = "/css/bootstrap.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
 
 
</head>
<br><br><%@ include file="../include/header.jsp"%>
 
<section>
 
<table border="1" width="300px" class = "table-hover">
 
 
        <div class="card align-middle" style="width:30rem; border-radius:20px;">
        
        <div class="card-body">
 
<!-- 로그인창 -->
<form action ="normale_login.do" method = "post">
<center>
<br>
<input type = "text" name="user_id" placeholder="  ID를 입력하세요 " class="form-control"><br><br>
<input type = "password" name="member_pass" placeholder="  비밀번호를 입력하세요 " class="form-control"><br><br>
<button type = "submit" name = "submit" class="form-control btn btn-primary">로그인</button>
<br>
<br>
</center>
 
<center>
 
<html lang="ko">
<head>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" width=200px, height=100px charset="utf-8"></script>
</head>
<body>
 
 
 
 
 
 
<br>
<!-- 네이버아이디로로그인 버튼 노출 영역 -->
<div id="naverIdLogin"></div>
<!-- //네이버 아이디로 로그인 버튼 노출 영역 -->
 
<!-- 네이버 아이디로 로그인 초기화 Script -->
<script type="text/javascript">
    var naverLogin = new naver.LoginWithNaverId(
        {
            //클라이언트 id와 콜백 url (결과페이지)
            clientId: "DphfmDygX4WFkf8nghMJ",
            callbackUrl: "http://localhost/hansub_project/login_result",
            isPopup: false, /* 팝업을 통한 연동처리 여부 */
            loginButton: {color: "green", type: 3, height: 40} /* 로그인 버튼의 타입을 지정 */
        }
    );
    
    /* 설정정보를 초기화하고 연동을 준비 */
    naverLogin.init();
    
</script>
</center>
 
 
</center>
 
<center>
<!-- 카카오톡 아이디 연동해서 로그인 -->
<script src = "//developers.kakao.com/sdk/js/kakao.min.js" width=200px, height=100px ></script>
<a id="kakao-login-btn"></a>
<a href="http://developers.kakao.com/logout"></a>
<script type='text/javascript'>
 
Kakao.init('bd21082a499aaa79b4c08e01935a8a70'); //아까 카카오개발자홈페이지에서 발급받은 자바스크립트 키를 입력함
 
//카카오 로그인 버튼을 생성합니다. 
 
Kakao.Auth.createLoginButton({ 
    container: '#kakao-login-btn', 
    success: function(authObj) { 
           Kakao.API.request({
 
               url: '/v1/user/me',
 
               success: function(res) {
 
                     console.log(res.id);//<---- 콘솔 로그에 id 정보 출력(id는 res안에 있기 때문에  res.id 로 불러온다)
 
                     console.log(res.kaccount_email);//<---- 콘솔 로그에 email 정보 출력 (어딨는지 알겠죠?)
 
                     console.log(res.properties['nickname']);//<---- 콘솔 로그에 닉네임 출력(properties에 있는 nickname 접근 
                             
                 // res.properties.nickname으로도 접근 가능 )
                     console.log(authObj.access_token);//<---- 콘솔 로그에 토큰값 출력
          
          var id = res.id;    //카카오톡 닉네임을 변수에 저장
          var kakaonickname = res.properties.nickname;    //카카오톡 닉네임을 변수에 저장
          var kakaoe_mail = res.kaccount_email;    //카카오톡 이메일을 변수에 저장함
         
          
 
          window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/hansub_project/home?kakaonickname="+kakaonickname+"kakaotalk"+"&kakaoe_mail="+kakaoe_mail);
      
                   }
                 })
               },
               fail: function(error) {
                 alert(JSON.stringify(error));
               }
             });
</script>
</center>
 
 
<!-- 페이스북 아이디를 연동해서 로그인 -->
 
 <center>
<button type= "button" id= "loginBtn" ><img src="https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQwsKoAUt9rmyFjqv055BANDSiVlqNsu-kOF2NKwpGzOgWFwiqD" width=200px, height=50px /></button>
 </center>
 
            <div id="access_token"></div>
            <div id="user_id"></div>
            <div id="name"></div>
            <div id="email"></div>
            <div id="gender"></div>
            <div id="birthday"></div>
            <div id="id"></div>            
            
<script>
function getUserData() {
    /* FB.api('/me', function(response) {
        document.getElementById('response').innerHTML = 'Hello ' + response.name;
        console.log(response);
    }); */
    FB.api('/me', {fields: 'name,email'}, function(response) {
        
        var facebookname = response.name;    //페이스북 아이디를 변수에 저장함
        var facebooke_mail = response.email;    //페이스북 이메일을 변수에 저장함
        
        
        window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/hansub_project/home?facebookname="+encodeURI(facebookname)+"&facebooke_mail="+facebooke_mail);
 
    });
}
  
window.fbAsyncInit = function() {
    //SDK loaded, initialize it
    FB.init({
        appId      : '488986078336253', //페이스북 개발자 홈페이지에서 앱을 등록하고, 앱 id를 받아온다.
        cookie     : true,  // enable cookies to allow the server to access
                // the session
        xfbml      : true,  // parse social plugins on this page
        version    : 'v3.3'     // 페이스북 개발자 홈페이지에서 버전을 확인한 후 작성한다.
    });
  
    //check user session and refresh it
    FB.getLoginStatus(function(response) {
        if (response.status === 'connected') {        //만약 정상적으로 실행되었다면 유저의 데이터를 가져온다.
            //user is authorized
            //document.getElementById('loginBtn').style.display = 'none';
            getUserData(); 
            
        
            
        } else {
            //user is not authorized
        }
    });
};
  
//load the JavaScript SDK
(function(d, s, id){
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.com/ko_KR/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
  
//add event listener to login button
document.getElementById('loginBtn').addEventListener('click', function() {
    //do the login
    FB.login(function(response) {
        if (response.authResponse) {
            access_token = response.authResponse.accessToken; //get access token
            user_id = response.authResponse.userID; //get FB UID
            console.log('access_token = '+access_token);
            console.log('user_id = '+user_id);
            //user just authorized your app
            //document.getElementById('loginBtn').style.display = 'none';
            getUserData();
        }
    }, {scope: 'email,public_profile,user_birthday',
        return_scopes: true});
}, false);
 
 
 
</script>
 
 
 
</form>
<br>
<!-- 아이디 찾기 -->
<!-- 위치를 왼쪽으로 고정시키고, 45퍼센트만큼 떨어짐 -->

<div style= "width:45%; float:left;">
<form action ="find.user_id.do">
<center>
<button class = "btn btn-default btn-block">아이디 찾기</button>
</center>
</form>
</div>
 
<!-- 비밀번호 찾기 -->
<!-- 위치를 오른쪽으로 고정시키고, 45퍼센트 만큼공간을 차지함. 두개의 버튼은 총 10퍼센트 만큼 떨어져 있는것. -->

<div style= "width:45%; float:right;">
<form action ="find.member_pass.do">
<center>
<button class = "btn btn-default btn-block">비밀번호 찾기</button>
<br>
</center>
</form>
<br>
</div>
<br>
 
</td>
<br>
</tr>
</div>
 
<br>
<br>
</div>
</div>
</div>
</table>
</section>
 
 
<body>
<!-- 로그인 실패나 성공시 메시지를 받아서 출력하는 자바스크립트 구문 -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script>
    $(function(){
        var responseMessage = "<c:out value="${message}" />";
        if (responseMessage != ""){
            alert(responseMessage)
        }
    })
</script>
 
 
</body>
</html>