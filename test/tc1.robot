*** Settings ***
Library  AppiumLibrary
Library  OperatingSystem
Resource  base.robot
Resource  tc1-args.robot
Test Teardown  base.Screenshot

*** Variables ***

*** Keywords **
Kw Wait Until Contains
    [Arguments]  ${contains}  ${timeout}
    wait until page contains  ${contains}  timeout=${timeout}
    [return]  test
    
Scroll Down Big
    swipe by percent  5  60  5  20   1000
    
Up Scroll
    swipe by percent  5  40  5  60  1000

Loop Scroll Contains
    [Arguments]  ${contains}  ${direction}
    FOR    ${i}    IN RANGE    5
        Run Keyword If  "${direction}" == "down"  Scroll Down Big
        Run Keyword If  "${direction}" == "up"  Up Scroll
        ${visibleElement}  ${aa} =   Run Keyword And Ignore Error  Kw Wait Until Contains  ${contains}  1s
        Exit For Loop If    "${visibleElement}" == "PASS"
    END

Scroll To Contains
    [Arguments]  ${contains}  ${direction}
    ${visibleElement}  ${aa} =   Run Keyword And Ignore Error  Kw Wait Until Contains  ${contains}  1s
    Run Keyword If   "${visibleElement}" == "FAIL"  Loop Scroll Contains  ${contains}  ${direction}



*** Test Cases ***
Network Connection Open
    [Tags]    Sepete Ekleme İşlemi
    Set Appium Timeout  30s
    base.Open the application
    Wait Until Page Contains    ${ProductAndCategoryText}
    Click Text    ${CategoriesText}
    Wait Until Page Contains    ${SpecialForYouText}
    Scroll To Contains    ${BookMenuText}    down
    Click Text     ${BookMenuText}
    Wait Until Page Contains    ${BookAndMagazineText}
    Click Text    ${BestSellerText}
    Wait Until Page Contains    ${SortbyText}
    Scroll To Contains    ${AddtoCartText}    down
    Click Text    ${AddtoCartText}
    Wait Until Page Does Not Contain    ${TheProductHasBeenSuccessfullyAddedtoTheCartText}
    Click Text    ${CategoriesText} 
    Wait Until Page Contains    ${BookAndMagazineText}
    Click Text    ${ChildrensBooks}
    Wait Until Page Contains    ${SortbyText}
    Scroll To Contains    ${AddtoCartText}    down
    Click Text    ${AddtoCartText}
    Wait Until Page Does Not Contain    ${TheProductHasBeenSuccessfullyAddedtoTheCartText}
    Click Text    ${CategoriesText}
    Wait Until Page Contains    ${SpecialForYouText}
    Click Text    ${BasketText}
    Wait Until Page Contains    ${CheckoutText}
    base.Close the application
    