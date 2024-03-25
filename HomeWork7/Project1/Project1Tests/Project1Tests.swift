//
//  Project1Tests.swift
//  Project1Tests
//
//  Created by Денис Шакуров on 25.03.2024.
//

import XCTest
@testable import Project1

final class Project1Tests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExampl() {
        let result = 1 + 1
        XCTAssertEqual(result, 2, "1 + 1 должно равняться 2")
    }
    func testThemeChange() {
            // Arrange
            let profileViewController = ProfileViewController(token: "dummyToken")
            let lightTheme = LightTheme()
            let blueTheme = BlueTheme()
            let blackTheme = BlackTheme()
            Theme.currentTheme = lightTheme
            profileViewController.applyTheme()
            XCTAssertEqual(profileViewController.view.backgroundColor, lightTheme.backgroundColor, "Фон должен соответствовать светлой теме")
            XCTAssertEqual(profileViewController.profileView.textLabel.textColor, lightTheme.textColor, "Цвет текста должен соответствовать светлой теме")
            XCTAssertEqual(profileViewController.profileView.label.backgroundColor, lightTheme.textBackground, "Фон метки должен соответствовать светлой теме")
            Theme.currentTheme = blueTheme
            profileViewController.applyTheme()
            XCTAssertEqual(profileViewController.view.backgroundColor, blueTheme.backgroundColor, "Фон должен соответствовать синей теме")
            XCTAssertEqual(profileViewController.profileView.textLabel.textColor, blueTheme.textColor, "Цвет текста должен соответствовать синей теме")
            XCTAssertEqual(profileViewController.profileView.label.backgroundColor, blueTheme.textBackground, "Фон метки должен соответствовать синей теме")
            Theme.currentTheme = blackTheme
            profileViewController.applyTheme()
            XCTAssertEqual(profileViewController.view.backgroundColor, blackTheme.backgroundColor, "Фон должен соответствовать черной теме")
            XCTAssertEqual(profileViewController.profileView.textLabel.textColor, blackTheme.textColor, "Цвет текста должен соответствовать черной теме")
            XCTAssertEqual(profileViewController.profileView.label.backgroundColor, blackTheme.textBackground, "Фон метки должен соответствовать черной теме")
        }
    func testNumberOfRowsInSection() {
        let tableView = FriendsTableView()
        let friends: [Friends] = [
            Friends(name: "Иван", surname: "Иванов", online: 1, photo: "photo_url_1", photoBig: "big_photo_url_1"),
            Friends(name: "Мария", surname: "Петрова", online: 0, photo: "photo_url_2", photoBig: "big_photo_url_2"),
            Friends(name: "Александр", surname: "Смирнов", online: 1, photo: "photo_url_3", photoBig: "big_photo_url_3"),
            Friends(name: "Елена", surname: "Козлова", online: 0, photo: "photo_url_4", photoBig: "big_photo_url_4"),
            Friends(name: "Дмитрий", surname: "Морозов", online: 1, photo: "photo_url_5", photoBig: "big_photo_url_5")
        ]
        tableView.models = friends
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 5, "Количество строк в таблице должно быть равно 5")
    }
}
