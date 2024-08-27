*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    OperatingSystem
Suite Setup    Setup Browser
Suite Teardown    Teardown Browser

*** Variables ***
${URL}    https://www.saucedemo.com
${BROWSER}    chrome
${USERNAME}    standard_user
${PASSWORD}    secret_sauce
${ITEM_NAME}    Sauce Labs Backpack
${FIRST_NAME}    John
${LAST_NAME}    Doe
${POSTAL_CODE}    12345

*** Test Cases ***
Successful checkout
    [Tags]    checkout
    Given I am on the Sauce Demo login page
    When I login with valid credentials
    And I add an item to the cart
    And I go to the shopping cart
    And I proceed to checkout
    And I fill in the checkout information
    And I complete the checkout
    Then I should see the order confirmation page

*** Keywords ***
Setup Browser
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Teardown Browser
    Close Browser

Given I am on the Sauce Demo login page
    Title Should Be    Swag Labs

When I login with valid credentials
    Input Text    id=user-name    ${USERNAME}
    Input Text    id=password    ${PASSWORD}
    Click Button    id=login-button

And I add an item to the cart
    Click Element    id=item_4_title_link
    

And I go to the shopping cart
    Click Element    id=shopping_cart_container

And I proceed to checkout
    Click Element    id=checkout

And I fill in the checkout information
    Input Text    id=first-name    ${FIRST_NAME}
    Input Text    id=last-name    ${LAST_NAME}
    Input Text    id=postal-code    ${POSTAL_CODE}
    Click Button    id=continue

And I complete the checkout
    Click Button    id=finish

Then I should see the order confirmation page
    Title Should Be    Swag Labs
