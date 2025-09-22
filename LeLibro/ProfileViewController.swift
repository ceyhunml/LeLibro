//
//  ProfileViewController.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 22.09.25.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var signOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func signOutButtonPressed(_ sender: Any) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let delegate = windowScene.delegate as? SceneDelegate {
                delegate.rootMenu()
            }
        }
    }
}
