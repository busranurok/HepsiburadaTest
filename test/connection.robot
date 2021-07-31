*** Settings ***
Library  AppiumLibrary

*** Variables ***
${APPIUM_SERVER}  http://127.0.0.1:4723/wd/hub
${ANDROID_PLAT_NAME}  Android
${PACKAGE_NAME}  com.pozitron.hepsiburada
${ACTIVITY_NAME}  com.hepsiburada.ui.startup.SplashActivity
${DEVICE_NAME}    emulator-5554
${ANDROID_PLAT_VER}    11.0

*** Keywords ***
Open the application
    Open Application  ${APPIUM_SERVER}  platformName=${ANDROID_PLAT_NAME}  platformVersion = ${ANDROID_PLAT_VER}  deviceName=${DEVICE_NAME}  appPackage=${PACKAGE_NAME}  appActivity=${ACTIVITY_NAME}  noReset=True  adbExecTimeout=3000

Open the application With Reset
    Open Application  ${APPIUM_SERVER}  platformName=${ANDROID_PLAT_NAME}  platformVersion = ${ANDROID_PLAT_VER}  deviceName=${DEVICE_NAME}  appPackage=${PACKAGE_NAME}  appActivity=${ACTIVITY_NAME}  adbExecTimeout=3000
Close the application
    capture page screenshot
    Close Application

Screenshot
    capture page screenshot
