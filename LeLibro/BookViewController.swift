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
        bookName.font = UIFont(name: "Rosarivo", size: 24)
        authorName.font = UIFont(name: "Rosarivo", size: 16)
        starLabel.font = UIFont(name: "Gill Sans", size: 12)
        genreName.font = UIFont(name: "Rosarivo", size: 12)
        bookCover.image = UIImage(named: book?.coverImage ?? "")
        bookName.text = book?.title ?? ""
        authorName.text = book?.author ?? ""
        if let date = book?.publishedDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            let formattedDate = formatter.string(from: date)
            genreName.text = "\(book?.genre ?? "") - \(formattedDate)"
        }
        aboutBook.text = book?.summary ?? ""
        bookCover.layer.cornerRadius = 16
        starLabel.text = "\(String(book?.rating ?? 0)) ✬"
    }

    
    @IBAction func buyButtonPressed(_ sender: Any) {
    }
}
