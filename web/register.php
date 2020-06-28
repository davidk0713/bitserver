<?php
extract($_POST);
if (isset($_POST)) {
    require_once '../config/config.php';
    $c = new MemberClass();
    // 동일한 userID(email) 등록되어 있는지 체크
    if ($c->isUserExisted($userID)) {
        echo '{"result":"0"}'; // echo json_encode(array('result' => '0')); 과 동일
    } else {
        // 회원 등록
        $user = $c->storeUser($userID, $name, $email, $password, $telNO, $mobileNO);
        if ($user) {// 회원 등록 성공
            if (!isset($_SESSION)) {
                session_start();
            }
            $_SESSION['userID'] = $user['userID'];
			$_SESSION['admin'] = $user['admin'];
            echo json_encode(array('result' => '1'));
        } else {
            // 회원 등록 실패
            echo json_encode(array('result' => '-1'));
        }
    }
} else {// 입력받은 데이터에 문제가 있을 경우
    echo json_encode(array('result' => '-2'));
}
?>

