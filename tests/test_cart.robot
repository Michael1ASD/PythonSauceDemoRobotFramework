*** Settings ***
Library           SeleniumLibrary
Resource          ../resources/LoginPage.robot
Resource          ../resources/ExpandedList.robot
Resource          ../resources/AllItems.robot
Resource          ../resources/Cart.robot
Resource          ../resources/ProductDetails.robot
Test Setup        Open Browser And Navigate To Login Page
Test Teardown     Logout and close browser

*** Variables ***

*** Test Cases ***
#Verify Cart Counter Is Visible
#    [Tags]                                  smoke
#    Verify Cart Is Empty
#    Add Product To Cart By Name             Sauce Labs Backpack
#    Wait Until Element Is Visible           xpath=//span[@class='shopping_cart_badge']

Verify Total Cart Value
    Verify Cart Is Empty
    Add Product To Cart By Name             Sauce Labs Backpack
    ${price_bag}=                           Return Price By Product Name        Sauce Labs Backpack
    ${tax_bag}=                             Calculate Tax Value                 ${price_bag}
    Add Product To Cart By Name             Sauce Labs Bolt T-Shirt
    ${price_tshirt}=                        Return Price By Product Name        Sauce Labs Bolt T-Shirt
    ${tax_tshirt}=                          Calculate Tax Value                 ${price_tshirt}
    Add Product To Cart By Name             Sauce Labs Bike Light
    ${price_bike}=                          Return Price By Product Name        Sauce Labs Bike Light
    ${tax_bike}=                            Calculate Tax Value                 ${price_bike}
    ${total_net}=                           Evaluate                            round(float(${price_bag}) + float(${price_tshirt}) + float(${price_bike}), 2)
    ${total_tax}=                           Evaluate                            round(float(${tax_bag}) + float(${tax_tshirt}) + float(${tax_bike}), 2)
    ${total_value}=                         Evaluate                            round(${total_net} + ${total_tax}, 2)

    Open Cart
    Checkout From Cart View
    Enter Checkout Credentials And Continue

    ${actual_total_net}=    Return Cart Total Net Value
    ${actual_total_tax}=    Return Cart Total Tax Value
    ${actual_total}=        Return Cart Total Value

    Should Value Be In Text    ${actual_total_net}    ${total_net}
    Should Value Be In Text    ${actual_total_tax}    ${total_tax}
    Should Value Be In Text    ${actual_total}        ${total_value}
