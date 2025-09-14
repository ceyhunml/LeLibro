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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
}
