//
//  OTPViewModel.swift
//  RegistrationApp
//
//  Created by Apurva Jalgaonkar on 30/10/25.
//

import Foundation

class OTPViewModel {
    func verifyOTP(
        request: VerifyOTPRequest,
        completion: @escaping (Bool, String?) -> Void
    ) {
        let url = "https://admin-cp.rimashaar.com/api/v1/verify-code?lang=en"
        
        NetworkManager.shared.postRequest(
            urlString: url,
            requestBody: request
        ) { (result: Result<VerifyOTPResponse, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if response.success {
                        completion(true, response.message)
                    } else {
                        completion(false, response.message)
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription)
                }
            }
        }
    }
}






