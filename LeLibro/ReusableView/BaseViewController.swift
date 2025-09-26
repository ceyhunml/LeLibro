//
//  BaseViewController.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 26.09.25.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarAppearance()
        setupDefaultLogo()
    }
    
    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.backgroundLayer
        appearance.shadowColor = UIColor.clear
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupDefaultLogo() {
        navigationItem.titleView = makeNavigationLogoView(imageName: "mainLogo", size: 140)
    }
    
    func makeNavigationLogoView(imageName: String, size: CGFloat) -> UIView {
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let containerView = UIView()
        containerView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: size),
            imageView.heightAnchor.constraint(equalToConstant: size)
        ])
        
        return containerView
    }
}
