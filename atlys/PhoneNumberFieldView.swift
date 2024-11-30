//
//  PhoneNumberFieldView.swift
//  atlys
//
//  Created by Emmanuel Biju on 30/11/24.
//

import UIKit

protocol PhoneNumberFieldDelegate: AnyObject {
    func didSelectCountry(_ country: Country)
    func didUpdatePhoneNumber(_ phoneNumber: String)
}

class PhoneNumberFieldView: UIView {
    
    // MARK: - Properties
    weak var delegate: PhoneNumberFieldDelegate?
    private var selectedCountry: Country {
        didSet {
            updateCountryButton()
            delegate?.didSelectCountry(selectedCountry)
        }
    }
    
    private let countryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter mobile number"
        textField.font = .systemFont(ofSize: 16, weight: .bold)
        textField.keyboardType = .phonePad
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.down"))
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        return view
    }()
    
    // MARK: - Initializer
    init(selectedCountry: Country) {
        self.selectedCountry = selectedCountry
        super.init(frame: .zero)
        setupViews()
        updateCountryButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        addSubview(borderView)
        borderView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [countryButton, chevronImageView, phoneTextField])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        borderView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints
        NSLayoutConstraint.activate([
            borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            borderView.topAnchor.constraint(equalTo: topAnchor),
            borderView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -12),
            stackView.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -8),
            
            countryButton.widthAnchor.constraint(equalToConstant: 50),
            chevronImageView.widthAnchor.constraint(equalToConstant: 12),
        ])
        
        // Actions
        countryButton.addTarget(self, action: #selector(countryButtonTapped), for: .touchUpInside)
        phoneTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func updateCountryButton() {
        let title = "\(selectedCountry.flag) \(selectedCountry.code)"
        countryButton.setTitle(title, for: .normal)
    }
    
    // MARK: - Actions
    @objc private func countryButtonTapped() {
        // Notify delegate to show country picker
        delegate?.didSelectCountry(selectedCountry)
    }
    
    @objc private func textFieldDidChange() {
        guard let text = phoneTextField.text else { return }
        delegate?.didUpdatePhoneNumber(text)
    }
}
