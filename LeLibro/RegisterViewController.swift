//
//  RegisterViewController.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 12.09.25.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var confPassLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var createAccButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confPassTextField: UITextField!
    @IBOutlet weak var createLabel: UILabel!
    
    let manager = CoreDataManager()
    
    var users = [UserEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        users = manager.fetchUsers()
        createLabel.font = UIFont(name: "Rosarivo", size: 48)
        emailLabel.font = UIFont(name: "Rosarivo", size: 16)
        passwordLabel.font = UIFont(name: "Rosarivo", size: 16)
        confPassLabel.font = UIFont(name: "Rosarivo", size: 16)
        emailTextField.font = UIFont(name: "Rosarivo", size: 16)
        passwordTextField.font = UIFont(name: "Rosarivo", size: 16)
        confPassTextField.font = UIFont(name: "Rosarivo", size: 16)
        createAccButton.applyRosarivoFont(title: "Create an account", size: 16)
        emailTextField.layer.cornerRadius = 10
        passwordTextField.layer.cornerRadius = 10
        confPassTextField.layer.cornerRadius = 10
        emailTextField.clipsToBounds = true
        passwordTextField.clipsToBounds = true
        confPassTextField.clipsToBounds = true
    }
    
    @IBAction func createAccButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let confPass = confPassTextField.text else { return }
        
        if email.isEmpty || password.isEmpty || confPass.isEmpty {
            alertFor(title: "Empty Fields!", message: "Please, fill all areas!")
        }
        else if !email.contains("@") || !email.contains(".") {
            alertFor(title: "Invalid Email!", message: "Your email address is not correct!")
        }
        else if password != confPass {
            alertFor(title: "Password Error!", message: "Passwords do not match!")
        }
        else if let _ = manager.registerUser(email: email, password: password) {
            alertFor(title: "Welcome!", message: "Your account has been created!")
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let delegate = windowScene.delegate as? SceneDelegate {
                    delegate.rootMenu()
                }
            }
        }
        else {
            alertFor(title: "Already Exists!", message: "User with this email already exists!")
        }
    }
}
