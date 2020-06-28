<?php
function device_detect(){
	if(strpos($_SERVER['HTTP_USER_AGENT'],"iPhone")>0){
		$DeviceType=1;
	} else if(strpos($_SERVER['HTTP_USER_AGENT'],"Android")>0) {
		$DeviceType=2;
	} else if(strpos($_SERVER['HTTP_USER_AGENT'],"iPad")>0) {
		$DeviceType=1;
	} else {
		$DeviceType=3;
	}
	return $DeviceType;
} // ends function

$DeviceType=device_detect();

?>