*** Settings ***
Library           SeleniumLibrary
Resource          ../resources/LoginPage.robot
Resource          ../resources/ExpandedList.robot
Resource          ../resources/AllItems.robot
Resource          ../resources/Cart.robot
Resource          ../resources/ProductDetails.robot
Test Setup        Open Browser And Login
Test Teardown     Logout and close browser

*** Variables ***

*** Test Cases ***
Add Product to Cart from Product Details
    Verify Cart Is Empty
    Enter Product Details By Name           Sauce Labs Fleece Jacket
    Add Product To Cart
    Open Cart
    Checkout From Cart View
    Enter Checkout Credentials And Continue
    Finish Checkout
    Element Should Be Visible               xpath=//h2[text()='Thank you for your order!']
