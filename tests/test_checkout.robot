*** Settings ***
Library                 SeleniumLibrary
Resource                ../resources/LoginPage.robot
Resource                ../resources/AllItems.robot
Resource                ../resources/Cart.robot
Test Setup              Open Browser And Login
Test Teardown           Logout and close browser

*** Variables ***


*** Test Cases ***
Verify Successful Order
    [Tags]    smoke
    Verify Cart Is Empty
    Add Product To Cart By Name    Sauce Labs Bike Light
    Open Cart
    Checkout From Cart View
    Enter Checkout Credentials And Continue
    Finish Checkout
    Element Should Be Visible    xpath=//h2[text()='Thank you for your order!']

Verify Cancel Order
    [Tags]    smoke
    Verify Cart Is Empty
    Add Product To Cart By Name    Sauce Labs Onesie
    Open Cart
    Checkout From Cart View
    Enter Checkout Credentials And Continue
    Cancel Checkout
    Element Should Be Visible    xpath=//span[@class='title']
