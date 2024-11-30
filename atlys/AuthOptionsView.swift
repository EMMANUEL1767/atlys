//
//  AuthOptionsView.swift
//  atlys
//
//  Created by Emmanuel Biju on 30/11/24.
//

import UIKit

class AuthOptionsView: UIView {
    
    // MARK: - Properties
    private let termsLabel: UILabel = {
        let label = UILabel()
        label.text = "By continuing you agree to our"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .label
        return label
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Terms", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    private let andLabel: UILabel = {
        let label = UILabel()
        label.text = " & "
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .label
        return label
    }()
    
    private let privacyPolicyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.text = "or"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        let leftSeparator = createDynamicSeparator()
        let rightSeparator = createDynamicSeparator()
        
        let separatorStackView = UIStackView(arrangedSubviews: [leftSeparator, orLabel, rightSeparator])
        separatorStackView.axis = .horizontal
        separatorStackView.alignment = .center
        separatorStackView.spacing = 8
        addSubview(separatorStackView)
        
        leftSeparator.translatesAutoresizingMaskIntoConstraints = false
        rightSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leftSeparator.heightAnchor.constraint(equalToConstant: 1),
            rightSeparator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        separatorStackView.spacing = 8
        addSubview(separatorStackView)
        
        addSubview(buttonStackView)
        addSubview(termsLabel)
        
        let termsStackView = UIStackView(arrangedSubviews: [termsButton, andLabel, privacyPolicyButton])
        termsStackView.axis = .horizontal
        termsStackView.alignment = .center
        termsStackView.spacing = 4
        addSubview(termsStackView)
        
        // Layout
        separatorStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        termsLabel.translatesAutoresizingMaskIntoConstraints = false
        termsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            separatorStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            separatorStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            separatorStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            leftSeparator.widthAnchor.constraint(equalTo: rightSeparator.widthAnchor),
            
            buttonStackView.topAnchor.constraint(equalTo: separatorStackView.bottomAnchor, constant: 20),
            buttonStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            termsLabel.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 20),
            termsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            termsStackView.topAnchor.constraint(equalTo: termsLabel.bottomAnchor, constant: 4),
            termsStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        // Add buttons
        addLoginMethodButton(icon: "google", height: 48) {
            print("Google sign-in initiated")
        }
        addLoginMethodButton(icon: "mac-os", height: 48) {
            print("Apple sign-in initiated")
        }
        addLoginMethodButton(icon: "email", height: 48) {
            print("Email sign-in initiated")
        }
    }
    
    private func createDynamicSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.opacity = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func addLoginMethodButton(icon: String, height: CGFloat, action: @escaping () -> Void) {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: icon), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        let padding: CGFloat = 8 // Adjust padding as needed
        button.contentEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        button.backgroundColor = .white
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 2
        button.addAction(UIAction { _ in action() }, for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addArrangedSubview(button)
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: height),
            button.widthAnchor.constraint(equalTo: button.heightAnchor)
        ])
    }
}
