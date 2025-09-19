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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "MenuViewController")
        navigationController?.show(controller!, sender: nil)
    }
    

}
