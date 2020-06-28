<?php
extract($_POST);

require_once 'config/config.php';
$c = new MemberClass();

// json response array
$response = array("error" => FALSE);

if (isset($_POST['userID']) && isset($_POST['password'])) {

	// get the user by userID and password
	$rs = $c->LoginUserChk($userID,$password,$deviceID);
    $user = $c->getUser($userID, $password);

    if ($user != false && $rs > 0) {
        // use is found
        $response['error'] = FALSE;
        $response['user']['userID'] = $user['userID'];
        $response['user']['name'] = $user['userNM'];
        $response['user']['email'] = $user['email'];
        $response['user']['deviceID'] = $user['phoneSE'];
        $response['user']['created_at'] = $user['created_at'];
        $response['user']['updated_at'] = $user['regdate'];
        echo json_encode($response);
    } else if ($user != false && $rs == -1) {
        $response['error'] = TRUE;
        $response['error_msg'] = "등록된 폰이 아닙니다. 관리자에게 문의하세요!";
        echo json_encode($response);
    } else {
        // user is not found with the credentials
        $response['error'] = TRUE;
        $response['error_msg'] = "Login credentials are wrong. Please try again!";
        echo json_encode($response);
    }
} else {
    // required post params is missing
    $response["error"] = TRUE;
    $response["error_msg"] = "userID와 패스워드 입력값이 없습니다!";
    echo json_encode($response);
}
?>

