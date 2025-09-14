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
        getStartedLabel.font = UIFont(name: "Rosarivo", size: 48)
        joinUsLabel.font = UIFont(name: "Rosarivo", size: 26)
        createAccountButton.titleLabel?.font = UIFont(name: "Rosarivo", size: 16)
        signInButton.titleLabel?.font = UIFont(name: "Rosarivo", size: 16)
    }
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
    }
    
}


