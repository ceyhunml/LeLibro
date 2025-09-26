//
//  CustomSearchBar.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 19.09.25.
//

import Foundation
import UIKit

class CustomSeachBar: UIView {
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.textColor = .main
        tf.font = UIFont(name: "Rosarivo", size: 16)
        tf.borderStyle = .none
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    let iconView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        iv.tintColor = .main
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = UIColor.searchBar
        clipsToBounds = true
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "Search for a book or author",
            attributes: [
                .foregroundColor: UIColor.main,
                .font: UIFont(name: "Rosarivo", size: 16) ?? .systemFont(ofSize: 20)
            ]
        )
        
        layer.cornerRadius = 30
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.masksToBounds = false
        
        addSubview(iconView)
        addSubview(textField)
        
        iconView.backgroundColor = UIColor.searchBar
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 0),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 20),
            iconView.heightAnchor.constraint(equalToConstant: 20),
            
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
