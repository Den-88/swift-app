//
//  PhotosViewController.swift
//  Project1
//
//  Created by Денис Шакуров on 07.03.2024.
//

import UIKit

final class PhotosViewController: UIViewController {
    var token: String

    init(token: String) {
        self.token = token
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
        title = "Фото"
        NetworkService(token: token).getPhotos()
        let childController = PhotoCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        addChild(childController)
        view.addSubview(childController.view)
        childController.didMove(toParent: self)
    }
}
