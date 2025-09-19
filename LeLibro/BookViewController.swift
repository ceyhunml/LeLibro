//
//  BookViewController.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 19.09.25.
//

import UIKit

class BookViewController: UIViewController {
    
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var genreName: UILabel!
    @IBOutlet weak var aboutBook: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    var book: BookEntity?

    override func viewDidLoad() {
        super.viewDidLoad()
        bookCover.image = UIImage(named: book?.coverImage ?? "")
        bookName.text = book?.title ?? ""
        authorName.text = book?.author ?? ""
        genreName.text = book?.genre ?? ""
        aboutBook.text = book?.summary ?? ""
        bookCover.layer.cornerRadius = 16
        starLabel.text = "\(String(book?.rating ?? 0))✬"
    }

    
    @IBAction func buyButtonPressed(_ sender: Any) {
    }
}
