//
//  ViewController.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 12.09.25.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet private weak var createAccountButton: UIButton!
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var getStartedLabel: UILabel!
    @IBOutlet private weak var joinUsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        getStartedLabel.font = UIFont(name: "Rosarivo", size: 48)
        joinUsLabel.font = UIFont(name: "Rosarivo", size: 26)
        createAccountButton.applyRosarivoFont(title: "Create an account", size: 16)
        signInButton.applyRosarivoFont(title: "Sign in to your account", size: 16)
    }
    
    @IBAction private func createAccountButtonPressed(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController")
        navigationController?.show(controller!, sender: nil)
    }
    
    @IBAction private func signInButtonPressed(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        navigationController?.show(controller!, sender: nil)
    }
}
