//
//  PhotoCollectionView.swift
//  Project1
//
//  Created by Денис Шакуров on 25.03.2024.
//

import UIKit

class PhotoCollectionView: UICollectionView {
    init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCollectionView() {
        register(PhotoCustomCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.collectionView?.backgroundColor = Theme.currentTheme.backgroundColor
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 5
            layout.minimumLineSpacing = 5
            let itemWidth = (bounds.width - layout.minimumInteritemSpacing) / 2 - 5
            let itemHeight = itemWidth / 1.5
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            layout.sectionInsetReference = .fromSafeArea
        }
    }
}
