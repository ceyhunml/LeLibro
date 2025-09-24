//
//  LoginViewController.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 12.09.25.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    let manager = CoreDataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        welcomeLabel.font = UIFont(name: "Rosarivo", size: 48)
        emailLabel.font = UIFont(name: "Rosarivo", size: 16)
        passwordLabel.font = UIFont(name: "Rosarivo", size: 16)
        emailTextField.font = UIFont(name: "Rosarivo", size: 16)
        passwordTextField.font = UIFont(name: "Rosarivo", size: 16)
        signInButton.applyRosarivoFont(title: "Sign in", size: 16)
        emailTextField.layer.cornerRadius = 10
        passwordTextField.layer.cornerRadius = 10
        emailTextField.clipsToBounds = true
        passwordTextField.clipsToBounds = true
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        
        if email.isEmpty || password.isEmpty {
            alertFor(title: "Empty Fields!", message: "Please, fill all areas!")
        }
        else if !email.contains("@") || !email.contains(".") {
            alertFor(title: "Invalid Email!", message: "Please enter a valid email address!")
        }
        else if let user = manager.loginUser(email: email, password: password) {
            UserStatusManager.shared.login(user: user)
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let delegate = windowScene.delegate as? SceneDelegate {
                    delegate.rootMenu(animated: true)
                }
            }
        }
        else {
            alertFor(title: "Login Failed!", message: "Wrong email or password.")
        }
    }
}
