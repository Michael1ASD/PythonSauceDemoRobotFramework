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
${browser}        chrome

*** Test Cases ***
Verify Cart Counter Is Visible
    [Tags]                                  smoke
    Verify Cart Is Empty
    Add Product To Cart By Name             Sauce Labs Backpack
    Wait Until Element Is Visible           xpath=//span[@class='shopping_cart_badge']

Verify Total Cart Value
    Verify Cart Is Empty

    Add Product To Cart By Name             Sauce Labs Backpack
    ${price_bag}=                           Return Price By Product Name        Sauce Labs Backpack
    ${tax_bag}=                             Calculate Tax Value                 ${price_bag}
    Add Product To Cart By Name             Sauce Labs Bolt T-Shirt
    ${price_tshirt}=                        Return Price By Product Name        Sauce Labs Bolt T-Shirt
    ${tax_tshirt}=                          Calculate Tax Value                 ${price_tshirt}
    Add Product To Cart By Name             Sauce Labs Bike Light
    ${price_bike_light}=                    Return Price By Product Name        Sauce Labs Bike Light
    ${tax_bike_light}=                      Calculate Tax Value                 ${price_bike_light}

    ${total_net}=                           Evaluate                            str(round(float(${price_bag}) + float(${price_tshirt}) + float(${price_bike_light}), 2))
    ${total_tax}=                           Evaluate                            str(round(float(${tax_bag}) + float(${tax_tshirt}) + float(${tax_bike_light}), 2))
    ${total_value}=                         Evaluate                            str(round(${total_net} + ${total_tax}, 2))

    Open Cart
    Checkout From Cart View
    Enter Checkout Credentials And Continue

    ${actual_total_net}=    Return Cart Total Net Value
    ${actual_total_tax}=    Return Cart Total Tax Value
    ${actual_total}=        Return Cart Total Value

    Should Value Be In Text    ${total_net}           ${actual_total_net}
    Should Value Be In Text    ${total_tax}           ${actual_total_tax}
    Should Value Be In Text    ${total_value}         ${actual_total}
