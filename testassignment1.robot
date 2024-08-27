*** Settings ***
Library    RequestsLibrary
Library    Collections

Suite Setup    Setup
Suite Teardown    Teardown

*** Variables ***
${BASE_URL}    https://reqres.in/api

# Endpoints
${GET_SINGLE_USER_ENDPOINT}    /users/2
${POST_CREATE_USER_ENDPOINT}    /users

# Request Bodies
${POST_CREATE_USER_BODY}    {"name": "morpheus", "job": "leader"}

# Expected Values
${EXPECTED_STATUS_CODE_GET_USER}    200
${EXPECTED_STATUS_CODE_CREATE_USER}    201
${USER_ID}    2
${EXPECTED_USER_NAME}    morpheus
${EXPECTED_USER_JOB}    leader

*** Test Cases ***
Get a Single User
    [Tags]    get
    Given I send a GET request to    ${GET_SINGLE_USER_ENDPOINT}
    Then the response status code should be    ${EXPECTED_STATUS_CODE_GET_USER}
    And the response body should contain the user details with id    ${USER_ID}

Create a New User
    [Tags]    post
    Given I send a POST request to    ${POST_CREATE_USER_ENDPOINT}    with body    ${POST_CREATE_USER_BODY}
    Then the response status code should be    ${EXPECTED_STATUS_CODE_CREATE_USER}
    And the response body should contain the created user details
    And the user name should be    ${EXPECTED_USER_NAME}
    And the user job should be    ${EXPECTED_USER_JOB}

*** Keywords ***
Setup
    Create Session    reqres    ${BASE_URL}

Teardown
    Delete All Sessions

Given I send a GET request to
    [Arguments]    ${endpoint}
    ${response}=    GET    ${BASE_URL}${endpoint}
    Set Suite Variable    ${response}

Given I send a POST request to    
    [Arguments]    ${endpoint}    ${body}
    ${response}=    POST    ${BASE_URL}${endpoint}    ${body}
    Set Suite Variable    ${response}

Then the response status code should be
    [Arguments]    ${expected_status}
    ${status_code}=    Get From Dictionary    ${response}    status_code
    Should Be Equal As Numbers    ${status_code}    ${expected_status}

Then the response body should contain the user details with id
    [Arguments]    ${user_id}
    ${response_body}=    Get From Dictionary    ${response}    json()
    ${user_id_from_response}=    Get From Dictionary    ${response_body}    data.id
    Should Be Equal As Numbers    ${user_id_from_response}    ${user_id}

Then the response body should contain the created user details
    ${response_body}=    Get From Dictionary    ${response}    json()
    Dictionary Should Contain Value    ${response_body}    name
    Dictionary Should Contain Value    ${response_body}    job

Then the user name should be
    [Arguments]    ${expected_name}
    ${response_body}=    Get From Dictionary    ${response}    json()
    ${name}=    Get From Dictionary    ${response_body}    name
    Should Be Equal    ${name}    ${expected_name}

Then the user job should be
    [Arguments]    ${expected_job}
    ${response_body}=    Get From Dictionary    ${response}    json()
    ${job}=    Get From Dictionary    ${response_body}    job
    Should Be Equal    ${job}    ${expected_job}
