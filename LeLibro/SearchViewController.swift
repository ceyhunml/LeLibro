//
//  SearchViewController.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 19.09.25.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBarContainer: CustomSeachBar!
    @IBOutlet weak var collection: UICollectionView!
    
    var books = [BookEntity]()
    
    var filteredBooks = [BookEntity]()
    
    let manager = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = makeNavigationLogoView(imageName: "mainLogo", size: 140)
        books = manager.fetchBooks()
        filteredBooks = books
        collection.collectionViewLayout = createLayout()
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "BooksCollectionCell", bundle: nil), forCellWithReuseIdentifier: "BooksCollectionCell")
        searchBarContainer.textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        collection.reloadData()
        let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .backgroundLayer
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
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
    
    @objc func textChanged() {
        let query = searchBarContainer.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if query.isEmpty {
            filteredBooks = books
        } else {
            filteredBooks = books.filter {
                let titleMatch = $0.title?.lowercased().contains(query.lowercased()) ?? false
                let authorMatch = $0.author?.lowercased().contains(query.lowercased()) ?? false
                return titleMatch || authorMatch
            }
        }
        collection.reloadSections(IndexSet(integer: 0))
    }
}


extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BooksCollectionCell", for: indexPath) as! BooksCollectionCell
        cell.layer.cornerRadius = 12
        let book = filteredBooks.isEmpty ? books[indexPath.row] : filteredBooks[indexPath.row]
        cell.configure(bookName: book.title ?? "",
                       bookCover: book.coverImage ?? "",
                       bookPrice: String(book.price),
                       bookRating: String(book.rating))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = filteredBooks.isEmpty ? books[indexPath.row] : filteredBooks[indexPath.row]
        let controller = storyboard?.instantiateViewController(withIdentifier: "BookViewController") as! BookViewController
        controller.book = book
        navigationController?.show(controller, sender: nil)
    }
}
    
    
