*** Settings ***
Library           SeleniumLibrary
Resource          ../resources/Common.robot

Library           SeleniumLibrary
Resource          ../resources/Common.robot

*** Variables ***
${burger_open_button}    xpath=//button[@id='react-burger-menu-btn']
${burger_close_button}   xpath=//button[@id='react-burger-cross-btn']
&{options}
...    all_items=//a[@id='inventory_sidebar_link']
...    logout=//a[@id='logout_sidebar_link']
...    reset_app_state=//a[@id='reset_sidebar_link']

*** Keywords ***
Expand Burger Menu
    Wait Until Element Is Visible       ${burger_open_button}
    Click Element                       ${burger_open_button}

Collapse Burger Menu
    Wait Until Element Is Visible       ${burger_close_button}
    Click Element                       ${burger_close_button}

Select Option From Burger
    [Arguments]    ${option_key}
    ${option_xpath}=    Set Variable    ${options}[${option_key}]
    Wait Until Element Is Visible    ${option_xpath}    timeout=5s
    Click Element    ${option_xpath}

Display All Items
    Expand Burger Menu
    Select Option From Burger    all_items

Reset App State
    Expand Burger Menu
    Select Option From Burger    reset_app_state

Logout
    Reset App State
    Select Option From Burger    logout



