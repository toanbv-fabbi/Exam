//
//  UserDefault.swift
//  Exam
//
//  Created by cmc on 05/07/2022.
//

import Foundation

struct UserDefault {
    
    static func saveToken(token: String) {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: Constants.token)
    }
    
    static func getToken() -> String? {
        let defaults = UserDefaults.standard
        return defaults.value(forKey: Constants.token) as? String
    }
}
