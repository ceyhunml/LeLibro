//
//  BookViewController.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 19.09.25.
//

import UIKit

class BookViewController: UIViewController {
    
    @IBOutlet private weak var bookCover: UIImageView!
    @IBOutlet private weak var bookName: UILabel!
    @IBOutlet private weak var authorName: UILabel!
    @IBOutlet private weak var genreName: UILabel!
    @IBOutlet private weak var aboutBook: UILabel!
    @IBOutlet private weak var starLabel: UILabel!
    @IBOutlet private weak var buyButton: UIButton!
    
    var book: Book?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        bookName.font = UIFont(name: "Rosarivo", size: 24)
        authorName.font = UIFont(name: "Rosarivo", size: 16)
        starLabel.font = UIFont(name: "Gill Sans", size: 12)
        bookCover.image = UIImage(named: book?.coverImage ?? "")
        bookName.text = book?.title ?? ""
        authorName.text = book?.author ?? ""
        genreName.text = "\(book?.genre ?? "") - \(book?.publishedDate ?? "")"
        aboutBook.text = book?.summary ?? ""
        bookCover.layer.cornerRadius = 16
        starLabel.text = "\(String(book?.rating ?? 0)) ✬"
        buyButton.applyGillSansFont(title: "Buy for \(book?.price ?? 0)$", size: 20)
    }

    @IBAction private func buyButtonPressed(_ sender: Any) {
        guard let book = book,
              let currentUser = UserStatusManager.shared.currentUser else { return }
        
        if currentUser.basketArray.contains(book.id) {
            alertFor(title: "Already Added!",
                     message: "\"\(book.title)\" is already in your basket.")
        } else {
            currentUser.basketArray.append(book.id)
            CoreDataManager.shared.saveContext()
            UserStatusManager.shared.updateBadges()
            
            alertFor(title: "Success!",
                     message: "\"\(book.title)\" has been added to your basket.")
        }
    }
}
