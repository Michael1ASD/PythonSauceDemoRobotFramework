*** Settings ***
Library           SeleniumLibrary
Library           String
Resource          ../resources/Common.robot

*** Variables ***
${URL}           https://www.saucedemo.com/inventory.html

*** Keywords ***
Open All Items Page
    Go To    ${URL}

Verify Cart Is Empty
    Wait Until Element Is Not Visible    xpath=//span[@class='shopping_cart_badge']    timeout=1s

Open Cart
    Click Element    xpath=//a[@class='shopping_cart_link']

Add Product To Cart By Name
    [Arguments]    ${product_name}
#    ${product_xpath}=    Set Variable    //div[@class='inventory_item_name ' and text()='${product_name}']
#    Wait Until Element Is Visible    ${product_xpath}    timeout=10s
#    ${product_element}=    Get Webelement    ${product_xpath}
#    ${ancestor}=    Execute Javascript    return arguments[0].closest('.inventory_item');    ${product_element}
#    ${add_button_xpath}=    Set Variable    .//button[contains(text(), 'Add to cart')]
#    Wait Until Element Is Visible    xpath=//div[@class='inventory_item' and .//div[@class='inventory_item_name ' and text()='${product_name}']]//button[contains(text(), 'Add to cart')]    timeout=10s
#    Click Element    xpath=//div[@class='inventory_item' and .//div[@class='inventory_item_name ' and text()='${product_name}']]//button[contains(text(), 'Add to cart')]

    ${product_name_xpath}=    Set Variable    xpath=//div[@class='inventory_item_name ' and text()='${product_name}']
    Wait Until Element Is Visible    ${product_name_xpath}    timeout=10s
    ${add_to_cart_button_xpath}=    Set Variable    xpath=//ancestor::div[@class='inventory_item']//button[contains(text(), 'Add to cart')]
    Click Element    ${add_to_cart_button_xpath}

Enter Product Details By Name
    [Arguments]    ${product_name}
    ${product_xpath}=    Set Variable    //div[@class='inventory_item_name ' and text()='${product_name}']
    Wait Until Element Is Visible    ${product_xpath}    timeout=10s
    Click Element    ${product_xpath}

Return Price By Product Name
    [Arguments]    ${product_name}
    ${product_xpath}=    Set Variable    //div[@class='inventory_item_name ' and text()='${product_name}']
    Wait Until Element Is Visible    ${product_xpath}    timeout=10s
    ${price_xpath}=    Set Variable    //div[@class='inventory_item_name ' and text()='${product_name}']//ancestor::div[@class='inventory_item']//div[@class='inventory_item_price']
    ${price_text}=    Get Text    xpath=${price_xpath}
    ${value_without_dollar}=    Remove String    ${price_text}   $
    RETURN    ${value_without_dollar}