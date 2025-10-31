//
//  VerifyOTPResponse.swift
//  RegistrationApp
//
//  Created by Apurva Jalgaonkar on 30/10/25.
//

import Foundation

struct VerifyOTPResponse: Codable {
    let success: Bool
    let status: Int?
    let message: String?
    let data: VerifyData?
}

struct VerifyData: Codable {
    let token: String?
    let user_name: String?
}
