//
//  Project1UITests.swift
//  Project1UITests
//
//  Created by Денис Шакуров on 25.03.2024.
//

import XCTest

final class Project1UITests: XCTestCase {
    var app: XCUIApplication!
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    func testThemeChange() {
        XCUIApplication().webViews.webViews.webViews/*@START_MENU_TOKEN@*/.buttons["Продолжить как Денис +7 ··· ··· ·· 18"]/*[[".otherElements[\"VK ID\"].buttons[\"Продолжить как Денис +7 ··· ··· ·· 18\"]",".buttons[\"Продолжить как Денис +7 ··· ··· ·· 18\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let app = XCUIApplication()
        let tabBar = app.tabBars["Tab Bar"]
        let button = tabBar.buttons["Группы"]
        button.tap()
        
        let personImage = app.navigationBars["Друзья"].images["person"]
        personImage.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Синяя тема"]/*[[".buttons[\"Синяя тема\"].staticTexts[\"Синяя тема\"]",".staticTexts[\"Синяя тема\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let backButton = app.navigationBars["Профиль"].buttons["Back"]
        backButton.tap()
        tabBar.buttons["Фото"].tap()
        button.tap()
        personImage.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Тёмная тема"]/*[[".buttons[\"Тёмная тема\"].staticTexts[\"Тёмная тема\"]",".staticTexts[\"Тёмная тема\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        backButton.tap()
        tabBar.buttons["Друзья"].tap()
        
    }

    func testTabCkick() {
        let app = XCUIApplication()
        app.webViews.webViews.webViews/*@START_MENU_TOKEN@*/.buttons["Продолжить как Денис +7 ··· ··· ·· 18"]/*[[".otherElements[\"VK ID\"].buttons[\"Продолжить как Денис +7 ··· ··· ·· 18\"]",".buttons[\"Продолжить как Денис +7 ··· ··· ·· 18\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Фото"].tap()
        tabBar.buttons["Друзья"].tap()
        let button = tabBar.buttons["Группы"]
        button.tap()
    }
}
