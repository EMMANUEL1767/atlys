//
//  SignUpViewController.swift
//  atlys
//
//  Created by Emmanuel Biju on 25/11/24.
//

import UIKit

class SignupViewController: UIViewController {
    
    // MARK: - UI Components
    private let carousalView = CarouselViewController().view!
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your phone number"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .phonePad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let googleLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue with Google", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let appleLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue with Apple", for: .normal)
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let emailPasswordLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login with Email & Password", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    // MARK: - Setup
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(logoImageView)
        view.addSubview(carousalView)
        view.addSubview(phoneNumberTextField)
        view.addSubview(continueButton)
        view.addSubview(googleLoginButton)
        view.addSubview(appleLoginButton)
        view.addSubview(emailPasswordLoginButton)
        
        carousalView.translatesAutoresizingMaskIntoConstraints = false
        // Add button actions
        continueButton.addTarget(self, action: #selector(continueWithPhoneNumber), for: .touchUpInside)
        googleLoginButton.addTarget(self, action: #selector(continueWithGoogle), for: .touchUpInside)
        appleLoginButton.addTarget(self, action: #selector(continueWithApple), for: .touchUpInside)
        emailPasswordLoginButton.addTarget(self, action: #selector(continueWithEmailPassword), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            carousalView.topAnchor.constraint(equalTo: logoImageView.topAnchor, constant: 40),
            carousalView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            carousalView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            carousalView.heightAnchor.constraint(equalToConstant: 210)
        ])
        
        // Phone Number TextField Constraints
        NSLayoutConstraint.activate([
            phoneNumberTextField.topAnchor.constraint(equalTo: carousalView.bottomAnchor, constant: 40),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Continue Button Constraints
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 20),
            continueButton.leadingAnchor.constraint(equalTo: phoneNumberTextField.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: phoneNumberTextField.trailingAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Google Login Button Constraints
        NSLayoutConstraint.activate([
            googleLoginButton.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 30),
            googleLoginButton.leadingAnchor.constraint(equalTo: phoneNumberTextField.leadingAnchor),
            googleLoginButton.trailingAnchor.constraint(equalTo: phoneNumberTextField.trailingAnchor),
            googleLoginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Apple Login Button Constraints
        NSLayoutConstraint.activate([
            appleLoginButton.topAnchor.constraint(equalTo: googleLoginButton.bottomAnchor, constant: 15),
            appleLoginButton.leadingAnchor.constraint(equalTo: phoneNumberTextField.leadingAnchor),
            appleLoginButton.trailingAnchor.constraint(equalTo: phoneNumberTextField.trailingAnchor),
            appleLoginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Email Password Login Button Constraints
        NSLayoutConstraint.activate([
            emailPasswordLoginButton.topAnchor.constraint(equalTo: appleLoginButton.bottomAnchor, constant: 30),
            emailPasswordLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc private func continueWithPhoneNumber() {
        print("Continue with Phone Number")
    }
    
    @objc private func continueWithGoogle() {
        print("Continue with Google")
    }
    
    @objc private func continueWithApple() {
        print("Continue with Apple")
    }
    
    @objc private func continueWithEmailPassword() {
        print("Continue with Email & Password")
    }
}
