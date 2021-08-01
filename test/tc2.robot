
*** Settings ***
Library  AppiumLibrary
Library  OperatingSystem
Resource  base.robot
Resource    tc2-args.robot
Test Teardown  base.Screenshot

*** Variables ***

*** Keywords ***

*** Test Cases ***
Network Connection Open
    [Tags]    Sepete Ekleme İşlemi
    Set Appium Timeout  30s
    base.Open the application
    Wait Until Page Contains    ${ProductAndCategoryText}
    Click Element    ${AccountLocator}
    Wait Until Page Contains    ${LoginText}
    Click Text    ${LoginText}
    Wait Until Page Contains    ${SignUpText}
    Sleep    6s
    Input Text    ${EmailLocator}    test@gmail.com
    Input Text    ${PasswordLocator}    password
    Sleep    2s
    Click Element    ${LoginLocator}
    Wait Until Page Contains    ${WelcomeText} 
    Click Text    ${Ok}
    base.Close the application    
    