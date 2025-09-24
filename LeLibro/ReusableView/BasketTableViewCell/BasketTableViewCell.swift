//
//  BasketTableViewCell.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 24.09.25.
//

import UIKit

class BasketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookCount: UILabel!
    @IBOutlet weak var countChanger: UIStepper!
    
    
    var quantityChanged: ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bookCover.layer.cornerRadius = 8
        countChanger.minimumValue = 1
        countChanger.maximumValue = 99
        countChanger.value = 1
        bookCount.text = "x1"
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        let value = Int(sender.value)
        bookCount.text = "x\(value)"
        quantityChanged?(value)
    }
    
    func configure(book: BookEntity, quantity: Int) {
        bookTitle.text = "\(book.title ?? "")\n\(book.price)$"
        bookCover.image = UIImage(named: book.coverImage ?? "")
        countChanger.value = Double(quantity)
        bookCount.text = "x\(quantity)"
    }
    
}
