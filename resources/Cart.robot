*** Settings ***
Library           SeleniumLibrary
Library           String
Resource          ../resources/Common.robot

*** Variables ***
${cart_continue_shopping_button}    xpath=//button[@id='continue-shopping']
${cart_checkout_button}             xpath=//button[@id='checkout']
${first_name_input}                 xpath=//input[@id='first-name']
${last_name_input}                  xpath=//input[@id='last-name']
${zip_code_input}                   xpath=//input[@id='postal-code']
${continue_button}                  xpath=//input[@id='continue']
${finish_button}                    xpath=//button[@id='finish']
${cancel_button}                    xpath=//button[@id='cancel']
${total_net_value}                  xpath=//div[@class='summary_subtotal_label']
${tax_value}                        xpath=//div[@class='summary_tax_label']
${total_gross_value}                xpath=//div[@class='summary_total_label']

*** Keywords ***
Continue Shopping From Cart View
    Click Element                   ${cart_continue_shopping_button}

Checkout From Cart View
    Click Element                   ${cart_checkout_button}

Enter First Name
    [Arguments]                     ${first_name}=Jan
    Input Text                      ${first_name_input}         ${first_name}

Enter Last Name
    [Arguments]                     ${last_name}=Kowalski
    Input Text                      ${last_name_input}          ${last_name}

Enter Zip Postal Code
    [Arguments]                     ${zip_code}=000-01
    Input Text                      ${zip_code_input}    ${zip_code}

Click Continue From Checkout
    Click Element                   ${continue_button}

Enter Checkout Credentials And Continue
    Enter First Name
    Enter Last Name
    Enter Zip Postal Code
    Click Continue From Checkout

Cancel Checkout
    Click Element                   ${cancel_button}

Finish Checkout
    Click Element                   ${finish_button}

Return Cart Total Net Value
    ${value}=    Get Text           ${total_net_value}
    ${value_without_dollar}=    Remove String    ${value}    $
    RETURN       ${value_without_dollar}

Return Cart Total Tax Value
    ${value}=    Get Text           ${tax_value}
    ${value_without_dollar}=    Remove String    ${value}    $
    RETURN       ${value_without_dollar}

Return Cart Total Value
    ${value}=    Get Text           ${total_gross_value}
    ${value_without_dollar}=    Remove String    ${value}    $
    RETURN       ${value_without_dollar}

Calculate Tax Value
    [Arguments]                     ${price}
    ${tax}=      Evaluate           round(float(${price}) * 0.08, 2)
    RETURN       ${tax}