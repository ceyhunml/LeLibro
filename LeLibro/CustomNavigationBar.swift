//
//  test.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 14.09.25.
//

import Foundation
import UIKit

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

    containerView.heightAnchor.constraint(equalToConstant: size + 12).isActive = true
    
    return containerView
}
