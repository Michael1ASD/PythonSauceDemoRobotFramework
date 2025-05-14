*** Settings ***
Library           SeleniumLibrary
Resource          ../resources/Common.robot

*** Variables ***
${add_to_cart_button}       xpath=//button[@id='add-to-cart']
${remove_from_cart_button}  xpath=//button[@id='remove']

*** Keywords ***
Add Product To Cart
    Wait Until Element Is Visible    ${add_to_cart_button}    timeout=10s
    Click Element                    ${add_to_cart_button}

Remove Product From Cart
    Wait Until Element Is Visible    ${remove_from_cart_button}    timeout=10s
    Click Element                    ${remove_from_cart_button}