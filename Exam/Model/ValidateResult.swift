//
//  ValidateResult.swift
//  Exam
//
//  Created by cmc on 06/07/2022.
//

import UIKit

struct ValidateResult: Codable {
    var result: Bool
    var message: String
    var data: ValidateResultData
}
struct ValidateResultData: Codable {
    var id: Int
    var token: String
}
