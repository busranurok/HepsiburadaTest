*** Settings ***
Library  AppiumLibrary
Library  OperatingSystem
Resource  connection.robot

*** Variables ***
${MAIL}   test30@mobisoft.com.tr
${PASSWORD}  *Aa123456

*** Keywords ***

Run Timeout Session Response Mitm
    [Arguments]  ${requestUrl}  ${timeoutSeconds}
    Run  cat /dev/null > ../mitmproxy/requestUrl.py
    Run  cat /dev/null > ../mitmproxy/valueSecond.py
    Run  echo "${requestUrl}" >> ../mitmproxy/requestUrl.py
    Run  echo "${timeoutSeconds}" >> ../mitmproxy/valueSecond.py
    Run Mitm Mock  ../mitmproxy/mitmTimeoutErrorSessionResponse.py
    sleep  1s

Run Session Expired Login Fail Mitm
    [Arguments]  ${requestUrl}
    Run  cat /dev/null > ../mitmproxy/requestUrl.py
    Run  echo "${requestUrl}" >> ../mitmproxy/requestUrl.py
    Run Mitm Mock  ../mitmproxy/mitmSessionExpiredLoginFail.py
    sleep  1s

Run Session Expired Login Success Mitm
    [Arguments]  ${requestUrl}
    Run  cat /dev/null > ../mitmproxy/requestUrl.py
    Run  echo "${requestUrl}" >> ../mitmproxy/requestUrl.py
    Run Mitm Mock  ../mitmproxy/mitmSessionExpiredLoginSuccess.py
    sleep  1s

Run Success Reqeust Mitm
    [Arguments]  ${requestUrl}
    Run  cat /dev/null > ../mitmproxy/requestUrl.py
    Run  echo "${requestUrl}" >> ../mitmproxy/requestUrl.py
    Run Mitm Mock  ../mitmproxy/mitmSuccess.py
    sleep  1s

Run Success Without Message Reqeust Mitm
    [Arguments]  ${requestUrl}
    Run  cat /dev/null > ../mitmproxy/requestUrl.py
    Run  echo "${requestUrl}" >> ../mitmproxy/requestUrl.py
    Run Mitm Mock  ../mitmproxy/mitmSuccessWithoutMessage.py
    sleep  1s

Run Fail Without Message Reqeust Mitm
    [Arguments]  ${requestUrl}
    Run  cat /dev/null > ../mitmproxy/requestUrl.py
    Run  echo "${requestUrl}" >> ../mitmproxy/requestUrl.py
    Run Mitm Mock  ../mitmproxy/mitmFailWithoutMessage.py
    sleep  1s

Run Fail Reqeust Mitm
    [Arguments]  ${requestUrl}
    Run  cat /dev/null > ../mitmproxy/requestUrl.py
    Run  echo "${requestUrl}" >> ../mitmproxy/requestUrl.py
    Run Mitm Mock  ../mitmproxy/mitmFail.py
    sleep  1s

Run Http500 Reqeust Mitm
    [Arguments]  ${requestUrl}
    Run  cat /dev/null > ../mitmproxy/requestUrl.py
    Run  echo "${requestUrl}" >> ../mitmproxy/requestUrl.py
    Run Mitm Mock  ../mitmproxy/mitmHttp500.py
    sleep  1s

Clean Mitm Mock
    Run  cat /dev/null > ../mitmproxy/genericMock.py

Run Mitm Mock
    [Arguments]  ${mockPath}
    Run  cat ${mockPath} > ../mitmproxy/genericMock.py

Kw Insensitive Click
    [Arguments]  ${text}
    ${status}  ${aa} =   Run Keyword And Ignore Error  Kw Click Text  ${text}
    RETURN FROM KEYWORD IF  "${status}" == "PASS"
    #${text}  getUpperCase  ${text}
    ${status}  ${aa} =   Run Keyword And Ignore Error  Kw Click Text  ${text}
    RETURN FROM KEYWORD IF  "${status}" == "PASS"
    #${text}  getLowerCase  ${text}
    Kw Click Text  ${text}

Kw Go Url
    [Arguments]  ${url}
    go to url  ${url}

Kw Click Text
    [Arguments]  ${text}
    click text  ${text}  exact_match=False
    [return]  aaa


Kw Insensitive Should Be Equals
    [Arguments]  ${text}  ${locatorText}
    ${status}  ${aa} =   Run Keyword And Ignore Error  Kw Should Be Equals  ${text}  ${locatorText}
    RETURN FROM KEYWORD IF  "${status}" == "PASS"
    #${text}  getUpperCase  ${text}
    ${status}  ${aa} =   Run Keyword And Ignore Error  Kw Should Be Equals  ${text}  ${locatorText}
    RETURN FROM KEYWORD IF  "${status}" == "PASS"
    #${text}  getLowerCase  ${text}
    Kw Should Be Equals  ${text}  ${locatorText}

Kw Should Be Equals
    [Arguments]  ${text}  ${locatorText}
    should be equal as strings  ${text}  ${locatorText}
    [return]  aaa


Click Free Cargo
    Scroll To Contains  0,00  down
    click text  0,00

Screenshot
    Run Keyword And Ignore Error  connection.Screenshot

Open the application
    connection.Open the application

Close the application
    connection.Close the application

Open the application With Reset
    connection.Open the application With Reset


Open LoginFragment
    Wait Until Page Contains Element  id=btn_ic_header_account
    Wait Until Page Does Not Contain Element  id=globalProgress
    Click Element  id=btn_ic_header_account
    Wait Until Page Contains Element  id=btn_login
    Click Element  id=btn_login
    Wait Until Page Contains Element  id=textview_mail

Logout
    Wait Until Page Contains Element  id=btn_ic_header_account
    Wait Until Page Does Not Contain Element  id=globalProgress
    Click Element  id=btn_ic_header_account
    Wait Until Element Is Visible  id=ln_active_login  timeout=20s
    scroll to id  ln_logout  down
    click element  ln_logout
    sleep  0.5s
    click text  Tamam
    wait until page does not contain  Tamam
    swipe by percent  50  30  50  70  1000
    swipe by percent  50  30  50  70  1000
    Wait Until Element Is Visible  id=ln_passive_login  timeout=20s


Kw Go Odeme Tipi Sayfası
    [Arguments]  ${type}
    wait until element is visible  id=navigation_cart
    Click Element  id=navigation_cart
    Wait Until Page Contains  Satın Al
    sleep  2s
    Wait Until Page Contains Element  id=overflowImageButton
    Wait Until Page Does Not Contain Element  id=progress
    Click Element  id=confirmBasketButton
    Wait Until Page Does Not Contain  Sepetim
    Wait Until Page Contains  Devam Et
    sleep  2s
    Wait Until Page Does Not Contain Element  id=progress
    Click Element  id=continueButton
    Wait Until Page Does Not Contain  Kargo Adresi Seçimi
    Wait Until Page Contains  Kargo Paket Seçimi
    sleep  2s
    Wait Until Page Does Not Contain Element  id=progress
    Run Keyword If  "${type}" == "free"  Click Free Cargo
    Click Element  id=continueButton
    Wait Until Page Does Not Contain  Kargo Paket Seçimi
    Wait Until Page Contains  Ödeme Seçenekleri
    wait until page does not contain element  id=progress

Scroll To Contains
    [Arguments]  ${contains}  ${direction}
    ${visibleElement}  ${aa} =   Run Keyword And Ignore Error  Kw Wait Until Contains  ${contains}  1s
    Run Keyword If  "${visibleElement}" == "FAIL"  Loop Scroll Contains  ${contains}  ${direction}

Scroll To Contains Small
    [Arguments]  ${contains}  ${direction}
    ${visibleElement}  ${aa} =   Run Keyword And Ignore Error  Kw Wait Until Contains  ${contains}  1s
    Run Keyword If  "${visibleElement}" == "FAIL"  Loop Scroll Contains Small  ${contains}  ${direction}

Loop Scroll Contains Small
    [Arguments]  ${contains}  ${direction}
    FOR    ${i}    IN RANGE    10
        Run Keyword If  "${direction}" == "down"  scroll down
        Run Keyword If  "${direction}" == "up"  scroll up
        ${visibleElement}  ${aa} =   Run Keyword And Ignore Error  Kw Wait Until Contains  ${contains}  1s
        Exit For Loop If    "${visibleElement}" == "PASS"
    END

Kw Wait Until Contains
    [Arguments]  ${contains}  ${timeout}
    wait until page contains  ${contains}  timeout=${timeout}
    [return]  test

Loop Scroll Contains
    [Arguments]  ${contains}  ${direction}
    FOR    ${i}    IN RANGE    10
        Run Keyword If  "${direction}" == "down"  scroll down big
        Run Keyword If  "${direction}" == "up"  scroll up
        ${visibleElement}  ${aa} =   Run Keyword And Ignore Error  Kw Wait Until Contains  ${contains}  1s
        Exit For Loop If    "${visibleElement}" == "PASS"
    END

scroll down big
    swipe by percent  50  90  50  70  1000

progress show and hide
    Run Keyword And Ignore Error  Kw wait until page contains element  progress  1s
    wait until page does not contain element  id=progress


Kw wait until page contains element
    [Arguments]  ${idElement}  ${timeout}
    wait until page contains element  id=${idElement}  timeout=${timeout}

Scroll To Id
    [Arguments]  ${visibleId}  ${direction}
    ${visibleElement}  ${aa} =   Run Keyword And Ignore Error  Kw Wait Until Element Is Visible  ${visibleId}  1s
    Run Keyword If  "${visibleElement}" == "FAIL"  Loop Scroll  ${visibleId}  ${direction}

Scroll To Locator
    [Arguments]  ${locator}  ${direction}
    ${visibleElement}  ${aa} =   Run Keyword And Ignore Error  Kw Wait Until Element Is Visible Locator  ${locator}  1s
    Run Keyword If  "${visibleElement}" == "FAIL"  Loop Scroll Locator  ${locator}  ${direction}


Loop Scroll Locator
    [Arguments]  ${locator}  ${direction}
    FOR    ${i}    IN RANGE    10
        Run Keyword If  "${direction}" == "down"  scroll down
        Run Keyword If  "${direction}" == "up"  scroll up
        ${visibleElement}  ${aa} =   Run Keyword And Ignore Error  Kw Wait Until Element Is Visible Locator  ${locator}  1s
        Exit For Loop If    "${visibleElement}" == "PASS"
    END


Kw Wait Until Element Is Visible Locator
    [Arguments]  ${locator}  ${timeout}
    Wait Until Element Is Visible  ${locator}  timeout=${timeout}
    [return]  test


Loop Scroll
    [Arguments]  ${visibleId}  ${direction}
    FOR    ${i}    IN RANGE    10
        Run Keyword If  "${direction}" == "down"  scroll down
        Run Keyword If  "${direction}" == "up"  scroll up
        ${visibleElement}  ${aa} =   Run Keyword And Ignore Error  Kw Wait Until Element Is Visible  ${visibleId}  1s
        Exit For Loop If    "${visibleElement}" == "PASS"
    END

scroll down
    swipe by percent  50  50  50  30  1000

scroll up
    swipe by percent  50  40  50  60  1000

Success Login
    Open LoginFragment
    Input Text  id=textview_mail  ${MAIL}
    Input Password  id=textview_password  ${PASSWORD}
    Click Element  id=loginButton
    Wait Until Element Is Visible  id=ln_active_login  timeout=20s

Password Expired Login
    Open LoginFragment
    Input Text  id=textview_mail  ${MAIL}
    Input Password  id=textview_password  ${PASSWORD}
    Click Element  id=loginButton
    wait until page contains  Şifrenizin kullanım süresi dolmuştur. Şifre sıfırlama linki e-posta adresinize gönderilmiştir.
    click text  Tamam
    wait until page does not contain  Şifrenizin kullanım süresi dolmuştur. Şifre sıfırlama linki e-posta adresinize gönderilmiştir.


Masterpass Success Login
    Open LoginFragment
    Input Text  id=textview_mail  ${MAIL}
    Input Password  id=textview_password  ${PASSWORD}
    Click Element  id=loginButton
    Wait Until Element Is Visible  id=ln_active_login  timeout=20s


Fail Login
    Open LoginFragment
    Input Text  id=textview_mail  ${MAIL}aaaa
    Input Password  id=textview_password  ${PASSWORD}cccc
    Click Element  id=loginButton
    Wait Until Page Contains  E-Posta Adresi ya da şifreniz yanlış. Şifrenizi girerken büyük küçük harf ayrımına dikkat ediniz.
    click text  Tamam
    wait until page does not contain  E-Posta Adresi ya da şifreniz yanlış. Şifrenizi girerken büyük küçük harf ayrımına dikkat ediniz.


Success Login And Go Home Page
    [Arguments]  ${type}
    Run Keyword If  "${type}" == "normal"  Success Login
    Run Keyword If  "${type}" == "masterpass"  Masterpass Success Login
    Go Back
    Wait Until Page Contains Element  id=btn_ic_header_account
    Wait Until Page Does Not Contain Element  id=globalProgress



Return Variable
    [Arguments]  ${v}
    [return]  ${v}

Kw Wait Until Element Is Visible
    [Arguments]  ${id}  ${timeout}
    Wait Until Element Is Visible  id=${id}  timeout=${timeout}
    [return]  test


Kw Contains Text
   [Arguments]  ${text}  ${timeout}
   wait until page contains  ${text}  timeout=${timeout}
   [return]  test

Kw Sepeti Bosalt
    wait until element is visible  id=navigation_cart
    Wait Until Page Does Not Contain Element  id=globalProgress
    Click Element  id=navigation_cart
    sleep  1s
    Wait Until Page Does Not Contain Element  id=progress
    FOR    ${i}    IN RANGE    999999
        Run Keyword And Ignore Error  Remove Cart
        ${visibleCartCount}  ${aa} =   Run Keyword And Ignore Error  Kw Contains Text  Sepetiniz boş!  1s
        Exit For Loop If    "${visibleCartCount}" == "PASS"
    END

Remove Cart
    Click Element  id=overflowImageButton
    wait until page contains  Kaldır
    Click Text  Kaldır
    Wait Until Page Contains  Sepetiniz güncellendi

Success Add To Cart
    scroll to locator  xpath=//android.view.View[@content-desc="Çok Satanlar Tümü"]  down
    click element  xpath=//android.view.View[@content-desc="Çok Satanlar Tümü"]
    Wait Until Page Contains Element  id=title
    ${Product_Name}  Get Text  id=title
    Click Element  id=title
    Wait Until Page Contains Element  id=addToFavoritesButton
    ${Cart_Count} =    Set Variable  0
    ${status}  ${Cart_Count} =    Run Keyword And Ignore Error  Get Cart Count
    Run Keyword If  "${status}" == "FAIL"  Empty Cart Count State  ${Product_Name}
    Run Keyword If  "${status}" == "PASS"  Fill Cart Count State  ${Product_Name}


Empty Cart Count State
    [Arguments]  ${Product_Name}
    ${Cart_Count} =    Set Variable  0
    Click Add To Cart  ${Cart_Count}  ${Product_Name}



Fill Cart Count State
    [Arguments]  ${Product_Name}
    ${Cart_Count}  Get Text  id=badge_text_view
    Click Add To Cart  ${Cart_Count}  ${Product_Name}

Click Add To Cart
    [Arguments]  ${Cart_Count}  ${Product_Name}
    ${Cart_Button_Text}  Get Text  id=addToCart
    Click Element  id=addToCart
    Run Keyword If  "${Cart_Button_Text}" == "Sepetinizde +"  Check Button Text And Toast  bulunmaktadır.  ${Cart_Count}  ${Product_Name}
    Run Keyword If  "${Cart_Button_Text}" == "Sepete Ekle"  Check Button Text And Toast  eklendi!  ${Cart_Count}  ${Product_Name}


Check Button Text And Toast
    [Arguments]  ${Toast}  ${Cart_Count}  ${Product_Name}
    Wait Until Page Contains  ${Toast}
    Wait Until Page Does Not Contain  ${Toast}
    Element Should Contain Text  id=addToCart  Sepetinizde +
    ${Cart_Count} =  Convert To Integer  ${Cart_Count}
    ${ExpectedCount} =    Set Variable    ${Cart_Count + 1}
    ${ExpectedCount} =  Convert To String  ${ExpectedCount}
    Element Text Should Be  id=badge_text_view  ${ExpectedCount}
    Click Element  id=navigation_cart
    Wait Until Page Contains  Sepetim
    wait until page contains element  id=productTitle
    ${Product_Name_New}  Get Text  id=productTitle
    should contain  ${Product_Name_New}  ${Product_Name}

Get Cart Count
    ${Cart_Count}  Get Text  id=badge_text_view
    [return]  ${Cart_Count}
    
Title Should Be
    [Arguments]  ${titleText}
    wait until page contains element  id=back_button_center_text
    FOR    ${i}    IN RANGE    10
        ${realTitle}  Get Text  id=back_button_center_text
        ${status}=    Run Keyword And Return Status    should be equal as strings  "${realTitle}"  "${titleText}"
        Exit For Loop If    ${status} == True
        sleep  1s
    END
    ${realTitle}  Get Text  id=back_button_center_text
    should be equal as strings  "${realTitle}"  "${titleText}"
    
