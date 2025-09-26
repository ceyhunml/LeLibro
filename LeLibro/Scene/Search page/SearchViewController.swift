//
//  SearchViewController.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 19.09.25.
//

import UIKit

class SearchViewController: BaseViewController {
    
    @IBOutlet private weak var searchBarContainer: CustomSeachBar!
    @IBOutlet private weak var collection: UICollectionView!
    
    let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        collection.collectionViewLayout = createLayout()
        viewModel.books = BookDataManager.shared.books
        viewModel.filteredBooks = viewModel.books
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "BooksCollectionCell", bundle: nil), forCellWithReuseIdentifier: "BooksCollectionCell")
        searchBarContainer.textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        collection.reloadData()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collection.reloadData()
    }
    
    @objc private func textChanged() {
        let query = searchBarContainer.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if query.isEmpty {
            viewModel.filteredBooks = viewModel.books
        } else {
            viewModel.filteredBooks = viewModel.books.filter {
                let titleMatch = $0.title.lowercased().contains(query.lowercased())
                let authorMatch = $0.author.lowercased().contains(query.lowercased())
                return titleMatch || authorMatch
            }
        }
        collection.reloadSections(IndexSet(integer: 0))
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
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
            return section
        }
    }
}


extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.filteredBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BooksCollectionCell", for: indexPath) as! BooksCollectionCell
        cell.layer.cornerRadius = 12
        
        let book = viewModel.filteredBooks.isEmpty ? viewModel.books[indexPath.row] : viewModel.filteredBooks[indexPath.row]
        
        cell.configure(bookName: book.title,
                       bookCover: book.coverImage,
                       bookPrice: "\(String(book.price))$",
                       bookRating: String(book.rating),
                       book: book,
                       currentUser: UserStatusManager.shared.currentUser)
        
        cell.onFavoriteToggle = { book in
            guard let user = UserStatusManager.shared.currentUser else { return }
            self.viewModel.toggleFavorite(for: book, currentUser: user)
            cell.updateFavoriteIcon(for: book, currentUser: user)
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
        let book = viewModel.filteredBooks.isEmpty ? viewModel.books[indexPath.row] : viewModel.filteredBooks[indexPath.row]
        let controller = storyboard?.instantiateViewController(withIdentifier: "BookViewController") as! BookViewController
        controller.book = book
        navigationController?.show(controller, sender: nil)
    }
}

