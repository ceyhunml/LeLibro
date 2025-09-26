//
//  LoginViewController.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 12.09.25.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var welcomeLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signInButton: UIButton!
    
    let manager = CoreDataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        welcomeLabel.font = UIFont(name: "Rosarivo", size: 48)
        let labels: [UILabel] = [emailLabel, passwordLabel]
        labels.forEach { $0.font = UIFont(name: "Rosarivo", size: 16) }
        let textFields: [UITextField] = [emailTextField, passwordTextField]
        textFields.forEach {
            $0.font = UIFont(name: "Rosarivo", size: 16)
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }
        signInButton.applyRosarivoFont(title: "Sign in", size: 16)
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction private func signInButtonPressed(_ sender: Any) {
        
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        guard !email.isEmpty, !password.isEmpty else {
            alertFor(title: "Empty Fields!", message: "Please, fill all areas!")
            return
        }
        
        guard email.contains("@"), email.contains(".") else {
            alertFor(title: "Invalid Email!", message: "Please enter a valid email address!")
            return
        }
        
        guard let user = manager.loginUser(email: email, password: password) else {
            alertFor(title: "Login Failed!", message: "Wrong email or password.")
            return
        }
        
        UserStatusManager.shared.login(user: user)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let delegate = windowScene.delegate as? SceneDelegate {
            delegate.rootMenu(animated: true)
        }
    }
}
