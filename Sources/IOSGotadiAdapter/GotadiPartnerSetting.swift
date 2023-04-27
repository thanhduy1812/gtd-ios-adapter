//
//  File.swift
//  
//
//  Created by Duy Nguyen on 27/04/2023.
//

import Foundation

public struct GotadiPartnerSetting: Codable {
    let env: String
    let partnername: String
    let language: String
    let token: String
    
    public init(env: String, partnername: String, language: String, token: String) {
        self.env = env
        self.partnername = partnername
        self.language = language
        self.token = token
    }
}
