//
//  RegisterRequest.swift
//  RegistrationApp
//
//  Created by Apurva Jalgaonkar on 30/10/25.
//

import Foundation

struct RegisterRequest: Codable {
    let app_version: String?
    let device_model: String?
    let device_token: String?
    let device_type: String?
    let dob: String?
    let email: String?
    let first_name: String?
    let gender: String?
    let last_name: String?
    let newsletter_subscribed: Int?
    let os_version: String?
    let password: String?
    let phone: String?
    let phone_code: String?
}
