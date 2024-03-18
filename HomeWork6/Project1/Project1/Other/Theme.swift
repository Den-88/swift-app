//
//  Theme.swift
//  Project1
//
//  Created by Денис Шакуров on 15.03.2024.
//

import UIKit

protocol AppTheme {
    var backgroundColor: UIColor { get }
    var textColor: UIColor { get }
    var textBackground: UIColor { get }
    var textOnlineColor: UIColor { get }
    var textOfflineColor: UIColor { get }
}

final class Theme {
    
    static var currentTheme: AppTheme = LightTheme()
}

final class LightTheme: AppTheme {
    var backgroundColor: UIColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
    var textColor: UIColor = .darkText
    var textBackground: UIColor = .yellow
    var textOnlineColor: UIColor = UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0)
    var textOfflineColor: UIColor = .red

}

final class BlueTheme: AppTheme {
    var backgroundColor: UIColor = .blue
    var textColor: UIColor = .orange
    var textBackground: UIColor = .darkGray
    var textOnlineColor: UIColor = .green
    var textOfflineColor: UIColor = .yellow
}

final class BlackTheme: AppTheme {
    var backgroundColor: UIColor = .darkGray
    var textColor: UIColor = .lightText
    var textBackground: UIColor = .blue
    var textOnlineColor: UIColor = .white
    var textOfflineColor: UIColor = .orange

}
