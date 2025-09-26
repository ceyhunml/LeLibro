//
//  GenreCollectionCell.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 15.09.25.
//

import UIKit

class GenreCollectionCell: UICollectionViewCell {
    
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        genreLabel.font = UIFont(name: "Rosarivo", size: 16)
        backView.layer.cornerRadius = 10
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    override var isSelected: Bool {
        didSet {
            updateAppearance(selected: isSelected)
        }
    }
    
    private func updateAppearance(selected: Bool) {
        if selected {
            backView.backgroundColor = .main
            genreLabel.textColor = .backgroundLayer
        } else {
            backView.backgroundColor = .backgroundLayer
            genreLabel.textColor = .main
        }
    }
    
    func configure(genreName: String) {
        self.genreLabel.text = genreName
    }
}
