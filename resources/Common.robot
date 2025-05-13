*** Settings ***
Library                     SeleniumLibrary
Library                     BuiltIn

*** Keywords ***
Create Chrome Options
    ${selenium}=            Evaluate        sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method             ${selenium}     add_argument    --headless
    Call Method             ${selenium}     add_argument    --enable-logging
    Call Method             ${selenium}     add_argument    --disable-popup-blocking
    Call Method             ${selenium}     add_argument    --disable-infobars
    Call Method             ${selenium}     add_argument    --disable-dev-shm-usage
    Call Method             ${selenium}     add_argument    --start-maximized
    RETURN                  ${selenium}

Wait For Element And Find It
    [Arguments]             ${locator}
    Wait Until Element Is Visible    ${locator}     timeout=10s

Input Text With Wait
    [Arguments]             ${locator}              ${text}
    Wait Until Element Is Visible    ${locator}     timeout=10s
    Clear Element Text      ${locator}
    Input Text              ${locator}              ${text}

Wait For Element And Clear
    [Arguments]             ${locator}
    Wait Until Element Is Enabled    ${locator}     timeout=5s
    Clear Element Text      ${locator}

Wait For Element And Click
    [Arguments]             ${locator}
    Wait Until Element Is Enabled    ${locator}     timeout=5s
    Click Element           ${locator}

Wait For Alert And Accept
    Wait Until Alert Is Present    timeout=5s
    Handle Alert            accept=True

Get Element Text
    [Arguments]             ${locator}
    ${text} =               Get Text                ${locator}
    RETURN                  ${text}

Should Value Be In Text
    [Arguments]             ${value}                ${text}
    Should Contain          ${text}                 ${value}

