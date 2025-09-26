//
//  ProfileViewController.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 22.09.25.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var addressTextField: UITextField!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var signOutButton: UIButton!
    
    private var saveButton: UIBarButtonItem?
    
    private var hasChanges = false
    
    let manager = CoreDataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupFields()
        setupSaveButton()
        hideKeyboardWhenTappedAround()
    }
    
    private func setup() {
        emailTextField.layer.cornerRadius = 10
        passwordTextField.layer.cornerRadius = 10
        addressTextField.layer.cornerRadius = 10
        phoneTextField.layer.cornerRadius = 10
        emailTextField.clipsToBounds = true
        passwordTextField.clipsToBounds = true
        addressTextField.clipsToBounds = true
        phoneTextField.clipsToBounds = true
        signOutButton.applyGillSansFont(title: "Sign Out", size: 20)
    }
    
    private func setupFields() {
        
        if let user = UserStatusManager.shared.currentUser {
            emailTextField.text = user.email
            passwordTextField.text = user.password
            phoneTextField.text = user.mobileNumber
            addressTextField.text = user.address
        }
        
        passwordTextField.addTarget(self, action: #selector(fieldChanged), for: .editingChanged)
        phoneTextField.addTarget(self, action: #selector(fieldChanged), for: .editingChanged)
        addressTextField.addTarget(self, action: #selector(fieldChanged), for: .editingChanged)
    }
    
    private func setupSaveButton() {
        saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTapped))
        saveButton?.isEnabled = false
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func fieldChanged() {
        hasChanges = true
        saveButton?.isEnabled = true
    }
    
    @objc private func saveTapped() {
        guard let user = UserStatusManager.shared.currentUser else { return }
        
        if let password = passwordTextField.text {
            if password.isEmpty {
                alertFor(title: "Password is missing", message: "You need to enter a password")
            } else {
                user.password = passwordTextField.text
                user.mobileNumber = phoneTextField.text
                user.address = addressTextField.text
                
                manager.saveContext()
                
                hasChanges = false
                saveButton?.isEnabled = false
                
                alertFor(title: "Success!", message: "Your profile has been updated!")
            }
        }
    }
    
    @IBAction private func signOutButtonPressed(_ sender: Any) {
        UserStatusManager.shared.logout()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let delegate = windowScene.delegate as? SceneDelegate {
                delegate.rootWelcome(animated: true)
            }
        }
    }
}
