*** Settings ***
Documentation       Search Google
Library             SeleniumLibrary
Test Teardown       Close Browser

*** Variables ***
${HepsiburadaUrl}           https://www.hepsiburada.com


*** Keywords ***
Switch to English language
    Click Element   xpath://a[contains(text(), "English")]

Enter Keyword
    [Arguments]     ${keyword}
    Input Text      xpath://input[@name="q"]     ${keyword}

Click Search Button
    Wait Until Element Is Visible       xpath://input[@value="Google Search"]
    Click Element                       xpath://input[@value="Google Search"]
    
Open Url
    [Arguments]     ${browser}    ${url}
    ${options}=    Evaluate  sys.modules['selenium.webdriver.chrome.options'].Options()    sys
    Call Method     ${options}    add_argument    --disable-notifications
    Create WebDriver        ${browser}    options=${options}
    Maximize Browser Window
    Go To                   ${url}
    Wait For Condition      return !!document.body

Open Url With Chrome
    [Arguments]     ${url}
    Open Url        Chrome    ${url}

Open Url With Firefox
    [Arguments]     ${url}
    Open Url        Firefox    ${url}



*** Test Cases ***
Search Google with "Google Search" button via Chrome
    Open Url With Chrome            ${HepsiburadaUrl}
    Wait Until Element Is Visible       xpath://input[@class="desktopOldAutosuggestTheme-input"]  
    Input Text      xpath://input[@class="desktopOldAutosuggestTheme-input"]     Xiaomi
    Sleep    3s
    Click Element    xpath://div[@class="SearchBoxOld-buttonContainer"]
    Sleep    10s
    Wait Until Element Is Visible       xpath://a[@sorttag="coksatan"] 
    Click Element    xpath://h3[contains(@class, 'product-title') and contains(@class, 'title')][1]
    Wait Until Element Is Visible    xpath://span[@class="addToCartButton"]
    Click Element    xpath://span[@class="addToCartButton"]
    Wait Until Element Is Visible    xpath://*[contains(text(), 'Alışverişe devam et')]
    Click Element     xpath://*[contains(text(), 'Sepete git')]
    Sleep    2s
    Wait Until Element Is Visible    xpath://h1[contains(text(), 'Sepetim')]
    Sleep    2s
    Close Browser    




