//
//  MenuViewController.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 14.09.25.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var collection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = makeNavigationLogoView(imageName: "mainLogo", size: 180)
    }
    

}


extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
}
