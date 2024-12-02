//
//  SignUpViewController.swift
//  atlys
//
//  Created by Emmanuel Biju on 25/11/24.
//

import UIKit

class SignupViewController: UIViewController {
    
    // MARK: - UI Components
    private let carousalView = CarouselView()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let sloganLabel: UILabel = {
        let label = UILabel()
        label.text = "visas on time"
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.textColor = .systemIndigo
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Get Visas\nOn Time"
        label.font = .systemFont(ofSize: 32, weight: .heavy)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    let phoneFieldView = PhoneNumberFieldView(selectedCountry: Country(flag: "🇺🇸", code: "+1"))
    
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.backgroundColor = .systemIndigo
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let authOptionsView = AuthOptionsView()
    
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
        view.addSubview(sloganLabel)
        view.addSubview(carousalView)
        view.addSubview(titleLabel)
        view.addSubview(phoneFieldView)
        view.addSubview(continueButton)
        view.addSubview(authOptionsView)
        
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        sloganLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let images = [
            UIImage(named: "malaysia")!,
            UIImage(named: "dubai")!,
            UIImage(named: "india")!,
            UIImage(named: "malaysia")!,
            UIImage(named: "dubai")!,
            UIImage(named: "india")!,
            UIImage(named: "malaysia")!,
            UIImage(named: "dubai")!,
            UIImage(named: "india")!,
        ]
        
        carousalView.configure(with: images)
        carousalView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authOptionsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(authOptionsView)
        
        phoneFieldView.delegate = self
        phoneFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        continueButton.addTarget(self, action: #selector(continueWithPhoneNumber), for: .touchUpInside)

    }
    
    private func setupConstraints() {
        
        // Logo constraints
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 48),
            sloganLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            sloganLabel.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor)
        ])
        
        // Slogan label constraints
        NSLayoutConstraint.activate([
            carousalView.topAnchor.constraint(equalToSystemSpacingBelow: sloganLabel.bottomAnchor, multiplier: 1),
            carousalView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: carousalView.trailingAnchor, constant: 20),
            carousalView.heightAnchor.constraint(equalToConstant: 260)
        ])
        
        // Title label constraints
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: carousalView.bottomAnchor, constant: 40)
        ])
        
        // Phone number field constraints
        NSLayoutConstraint.activate([
            phoneFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            phoneFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            phoneFieldView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            phoneFieldView.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        // Continue Button Constraints
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: phoneFieldView.bottomAnchor, constant: 16),
            continueButton.leadingAnchor.constraint(equalTo: phoneFieldView.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: phoneFieldView.trailingAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Auth options Constraints
        NSLayoutConstraint.activate([
            authOptionsView.topAnchor.constraint(equalTo: continueButton.bottomAnchor),
            authOptionsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            authOptionsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            authOptionsView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc private func continueWithPhoneNumber() {
        print("Continue with Phone Number")
    }
}

extension SignupViewController: PhoneNumberFieldDelegate {
    // MARK: - PhoneNumberFieldDelegate
    func didSelectCountry(_ country: Country) {
        print("Selected Country: \(country.flag) \(country.code)")
    }
    
    func didUpdatePhoneNumber(_ phoneNumber: String) {
        print("Phone Number: \(phoneNumber)")
    }
}
