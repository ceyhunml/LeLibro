//
//  UIButton.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 14.09.25.
//

import Foundation
import UIKit

extension UIButton {
    func applyRosarivoFont(title: String, size: CGFloat) {
        
        guard let font = UIFont(name: "Rosarivo", size: size) else { return }
        let attrTitle = NSAttributedString(string: title, attributes: [.font: font])
        
        [UIControl.State.normal, .highlighted, .selected].forEach {
            self.setAttributedTitle(attrTitle, for: $0)
        }
    }
    
    func applyGillSansFont(title: String, size: CGFloat) {
        
        guard let font = UIFont(name: "Gill Sans", size: size) else { return }
        let attrTitle = NSAttributedString(string: title, attributes: [.font: font])
        
        [UIControl.State.normal, .highlighted, .selected].forEach {
            self.setAttributedTitle(attrTitle, for: $0)
        }
    }
}
