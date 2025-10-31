//
//  VerifyOTPViewController.swift
//  RegistrationApp
//
//  Created by Apurva Jalgaonkar on 30/10/25.
//

import UIKit

class VerifyOTPViewController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var enterOTPLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var resendLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var otpTextField1: UITextField!
    @IBOutlet weak var otpTextField2: UITextField!
    @IBOutlet weak var otpTextField3: UITextField!
    @IBOutlet weak var otpTextField4: UITextField!
    @IBOutlet weak var otpTextField5: UITextField!
    
    private let viewModel = OTPViewModel()
    var OTP: String = ""
    var userId: String = ""
    
    private var timer: Timer?
    private var remainingSeconds = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetupUI()
        setupOTPFields()
        startTimer()
        setupResendTapGesture()
    }
    
    private func initialSetupUI() {
        titleLabel.text = "RIMASHAAR JEWELERY"
        titleLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        
        enterOTPLabel.text = "Enter OTP"
        enterOTPLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        
        infoLabel.text = "Please enter the 5-digit code that is send to your email address or phone number"
        infoLabel.numberOfLines = 2
        
        resendLabel.text = "Resend a new code in"
        timerLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    private func setupOTPFields() {
        let fields = [otpTextField1, otpTextField2, otpTextField3, otpTextField4, otpTextField5]
        
        for field in fields {
            field?.delegate = self
            field?.keyboardType = .numberPad
            field?.textAlignment = .center
            field?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            field?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
        
        otpTextField1.becomeFirstResponder()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        
        if text.count == 1 {
            switch textField {
            case otpTextField1: otpTextField2.becomeFirstResponder()
            case otpTextField2: otpTextField3.becomeFirstResponder()
            case otpTextField3: otpTextField4.becomeFirstResponder()
            case otpTextField4: otpTextField5.becomeFirstResponder()
            case otpTextField5:
                otpTextField5.resignFirstResponder()
                verifyOTPIfComplete()
            default: break
            }
        } else if text.count == 0 {
            let fields = [otpTextField1, otpTextField2, otpTextField3, otpTextField4, otpTextField5]
            if fields.allSatisfy({ $0?.text?.isEmpty ?? true }) {
                startTimer()
            }
            
            switch textField {
            case otpTextField2: otpTextField1.becomeFirstResponder()
            case otpTextField3: otpTextField2.becomeFirstResponder()
            case otpTextField4: otpTextField3.becomeFirstResponder()
            case otpTextField5: otpTextField4.becomeFirstResponder()
            default: break
            }
        }
    }
    
    
    private func verifyOTPIfComplete() {
        let otp = "\(otpTextField1.text ?? "")\(otpTextField2.text ?? "")\(otpTextField3.text ?? "")\(otpTextField4.text ?? "")\(otpTextField5.text ?? "")"
        
        guard otp.count == 5 else { return }
        verifyOTP(otp: otp)
    }
    
    private func verifyOTP(otp: String) {
        if otp == OTP {
            let request = VerifyOTPRequest(otp: otp, user_id: userId)
            
            viewModel.verifyOTP(request: request) { [weak self] success, message in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    if success {
                        self.timer?.invalidate()
                        self.timer = nil
                        let storyboard = UIStoryboard(name: "Home", bundle: nil)
                        if let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
                            self.navigationController?.pushViewController(homeVC, animated: true)
                        }
                    } else {
                        self.showAlert(title: "Error", message: "Something went wrong")
                        print("OTP verification failed")
                    }
                }
            }
        } else {
            showAlert(title: "Invalid OTP", message: "The OTP you entered does not match. Please try again.")
        }
    }
    
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func startTimer() {
        timer?.invalidate()
        remainingSeconds = 30
        timerLabel.text = "\(remainingSeconds) sec"
        timerLabel.textColor = .black
        resendLabel.textColor = .gray
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        remainingSeconds -= 1
        timerLabel.text = "\(remainingSeconds) sec"
        
        if remainingSeconds <= 0 {
            timer?.invalidate()
            timer = nil
            timerLabel.text = "Tap to resend"
            timerLabel.textColor = .systemBlue
            resendLabel.textColor = .systemBlue
        }
    }
    
    
    // MARK: - Resend OTP Logic
    private func setupResendTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(resendOTPTapped))
        resendLabel.isUserInteractionEnabled = true
        timerLabel.isUserInteractionEnabled = true
        resendLabel.addGestureRecognizer(tapGesture)
        timerLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc private func resendOTPTapped() {
        guard timer == nil else { return }
        print("Resending OTP...")
        startTimer()
    }
    
}
