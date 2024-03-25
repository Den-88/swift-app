//
//  UIImageView+Extentions.swift
//  Project1
//
//  Created by Денис Шакуров on 08.03.2024.
//

import UIKit

extension UIImageView {
    func downloadImage(url: String) {
        guard let imageURL = URL(string: url) else {
            return
        }
        let session = URLSession.shared
        session.dataTask(with: imageURL) { (data, _, _) in
            guard let data = data, let image = UIImage(data: data)
            else {
                return
            }
            DispatchQueue.main.async { () in
                self.image = image
            }
        }.resume()
    }
}
