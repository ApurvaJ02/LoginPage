//
//  VerifyOTPRequest.swift
//  RegistrationApp
//
//  Created by Apurva Jalgaonkar on 30/10/25.
//

import Foundation

struct VerifyOTPRequest: Codable {
    let otp: String?
    let user_id: String?
}
