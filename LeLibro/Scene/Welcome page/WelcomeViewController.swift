//
//  ViewController.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 12.09.25.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var getStartedLabel: UILabel!
    @IBOutlet weak var joinUsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        getStartedLabel.font = UIFont(name: "Rosarivo", size: 48)
        joinUsLabel.font = UIFont(name: "Rosarivo", size: 26)
        createAccountButton.applyRosarivoFont(title: "Create an account", size: 16)
        signInButton.applyRosarivoFont(title: "Sign in to your account", size: 16)
    }
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController")
        navigationController?.show(controller!, sender: nil)
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        navigationController?.show(controller!, sender: nil)
    }
}


