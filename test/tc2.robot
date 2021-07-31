*** Settings ***
Library    AppiumLibrary
Library    Collections
Library    String
Resource  base.robot
Resource  tc2-args.robot
Test Teardown    base.Screenshot

*** Variables ***

*** Keywords *** 
For Loop and If Control for Adding Carts
    FOR    ${INDEX}    IN RANGE    1    3
        Click Element   xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.view.View/android.widget.FrameLayout/android.widget.RelativeLayout/android.view.View/android.view.View[${INDEX}]
        Wait Until Page Contains    ${PRODUCT-DETAIL-TEXT}
        Click Element    ${ADD-TO-CART-BUTTON}
        Wait Until Page Contains    ${TEXT}
        ${BOOK-NAME} =    Get Text     id=com.mobisoft.kitapyurdu:id/bookText
        Append To List      ${BOOK-NAMES}       ${BOOK-NAME}
        Click Element    ${BACK-BUTTON}
        wait until page contains element  id=constraintLayoutMain
        ${INDEX} =    Set Variable    ${INDEX}+1
    END
    
Check The Basket
    Click Text    ${MY-BASKET-TEXT}
    Wait Until Page Contains    ${MY-SHOPPING-LIST-TEXT}
    ${count}=    Get length    ${BOOK-NAMES}
    FOR  ${i}  IN RANGE  ${count}
        wait until page contains  ${BOOK-NAMES}[${i}]
    END

Click Process to Detail the Product
    Wait Until Page Contains Element  ${categoryItem_locator}
    FOR    ${COUNT}    IN RANGE    99
        ${title}  Get Text From Category Item
        Click Element    ${categoryItem_locator}
        base.progress show and hide
        Title Should Be  ${title}
        ${status}=    Run Keyword And Return Status    Wait Until Page Contains Element  id=constraintLayoutMain  timeout=1s
        Exit For Loop If    ${status} == True
    END

Get Text From Category Item
    ${categoryTitle}  Get Text  ${categoryItem_locator}
    ${splits} =  Split String  ${categoryTitle}  ${SPACE}
    ${count}=    Get length    ${splits}
    ${title} =    Set Variable    ${SPACE}
    FOR    ${i}    IN RANGE    ${count}-1
        ${title} =    Set Variable    ${title} ${splits}[${i}]
    END
    ${title}=	Strip String	${title}
    [return]  ${title}

*** Test Cases ***
Add To Cart
    [Tags]    Sepete Ekleme İşlemleri
    Set Appium Timeout  30s
    base.Open the application
    Wait Until Page Contains Element  id=btn_ic_header_account
    Wait Until Page Does Not Contain Element  id=globalProgress
    base.Kw Sepeti Bosalt
    Wait Until Page Contains     ${CATEGORIES-TEXT}
    Progress Show and Hide
    Click Element    ${CATEGORIES-BUTTON}
    Wait Until Page Contains     ${CATEGORIES-TEXT}
    Click Process to Detail the Product
    For Loop and If Control for Adding Carts  
    Check The Basket
    base.Close the application
