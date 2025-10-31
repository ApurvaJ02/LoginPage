# LoginPage

A simple iOS app built in Swift for user registration and OTP verification.

Features

User Registration

OTP Verification

Form Validation (email/phone format checks)

Backend API integration with success/error handling

Modules
1. Register Module

User registration interface as per design.

Validates all input fields (email, phone, etc.).

Sends registration data to the backend API.

Handles server responses for success and errors.

On success, receives a code required for OTP verification.

2. Verify OTP Module

Navigates to OTP verification screen after registration.

Users enter the OTP as per design.

Sends OTP to backend for verification.

Handles server responses based on the success value.

Navigates user accordingly (e.g., to a welcome screen on success).

Getting Started

Clone the repo:

git clone https://github.com/ApurvaJ02/LoginPage.git
cd LoginPage
open RegistrationApp.xcodeproj


Run the project in Xcode (⌘R).

Tech Stack

Swift

UIKit

Xcode

