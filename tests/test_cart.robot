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
Verify Cart Counter Is Visible
    [Tags]    smoke
    Verify Cart Is Empty
    Add Product To Cart By Name    Sauce Labs Backpack
    Element Should Be Visible    xpath=//span[@class='shopping_cart_badge']

Verify Total Cart Value
    Verify Cart Is Empty
    Add Product To Cart By Name    Sauce Labs Backpack
    ${price_bag}=    Return Price By Product Name    Sauce Labs Backpack
    ${price_bag_clean}=    Remove String    ${price_bag}    $
    ${tax_bag}=    Calculate Tax Value    ${price_bag_clean}
    # dodaj kolejne produkty
    Add Product To Cart By Name    Sauce Labs Bolt T-Shirt
    ${price_tshirt}=    Return Price By Product Name    Sauce Labs Bolt T-Shirt
    ${price_tshirt_clean}=    Remove String    ${price_tshirt}    $
    ${tax_tshirt}=    Calculate Tax Value    ${price_tshirt_clean}
    Add Product To Cart By Name    Sauce Labs Bike Light
    ${price_bike}=    Return Price By Product Name    Sauce Labs Bike Light
    ${price_bike_clean}=    Remove String    ${price_bike}    $
    ${tax_bike}=    Calculate Tax Value    ${price_bike_clean}
    # Obliczanie oczekiwanych wartości
    ${total_net}=    Evaluate    round(float(${price_bag}) + float(${price_tshirt}) + float(${price_bike}), 2)
    ${total_tax}=    Evaluate    round(float(${tax_bag}) + float(${tax_tshirt}) + float(${tax_bike}), 2)
    ${total_value}=  Evaluate    round(${total_net} + ${total_tax}, 2)

    # Przechodzimy do koszyka
    Open Cart
    Checkout From Cart View
    Enter Checkout Credentials And Continue

    # Porównanie wartości
    ${actual_total_net}=    Return Cart Total Net Value
    ${actual_total_net_clean}=    Remove String    ${actual_total_net}    $
    ${actual_total_tax}=    Return Cart Total Tax Value
    ${actual_total_tax_clean}=    Remove String    ${actual_total_tax}    $
    ${actual_total=}    Return Cart Total Value
    ${actual_total_clean}=    Remove String    ${actual_total}    $

    Should Contain    ${actual_total_net_clean}    ${total_net}
    Should Contain    ${actual_total_tax_clean}    ${total_tax}
    Should Contain    ${actual_total_clean}    ${total_value}
