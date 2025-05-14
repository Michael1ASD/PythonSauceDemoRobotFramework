*** Settings ***
Library                     SeleniumLibrary
Library                     BuiltIn

*** Variables ***
${url}                      https://www.saucedemo.com/

*** Keywords ***
Open Browser According To Variable
    [Arguments]    ${browser}=chrome
    IF    '${browser}'=='chrome'
        ${selenium}=    Evaluate       sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
#        Call Method     ${selenium}    add_argument    --headless
        Call Method     ${selenium}    add_argument    --disable-popup-blocking
        Call Method     ${selenium}    add_argument    --disable-infobars
        Call Method     ${selenium}    add_argument    --disable-dev-shm-usage
        Call Method     ${selenium}    add_argument    --start-maximized
        Call Method     ${selenium}    add_argument    --mute-audio
        Open Browser    ${url}         chrome      options=${selenium}

    ELSE IF    '${browser}'=='firefox'
        ${firefox_options}=    Evaluate       sys.modules['selenium.webdriver'].FirefoxOptions()    sys, selenium.webdriver
#        Call Method     ${firefox_options}    add_argument    --headless
        Call Method     ${firefox_options}    add_argument    --start-maximized
        Open Browser    ${url}                firefox         options=${firefox_options}

    ELSE IF    '${browser}'=='edge'
        ${edge_options}=    Evaluate       sys.modules['selenium.webdriver'].EdgeOptions()    sys, selenium.webdriver
#        Call Method     ${edge_options}    add_argument    --headless
        Call Method     ${edge_options}    add_argument    --disable-popup-blocking
        Call Method     ${edge_options}    add_argument    --start-maximized
        Open Browser    ${url}             edge            options=${edge_options}

    ELSE
        Fail    Unsupported browser: ${browser}
    END

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
    ${value_str}=   Convert To String    ${value}
    Should Contain          ${text}                 ${value_str}

