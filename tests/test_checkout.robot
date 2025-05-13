*** Settings ***
Library           SeleniumLibrary
Resource          ../resources/LoginPage.robot
Resource          ../resources/AllItems.robot
Resource          ../resources/Cart.robot

*** Variables ***
${login_url}        https://your.base.url/login
${valid_username}    standard_user
${valid_password}    secret_sauce

*** Test Cases ***
Verify Successful Order
    [Tags]    smoke
    Open Browser    ${login_url}    Chrome
    Login    ${valid_username}    ${valid_password}
    Verify Cart Is Empty
    Add Product To Cart By Name    Sauce Labs Bike Light
    Open Cart
    Checkout From Cart View
    Enter Checkout Credentials And Continue
    Finish Checkout
    Element Should Be Visible    xpath=//h2[text()='Thank you for your order!']
    Close Browser

Verify Cancel Order
    [Tags]    smoke
    Open Browser    ${login_url}    Chrome
    Login    ${valid_username}    ${valid_password}
    Verify Cart Is Empty
    Add Product To Cart By Name    Sauce Labs Onesie
    Open Cart
    Checkout From Cart View
    Enter Checkout Credentials And Continue
    Cancel Checkout
    Element Should Be Visible    xpath=//span[@class='title']
    Close Browser