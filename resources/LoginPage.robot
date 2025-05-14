*** Settings ***
Library                     SeleniumLibrary
Library                     String
Resource                    ../resources/Common.robot
Resource                    ../resources/ExpandedList.robot

*** Variables ***
${browser}                  chrome
${login_url}                https://www.saucedemo.com/
${username_input}           xpath=//input[@id='user-name']
${password_input}           xpath=//input[@id='password']
${login_button}             xpath=//input[@id='login-button']
${valid_username}           standard_user
${valid_password}           secret_sauce

*** Keywords ***
Open Login Page
    [Arguments]             ${url}=${login_url}
    Go To                   ${login_url}

Enter Login
    [Arguments]             ${username}
    Input Text With Wait    ${username_input}       ${username}

Enter Password
    [Arguments]             ${password}
    Input Text With Wait    ${password_input}       ${password}

Click Login Button
    Click Element           ${login_button}

Login
    [Arguments]             ${username}=standard_user             ${password}=secret_sauce
    Enter Login             ${username}
    Enter Password          ${password}
    Click Login Button

Open browser and login
    Open Browser According To Variable
    Open Login Page
    Login

Logout and close browser
    Logout
    Close Browser