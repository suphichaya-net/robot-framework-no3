*** Settings ***
Resource   ../resources/resources_get_user.robot

Suite Setup     Create ReqRes Session

*** Test Cases ***
#เคส 200: มี user
Get user profile success (id=1)
    ${resp}=    Get User Profile
    Log To Console    \n--- GET USER SUCCESS (id=1) ---
    Log To Console    Status Code: ${resp.status_code}
    Log To Console    Response:\n${resp.text}
    Should Be Equal As Integers    ${resp.status_code}    200
    Verify User Body (Success)    ${resp}

#เคส 404: ไม่มี user
Get user profile not found (id=1234)
    ${resp}=    Get User Not Found
    Log To Console    \n--- GET USER NOT FOUND (id=1234) ---
    Log To Console    Status Code: ${resp.status_code}
    Log To Console    Response:\n${resp.text}
    Should Be Equal As Integers    ${resp.status_code}    404
    Should Be Equal                ${resp.text}    ${EXP_EMPTY_BODY}