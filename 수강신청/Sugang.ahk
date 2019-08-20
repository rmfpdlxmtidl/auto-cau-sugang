version=1.24
gui,+alwaysontop
gui,show,x0 y0 w900 h0,매크로가 대기 중입니다. 실행(F3) 간단(F4) 일시정지(F6) 종료(F12)
time:=300

F6::
Pause
return



F12::
Exitapp

F5::
loop
{
    MouseGetpos, vx, vy 
    gui,show,x0 y0 w900 h0, x: %vx%   y: %vy%   일시정지(F6) 종료(F12)
    sleep, 100
}

F4::
gui,show,x0 y0 w900 h0,간단 모드 실행 중입니다.
loop
{
    mousemove, 200, 485, 3
    sleep, %time%
    send, {click}
    gui,show,x0 y0 w900 h0,장바구니 클릭. 일시정지(F6) 종료(F12)
    random, x, 4000, 5000
    sleep, x
}


F3::
gui,show,x0 y0 w900 h0,매크로가 실행 중입니다. 일시정지(F6) 종료(F12)
try=0
fail=0
fail2=0
fail3=0
miss=0
miss2=0
miss3=0
loop
{
    try+=1
    mousemove, 200, 485, 3
    sleep, %time%
    send, {click}
    gui, show, x0 y0 w900 h0, 장바구니: %try%. / 강의1여석X: %fail%. 강의1신청: %miss%. / 강의2여석X: %fail2%. 강의2신청: %miss2%. / 강의3여석X: %fail3%. 강의3신청: %miss3%. / 장바구니 클릭.
    sleep, %time%
    
    a=0 // '신청' 이미지 찾기 시간 제한.
    b=0 // b=1 '신청' 이미지 못 찾음. b=0 그 외.
    loop
    {
        gui, show, x0 y0 w900 h0, 장바구니: %try%. / 강의1여석X: %fail%. 강의1신청: %miss%. / 강의2여석X: %fail2%. 강의2신청: %miss2%. / 강의3여석X: %fail3%. 강의3신청: %miss3%. / 신청.
        a+=1
        imagesearch, xp, yp, 500, 600, 600, 700, *50 신청.png
        
        /* 신청 버튼 찾으면
        */
        if(Errorlevel = 0)
        {
            break
        }
        sleep, 500

        /* 일정 시간(5초) 내 신청 버튼 못 찾으면
        */
        if(a>9)
        {
            b=1
            break
        }
    }

    /* 일정 시간(2.5초) 내 신청 버튼 못 찾았을 때
    */
    if(b=1)
    {
        a=0
        gui, show, x0 y0 w900 h0, 장바구니: %try%. / 강의1여석X: %fail%. 강의1신청: %miss%. / 강의2여석X: %fail2%. 강의2신청: %miss2%. / 강의3여석X: %fail3%. 강의3신청: %miss3%. / 대화상자 처리.
        
        /* 처리가 지연되고 있습니다. 등 대화상자 처리 
        */
        loop
        {
            a+=1
            imagesearch, xp, yp, 1500, 200, 1800, 300, *50 확인.png

            /* 확인 이미지 찾으면
            */
            if(Errorlevel = 0)
            {
                sleep, %time%
                mousemove, xp+20, yp+20, 3
                sleep, %time%
                send, {click}
                gui, show, x0 y0 w600 h0, 확인. 일시정지(F6) 종료(F12)
                sleep, %time%
                break
            }
            sleep, 500

            /* 일정 시간(2.5초) 내 대화상자 못 찾으면
            */
            if(a>5)
            {
                break
            }
        }
        continue
    }
    
    /* 강의1 신청
    */
    sleep, %time%
    c=0
    loop 5
    {
        gui, show, x0 y0 w900 h0, 장바구니: %try%. / 강의1여석X: %fail%. 강의1신청: %miss%. / 강의2여석X: %fail2%. 강의2신청: %miss2%. / 강의3여석X: %fail3%. 강의3신청: %miss3%. / 강의1.
        imagesearch, xp, yp, 2100, 600, 2450, 690, *20 강의1.png
        if(Errorlevel = 0)
        {
            fail+=1
            gui, show, x0 y0 w900 h0, 장바구니: %try%. / 강의1여석X: %fail%. 강의1신청: %miss%. / 강의2여석X: %fail2%. 강의2신청: %miss2%. / 강의3여석X: %fail3%. 강의3신청: %miss3%. / 강의1 여석 없음.
            c+=1
            break
        }
    }
    if(c=0)
    {
        miss+=1
        gosub 강의1
    }

    /* 강의2 신청
    */
    sleep, %time%
    d=0
    loop 5
    {
        gui, show, x0 y0 w900 h0, 장바구니: %try%. / 강의1여석X: %fail%. 강의1신청: %miss%. / 강의2여석X: %fail2%. 강의2신청: %miss2%. / 강의3여석X: %fail3%. 강의3신청: %miss3%. / 강의2.
        imagesearch, xp, yp, 2100, 660, 2450, 760, *50 강의2.png
        if(Errorlevel = 0)
        {
            fail2+=1
            gui, show, x0 y0 w900 h0, 장바구니: %try%. / 강의1여석X: %fail%. 강의1신청: %miss%. / 강의2여석X: %fail2%. 강의2신청: %miss2%. / 강의3여석X: %fail3%. 강의3신청: %miss3%. / 강의2 여석 없음.
            d+=1
            break
        }
    }
    if(d=0)
    {
        miss2+=1
        gosub 강의2
    }

     /* 강의3 신청
    */
    sleep, %time%
    e=0
    loop 5
    {
        gui, show, x0 y0 w900 h0, 장바구니: %try%. / 강의1여석X: %fail%. 강의1신청: %miss%. / 강의2여석X: %fail2%. 강의2신청: %miss2%. / 강의3여석X: %fail3%. 강의3신청: %miss3%. / 강의3.
        imagesearch, xp, yp, 2100, 730, 2450, 830, *50 강의3.png
        if(Errorlevel = 0)
        {
            fail3+=1
            gui, show, x0 y0 w900 h0, 장바구니: %try%. / 강의1여석X: %fail%. 강의1신청: %miss%. / 강의2여석X: %fail2%. 강의2신청: %miss2%. / 강의3여석X: %fail3%. 강의3신청: %miss3%. / 강의3 여석 없음.
            e+=1
            break
        }
    }
    if(e=0)
    {
        miss3+=1
        gosub 강의3
    }

    sleep, %time%
    gui, show, x0 y0 w900 h0, 서버 요청 주기 조정 중...!
    random, t, 50, 700
    sleep, t
}



강의1:
    mousemove, 550, 650, 3
    sleep, %time%
    send, {click}
    gui,show,x0 y0 w900 h0,강의1 클릭.일시정지(F6) 종료(F12)
    sleep, %time%
    
    gosub 수강신청
return


강의2: 
    mousemove, 550, 710, 3
    sleep, %time%
    send, {click}
    gui, show, x0 y0 w900 h0, 강의2 클릭.일시정지(F6) 종료(F12)
    sleep, %time%

    gosub 수강신청
return


강의3:
    mousemove, 550, 780, 3
    sleep, %time%
    send, {click}
    gui, show, x0 y0 w900 h0, 강의3 클릭.일시정지(F6) 종료(F12)
    sleep, %time%

    gosub 수강신청
return


수강신청:
    loop
    {
        imagesearch, xp, yp, 1500, 200, 1800, 300, *50 확인.png
        if(Errorlevel = 0)
        {
            break
        }
    }
    sleep, %time%
    mousemove, xp+20, yp+20, 3
    sleep, %time%
    send, {click}
    gui,show,x0 y0 w900 h0,확인1 클릭.일시정지(F6) 종료(F12)
    sleep, %time%

    loop
    {
        imagesearch, xp, yp, 1500, 200, 1800, 300, *50 확인.png
        if(Errorlevel = 0)
        {
            break
        }
    }
    sleep, %time%
    mousemove, xp+20, yp+20, 3
    sleep, %time%
    send, {click}
    gui,show,x0 y0 w900 h0, 확인2 클릭.일시정지(F6) 종료(F12)
    sleep, %time%
return


