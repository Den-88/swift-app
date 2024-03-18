//
//  PhotoCollectionViewController.swift
//  Project1
//
//  Created by Денис Шакуров on 07.03.2024.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController {
    var token: String
    lazy private var networkService = NetworkService(token: token)
    private var models: [Photos] = []

    init(token: String) {
        self.token = token
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout) 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.currentTheme.textColor]

        collectionView.register(PhotoCustomCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.collectionView?.backgroundColor = Theme.currentTheme.backgroundColor
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 5
            layout.minimumLineSpacing = 5
            let itemWidth = (collectionView.bounds.width - layout.minimumInteritemSpacing) / 2 - 5
            let itemHeight = itemWidth / 1.5
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            layout.sectionInsetReference = .fromSafeArea
        }
        
        networkService.getPhotos() { [self] photos in
            self.models = photos
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.currentTheme.textColor]
        collectionView.collectionViewLayout.collectionView?.backgroundColor = Theme.currentTheme.backgroundColor
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        guard let cell = cell as? PhotoCustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        let model = models[indexPath.row]
        guard let lastSize = model.sizes.last else {
            return cell
        }
        cell.setupPhotos(photos: lastSize)
        return cell
    }
}
