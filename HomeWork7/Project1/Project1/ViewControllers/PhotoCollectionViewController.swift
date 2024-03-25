//
//  PhotoCollectionViewController.swift
//  Project1
//
//  Created by Денис Шакуров on 07.03.2024.
//

import UIKit

class PhotoCollectionViewController: UIViewController, UICollectionViewDataSource {
    var token: String
    lazy private var networkService = NetworkService(token: token)
    private var models: [Photos] = []
    private var collectionView: PhotoCollectionView!

    init(token: String) {
        self.token = token
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        applyTheme()
    }

    private func setupCollectionView() {
        collectionView = PhotoCollectionView(frame: view.bounds)
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }

    private func applyTheme() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.currentTheme.textColor]
        collectionView.backgroundColor = Theme.currentTheme.backgroundColor
    }

    private func fetchData() {
        networkService.getPhotos { [weak self] photos in
            guard let self = self else { return }
            self.models = photos
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
