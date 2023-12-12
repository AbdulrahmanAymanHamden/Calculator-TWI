*** Settings ***
Library    AppiumLibrary

*** Test Cases ***

Test Login Functionality

    Open Calculator App
    # invalid Credentials
    Input Text      ${Username_TextBox}        admin
    Input Text      ${Password_TextBox}        1111
    Click Element   ${Login_Button}
    Wait Until Page Contains Element    ${Alert_PopUp}
    Element Should Contain Text    ${LoginFailed_Message}   Login failed
    Click Element    ${OK_Button}
    # Empty Credentials
    Clear Text      ${Username_TextBox}
    Clear Text      ${Password_TextBox}
    Click Element   ${Login_Button}
    Wait Until Page Contains Element    ${Alert_PopUp}
    Element Should Contain Text    ${LoginFailed_Message}   Login failed
    Click Element    ${OK_Button}
    # Valid Credentials
    Input Text      ${Username_TextBox}        admin
    Input Text      ${Password_TextBox}        1234
    Click Element   ${Login_Button}
    Wait Until Page Contains Element    ${Calculator_Page}


Test Calculator Functionality
    Open Calculator App

    Input Text      ${Username_TextBox}        admin
    Input Text      ${Password_TextBox}        1234
    Click Element   ${Login_Button}
    Wait Until Page Contains Element    ${Calculator_Page}

    # Addition Operation Functionality
    Calculate Operation     3   ${Add_Operator}   3    6
    # Clear Button Functionality
    Click Element    ${Clear_Button}
    Element Should Contain Text    ${Clear_Button}   ${EMPTY}

    # Multiplication  Operation Functionality
    Calculate Operation     3   ${Mult_Operator}  3    9
    Click Element    ${Clear_Button}
    Element Should Contain Text    ${Clear_Button}   ${EMPTY}

Test History Functionality
    Open Calculator App

    Input Text      ${Username_TextBox}        admin
    Input Text      ${Password_TextBox}        1234
    Click Element   ${Login_Button}
    Wait Until Page Contains Element    ${Calculator_Page}

    # Addition Operation Functionality
    Calculate Operation     3   ${Add_Operator}   3    6
    #History Functionality
    Click Element    ${Histor_Button}
    Wait Until Page Contains Element    ${Add_Operation_History}
    Element Should Contain Text    ${Add_Operation_History}   3+3=6
    #Clear History
    Click Element    ${Delete_History_Button}
    Page Should Not Contain Element    ${Add_Operation_History}



*** Variables ***
${Username_TextBox}         //android.widget.EditText[@resource-id='username']
${Password_TextBox}         //android.widget.EditText[@resource-id='password']
${Login_Button}             //android.widget.Button[@resource-id='login']
${Alert_PopUp}              id=android:id/alertTitle
${LoginFailed_Message}      id=android:id/message
${OK_Button}                id=android:id/button1
${Calculator_Page}          //android.view.ViewGroup[@resource-id='calcContainerView']
${Add_Operator}             //android.view.ViewGroup[@resource-id='plusButton']
${Mult_Operator}            //android.view.ViewGroup[@resource-id='timesButton']
${Equal_Operator}           //android.view.ViewGroup[@resource-id='equalButton']
${Result}                   //android.widget.TextView[@resource-id='result']
${Clear_Button}             //android.view.ViewGroup[@resource-id='clearButton']
${Histor_Button}            //android.widget.Button[@resource-id='history']
${Add_Operation_History}    //android.widget.TextView[@resource-id='eq2']
${Delete_History_Button}    //android.widget.Button[@resource-id='delete']

*** Keywords ***
Calculate Operation
    [Arguments]    ${first_operand}    ${operator}    ${second_operand}    ${expected_result}

    ${first_number_locator}    Set Variable    //android.view.ViewGroup[@resource-id='no. ${first_operand}']
    ${second_number_locator}    Set Variable    //android.view.ViewGroup[@resource-id='no. ${second_operand}']

    Click Element    ${first_number_locator}
    Click Element    ${operator}
    Click Element    ${second_number_locator}
    Click Element    ${Equal_Operator}

    Element Should Contain Text    ${Result}    ${expected_result}



Open Calculator App
    Open Application    http://localhost:4723/wd/hub    platformName=Android    deviceName=emulator-5554    appPackage=com.calculator   appActivity=com.calculator.MainActivity     automationName=Uiautomator2
    #Invalid Credentials
    Wait Until Page Contains Element    ${Username_TextBox}