*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Resource   ../variables/variables_get_user.robot

# *** Keywords ***
# Create ReqRes Session
#     Create Session    reqres    ${BASE_URL}    verify=${FALSE}

*** Keywords ***
Create ReqRes Session
    ${headers}=    Create Dictionary    x-api-key=${API_KEY}
    Create Session    reqres    ${BASE_URL}    headers=${headers}    verify=${FALSE}

Get User Profile
    ${resp}=    Get On Session    reqres    ${USER_PATH}
    RETURN    ${resp}

Get User Not Found
    ${resp}=    Get On Session    reqres    /users/${USER_ID_NOT_FOUND}    expected_status=any
    RETURN    ${resp}

Verify User Body (Success)
    [Arguments]    ${resp}
    ${json}=    Convert String To JSON    ${resp.text}
    ${email}=    Get Value From Json    ${json}    $.data.email
    ${first}=    Get Value From Json    ${json}    $.data.first_name
    ${last}=     Get Value From Json    ${json}    $.data.last_name
    ${avatar}=   Get Value From Json    ${json}    $.data.avatar
    Should Be Equal                ${email[0]}    ${EXP_EMAIL}
    Should Be Equal                ${first[0]}    ${EXP_FIRST_NAME}
    Should Be Equal                ${last[0]}     ${EXP_LAST_NAME}
    Should Be Equal                ${avatar[0]}   ${EXP_AVATAR}
