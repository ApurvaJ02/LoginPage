//
//  RegistrationViewModel.swift
//  RegistrationApp
//
//  Created by Apurva Jalgaonkar on 30/10/25.
//

import Foundation
import UIKit

class RegistrationViewModel {
    
    func registerUser(
        request: RegisterRequest,
        completion: @escaping (Bool, String, String?) -> Void) {
            let url = "https://admin-cp.rimashaar.com/api/v1/register-new?lang=en"
            
            NetworkManager.shared.postRequest(
                urlString: url,
                requestBody: request,
                completion: { (result: Result<RegisterResponse, Error>) in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let response):
                            print("Register API Response:", response)
                            if response.success {
                                completion(true, response.message ?? "", response.data?.code)
                            } else {
                                completion(false, response.message ?? "", nil)
                            }
                        case .failure(let error):
                            completion(false, error.localizedDescription, nil)
                        }
                    }
                }
            )
        }
}



