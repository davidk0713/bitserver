$(function() {
    // 로그인 처리
    $('#login-submit').click(function(e) {
        e.preventDefault();
        //alert(window.location.pathname); // 현재 경로 확인
        if ($("#userid").val() == '') {
            alert('아이디를 입력하세요');
            $("#userid").focus();
            return false;
        }

        if ($("#password").val() == '') {
            alert('비밀번호를 입력하세요');
            $("#password").focus();
            return false;
        }

        $.ajax({
            url : 'loginChk.php',
            type : 'POST',
            data : {
                userid : $('#userid').val(),
                password : $('#password').val()
            },
            dataType : "json",
            success : function(response) {
                if (response.result == 1) {
                    //alert('로그인 성공');
                    location.replace('../index.php'); // 화면 갱신
                    //location.reload(); // 화면 갱신
                } else if (response.result == -2) {
                    alert('입력된 값이 없습니다');
                } else {
                    alert('로그인 실패');
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                alert("arjax error : " + textStatus + "\n" + errorThrown);
            }
        });
    });

    // 회원 정보 수정
    $('#join-modify').click(function(e) {
        e.preventDefault();
        if ($("#memberName").val() == '') {
            alert('이름을 입력하세요');
            $("#memberName").focus();
            return false;
        }

        var email = $('#memberEmail').val();
        if (email !== 'admin') {
            if (email == '') {
                alert('이메일을 입력하세요');
                $("#memberEmail").focus();
                return false;
            } else {
                var emailRegex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                if (!emailRegex.test(email)) {
                    alert('이메일 주소가 유효하지 않습니다. ex)abc@gmail.com');
                    $("#memberEmail").focus();
                    return false;
                }
            }
        }

        if ($("#memberMobile").val() == '') {
            alert('휴대폰 번호를 입력하세요');
            $("#memberMobile").focus();
            return false;
        }

        $.ajax({
            url : 'ModifyMember.php',
            type : 'POST',
            data : {
                uid : $("#memberuid").val(),
                userNM : $("#memberName").val(),
                mobileNO : $("#memberMobile").val()
            },
            dataType : "json",
            contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
            success : function(response) {
                //alert(response); // 메시지 검증 목적
                if (response.result == 1) {
                    alert('수정 완료');
                    location.replace('index.php');
                    // 화면 갱신
                }
                if (response.result == 0) {
                    alert('수정 실패');
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                alert("arjax error : " + textStatus + "\n" + errorThrown);
            }
        });

    });

    // 비밀번호 찾기
    $('#passwd-lost').click(function() {
        // 모달 창 닫기
        $('#modal-login').modal('hide');
        //alert(window.location.pathname); // 현재 경로 확인
        if (window.location.pathname.split('/').pop() != 'passwd_search.php') {// 현재 실행 파일명
            location.replace('passwd_search.php');
        }
    });

    function hrefLoad(uri) {
        $('#panel_content').load(uri, function() {

            tabJoin();

        });
    }

});
