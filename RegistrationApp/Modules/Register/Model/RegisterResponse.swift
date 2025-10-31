//
//  RegisterResponse.swift
//  RegistrationApp
//
//  Created by Apurva Jalgaonkar on 30/10/25.
//

import Foundation

struct RegisterResponse: Codable {
    let success: Bool
    let status: Int?
    let message: String?
    let data: RegisterData?
}

struct RegisterData: Codable {
    let user_id: Int?
    let code: String? 
}
