<?php
class MemberClass extends DBConClass {
    // 회원 정보 신규 입력
    public function storeUser($userID, $userNM, $email, $password, $telNO, $mobileNO) {
        $hash = $this->hashSSHA($password);
        $encrypted_password = $hash['encrypted']; // encrypted password
        $salt = $hash['salt']; // salt

		try{
			$this->db->beginTransaction();
			$sql = "INSERT INTO members(userID, userNM, email, passwd, salt, telNO,mobileNO,created_at) VALUES(:userID,:userNM,:email,:passwd,:salt,:telNO,:mobileNO,:created_at)";
			$stmt = $this->db->prepare($sql);
			$stmt->bindValue(':userID',$userID,PDO::PARAM_STR);
			$stmt->bindValue(':userNM',$userNM,PDO::PARAM_STR);
			$stmt->bindValue(':email',$email,PDO::PARAM_STR);
			$stmt->bindValue(':passwd',$encrypted_password,PDO::PARAM_STR);
			$stmt->bindValue(':salt',$salt,PDO::PARAM_STR);
			$stmt->bindValue(':telNO',$telNO,PDO::PARAM_STR);
			$stmt->bindValue(':mobileNO',$mobileNO,PDO::PARAM_STR);
			$stmt->bindValue(':created_at',date("YmdHis"));
			$result = $stmt->execute();
			$this->db->commit();
		} catch (PDOException $pex) {
			$this->db->rollBack();
			echo "에러 : ".$pex->getMessage();
		}
        // check for successful store
        if ($result) {
            $stmt = $this->db->prepare("SELECT * FROM members WHERE userID = :userID");
            $stmt->bindValue(':userID', $userID, PDO::PARAM_STR);
            $stmt->execute();
			$user = $stmt->fetch(PDO::FETCH_ASSOC);

            return $user;
        } else {
            return false;
        }
    }

    // 로그인 체크
    public function getUser($userID, $password) {
		$sql = "SELECT * FROM members WHERE userID=:userID";
        $stmt = $this->db->prepare($sql);
        $stmt->bindValue(':userID', $userID);
		$stmt->execute();

        if ($user=$stmt->fetch()) {
            // verifying user password
            $salt = $user['salt'];
            $encrypted_password = $user['passwd'];
            $hash = $this->checkhashSSHA($salt, $password);
            if ($encrypted_password == $hash) {
                // user authentication details are correct
                return $user;
            }
        } else {
            return NULL;
        }
    }

	// 안드로이드/아이폰 로그인 체크
	public function LoginUserChk($userID,$password,$deviceID){
		if(empty($userID) || empty($password)){
			return 0;
		} else {
			$user = $this->getUser($userID, $password);
			if($user['idx']>0){
				// 장치 일련번호 체크
				if($user['phoneSE'] == NULL){
					// 신규 장비번호 입력(최초 로그인)
					$this->LoginUserEquipInput($userID,$deviceID);
					return $user['idx'];
				} else {
					if($user['phoneSE'] === $deviceID){
						return 1; // 일련번호 일치
					} else {
						return -1; //일련번호 불일치
					}
				}
			} else {
				return 0; //계정오류
			}
		}

	}

	// 장치번호 업데이트
	public function LoginUserEquipInput($userID,$deviceID){
		if(strlen($deviceID)>0 && is_numeric($deviceID)){ // 안드로이드폰
			$ostype = 2;
		} else if(strlen($deviceID)>30){ // 아이폰
			$ostype = 1;
		} else { // 기타
			$ostype = 0;
		}

		try{
			$this->db->beginTransaction();
			$sql='update members set phoneSE=:phoneSE, OStype=:OStype where userID=:userID';
			$stmt = $this->db->prepare($sql);
			$stmt->bindValue(':phoneSE',$deviceID,PDO::PARAM_STR);
			$stmt->bindValue(':OStype',$ostype,PDO::PARAM_INT);
			$stmt->bindValue(':userID',$userID,PDO::PARAM_STR);
			$status = $stmt->execute();
			$this->db->commit();
			if($status == true){
				return 1;
			} else {
				return 0;
			}
		}catch (PDOException $pex) {
			$this->db->rollBack();
			echo "에러 : ".$pex->getMessage();
		}
	}//end

	// 장치번호 초기화
	public function EquipReset($userID){
		try{
			$this->db->beginTransaction();
			$ostype = 0;
			$sql='update members set phoneSE=NULL,OStype=:OStype where userID=:userID';
			$stmt = $this->db->prepare($sql);
			$stmt->bindValue(':OStype',$ostype,PDO::PARAM_INT);
			$stmt->bindValue(':userID',$userID,PDO::PARAM_STR);
			$status = $stmt->execute();
			$this->db->commit();
			if($status == true){
				return 1;
			} else {
				return 0;
			}
		} catch (PDOException $pex) {
			$this->db->rollBack();
			echo "에러 : ".$pex->getMessage();
		}
	}//end

    // 회원 가입 여부 체크
    public function isUserExisted($userID) {
        $stmt = $this->db->prepare("SELECT userID from members WHERE userID=:userID");
		$stmt->bindValue(':userID',$userID,PDO::PARAM_STR);
        $stmt->execute();
        if ($stmt->rowCount() > 0) {
            return true;
        } else {
            return false;
        }
    }

	// 회원 정보 삭제
	public function deleteUser($userID){
		try{
			$this->db->beginTransaction();
			$stmt = $this->db->prepare("delete FROM members WHERE userID=:userID");
			$stmt->bindValue(':userID',$userID,PDO::PARAM_STR);
			$stmt->execute();
			$this->db->commit();
		}catch (PDOException $pex) {
			$this->db->rollBack();
			echo "에러 : ".$pex->getMessage();
		}
	}

    public function hashSSHA($password) {
        $salt = sha1(rand());
        $salt = substr($salt, 0, 10);
        $encrypted = base64_encode(sha1($password . $salt, true) . $salt);
        $hash = array("salt" => $salt, "encrypted" => $encrypted);
        return $hash;
    }

    public function checkhashSSHA($salt, $password) {
        $hash = base64_encode(sha1($password . $salt, true) . $salt);
        return $hash;
    }
}
?>
