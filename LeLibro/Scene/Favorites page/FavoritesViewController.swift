//
//  FavoritesViewController.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 24.09.25.
//

import UIKit

class FavoritesViewController: BaseViewController {
    
    @IBOutlet private weak var collection: UICollectionView!
    
    let viewModel = FavoritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        collection.collectionViewLayout = createLayout()
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "BooksCollectionCell", bundle: nil), forCellWithReuseIdentifier: "BooksCollectionCell")
        if let user = UserStatusManager.shared.currentUser {
            let favoriteIDs = user.favoritesArray
            viewModel.favoriteBooks = BookDataManager.shared.books.filter { favoriteIDs.contains($0.id) }
        }
        collection.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadFavorites()
    }
    
    private func reloadFavorites() {
        if let user = UserStatusManager.shared.currentUser {
            let favoriteIDs = user.favoritesArray
            viewModel.favoriteBooks = BookDataManager.shared.books.filter { favoriteIDs.contains($0.id) }
        } else {
            viewModel.favoriteBooks = []
        }
        
        collection.reloadData()
        
        if viewModel.favoriteBooks.isEmpty {
            let label = UILabel()
            label.text = "No favorites yet ♥"
            label.font = UIFont(name: "Gill Sans", size: 28)
            label.textColor = .main
            label.textAlignment = .center
            collection.backgroundView = label
        } else {
            collection.backgroundView = nil
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .absolute(360)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(360)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 16
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 16, bottom: 16, trailing: 16)
            return section
        }
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.favoriteBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BooksCollectionCell", for: indexPath) as! BooksCollectionCell
        cell.layer.cornerRadius = 12
        
        let book = viewModel.favoriteBooks[indexPath.row]
        
        cell.configure(bookName: book.title,
                       bookCover: book.coverImage,
                       bookPrice: "\(String(book.price))$",
                       bookRating: String(book.rating),
                       book: book,
                       currentUser: UserStatusManager.shared.currentUser)
        
        cell.onFavoriteToggle = { [weak self] book in
            guard let self = self, let user = UserStatusManager.shared.currentUser else { return }
            self.viewModel.toggleFavorite(for: book, currentUser: user)
            self.reloadFavorites()
            UserStatusManager.shared.updateBadges()
        }
        
        cell.onBasketToggle = { book in
            guard let user = UserStatusManager.shared.currentUser else { return }
            self.viewModel.toggleBasket(for: book, currentUser: user)
            cell.updateBasketIcon(for: book, currentUser: user)
            UserStatusManager.shared.updateBadges()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = viewModel.favoriteBooks[indexPath.row]
        let controller = storyboard?.instantiateViewController(withIdentifier: "BookViewController") as! BookViewController
        controller.book = book
        navigationController?.show(controller, sender: nil)
    }
}
