//
//  File.swift
//  
//
//  Created by Duy Nguyen on 27/04/2023.
//

import Foundation
public enum GTDThemeMode: String, Codable {
    case primary = "primary"
    case secondary = "secondary"
}
public struct GotadiPartnerSetting: Codable {
    let env: String
    let partnername: String
    let language: String
    let token: String
    var theme: GTDThemeMode
    
    public init(env: String, partnername: String, language: String, token: String, theme: GTDThemeMode) {
        self.env = env
        self.partnername = partnername
        self.language = language
        self.token = token
        self.theme = theme
    }
    
    public mutating func changeTheme(theme: GTDThemeMode) {
        self.theme = theme
    }
}
