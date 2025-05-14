*** Settings ***
Library                 SeleniumLibrary
Resource                ../resources/LoginPage.robot
Resource                ../resources/ExpandedList.robot
Test Setup              Open Browser And Login
Test Teardown           Logout and close browser

*** Variables ***
${login_url}            https://www.saucedemo.com/
${valid_username}       standard_user
${valid_password}       secret_sauce


*** Test Cases ***
Valid Login Title
    [Tags]              smoke, login
    [Setup]             None
    [Teardown]          None
    Open Browser
    Open Login Page
    Title Should Be     Swag Labs
    Close Browser

Valid Login
    [Tags]              smoke, login
    [Setup]             None
    Open Browser
    Open Login Page
    Login               ${valid_username}    ${valid_password}
    Element Should Be Visible    xpath=//div[@class='app_logo']

Invalid Login with Username
    [Tags]              login
    [Setup]             None
    [Teardown]          None
    Open Browser
    Open Login Page
    Login               invalid_username    ${valid_password}
    Element Should Contain              css=h3[data-test='error     Epic sadface: Username and password do not match any user in this service
    Close Browser

Invalid Login with Password
    [Tags]              login
    [Setup]             None
    [Teardown]          None
    Open Browser
    Open Login Page
    Login               ${valid_username}    invalid_password
    Element Should Contain              css=h3[data-test='error     Epic sadface: Username and password do not match any user in this service
    Close Browser

Test Logout
    [Tags]              login
    [Teardown]          None
    Logout
    Wait For Element And Find It        xpath=//div[@class='login_logo']
    Close Browser