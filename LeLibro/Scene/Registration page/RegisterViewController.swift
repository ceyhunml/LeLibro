//
//  RegisterViewController.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 12.09.25.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet private weak var confPassLabel: UILabel!
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var createAccButton: UIButton!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confPassTextField: UITextField!
    @IBOutlet private weak var createLabel: UILabel!
    
    let viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        createLabel.font = UIFont(name: "Rosarivo", size: 48)
        emailLabel.font = UIFont(name: "Rosarivo", size: 16)
        passwordLabel.font = UIFont(name: "Rosarivo", size: 16)
        confPassLabel.font = UIFont(name: "Rosarivo", size: 16)
        [("e.g. example@mail.com", emailTextField),
         ("e.g. Examp!e2006", passwordTextField),
         ("Examp!e2006", confPassTextField)]
            .forEach { placeholder, field in
                field?.font = UIFont(name: "Rosarivo", size: 16)
                field?.layer.cornerRadius = 10
                field?.clipsToBounds = true
                field?.attributedPlaceholder = NSAttributedString(
                    string: placeholder,
                    attributes: [
                        .font: UIFont(name: "Rosarivo", size: 16) ?? UIFont.systemFont(ofSize: 16),
                        .foregroundColor: UIColor.darkGray
                    ]
                )
            }
        createAccButton.applyRosarivoFont(title: "Create an account", size: 16)
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction private func createAccButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased(),
              let password = passwordTextField.text,
              let confPass = confPassTextField.text else { return }
        
        if email.isEmpty || password.isEmpty || confPass.isEmpty {
            alertFor(title: "Empty Fields!", message: "Please fill in all fields.")
        }
        else if !isValidEmail(email) {
            alertFor(title: "Invalid Email!", message: "Please enter a valid email address.")
        }
        else if password.count < 6 {
            alertFor(title: "Weak Password!", message: "Password must be at least 6 characters.")
        }
        else if password != confPass {
            alertFor(title: "Password Mismatch!", message: "Passwords do not match.")
        }
        else if let user = viewModel.manager.registerUser(email: email, password: password) {
            UserStatusManager.shared.login(user: user)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let delegate = windowScene.delegate as? SceneDelegate {
                delegate.rootMenu(animated: true)
            }
        }
        else {
            alertFor(title: "User Exists!", message: "An account with this email already exists.")
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
}
