<?php
require_once "config/deviceChk.php";

if($DeviceType<3){
	// 모바일(아이폰/아이패드/안드로이드폰) 접속에 대한 처리
	exit;
} else { // PC/노트북 Web 접속에 대한 처리
	if(!isset($_SESSION)){
        session_start();
    }
	if(isset($_SESSION['userID']) && $_SESSION['admin']==1){
		include 'web/admin/index.php';
	} else if(isset($_SESSION['userID']) && $_SESSION['admin']==0){
		include 'web/index.php';
	} else {
		include 'web/loginForm.php';
	}
}
?>
