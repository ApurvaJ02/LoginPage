//
//  RegistrationViewController.swift
//  RegistrationApp
//
//  Created by Apurva Jalgaonkar on 29/10/25.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailOrPhoneLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailOrPhoneTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var registerInfoLabel: UILabel!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var faceBookButton: UIButton!
    @IBOutlet weak var accountPromptLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    
    private let viewModel = RegistrationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetupUI()
    }
    
    private func initialSetupUI() {
        titleLabel.text = "RIMASHAAR JEWELERY"
        titleLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        
        infoLabel.text = "Please enter your information"
        
        signUpLabel.text = "Sign Up"
        signUpLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        firstNameLabel.text = "First Name"
        firstNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        lastNameLabel.text = "Last Name"
        lastNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        emailOrPhoneLabel.text = "Phone Number or Email Id"
        emailOrPhoneLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        registerInfoLabel.text = "or Register with"
        accountPromptLabel.text = "Have an account?"
        
        registerButton.setTitle("GET OTP", for: .normal)
        registerButton.backgroundColor = .gray
        registerButton.tintColor = .white
        
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.tintColor = .black
        
    }
    
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        validateForm()
    }
    
    private func validateForm() {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty,
              let lastName = lastNameTextField.text, !lastName.isEmpty,
              let contact = emailOrPhoneTextField.text, !contact.isEmpty else {
            showAlert(title: "Missing Info", message: "Please fill all fields.")
            return
        }
        
        if isValidEmail(contact) == false && isValidPhone(contact) == false {
            showAlert(title: "Invalid Input", message: "Please enter a valid email or phone number.")
            return
        }
        
        sendRegistrationData(firstName: firstName, lastName: lastName, contact: contact)
    }
    
    
    private func sendRegistrationData(firstName: String, lastName: String, contact: String) {
        let request = RegisterRequest(
            app_version: "1.0",
            device_model: UIDevice.current.model,
            device_token: "",
            device_type: "I",
            dob: "",
            email: isValidEmail(contact) ? contact : "",
            first_name: firstName,
            gender: "",
            last_name: lastName,
            newsletter_subscribed: 0,
            os_version: UIDevice.current.systemVersion,
            password: "",
            phone: isValidPhone(contact) ? contact : "",
            phone_code: "91"
        )
        
        registerButton.isEnabled = false
        
        viewModel.registerUser(request: request) { [weak self] success, message, code in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.registerButton.isEnabled = true
                self.registerButton.setTitle("GET OTP", for: .normal)

                if success, let otpCode = code {
                    let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                        let storyboard = UIStoryboard(name: "VerifyOTP", bundle: nil)
                        if let otpVC = storyboard.instantiateViewController(withIdentifier: "VerifyOTPViewController") as? VerifyOTPViewController {
                            otpVC.OTP = otpCode
                            self.navigationController?.pushViewController(otpVC, animated: true)
                        }
                    }))
                    self.present(alert, animated: true)
                } else {
                    self.showAlert(title: "Error", message: message)
                }
            }
        }
    }
    
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    private func isValidPhone(_ phone: String) -> Bool {
        let phoneRegex = "^[0-9]{10}$"
        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phone)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}
