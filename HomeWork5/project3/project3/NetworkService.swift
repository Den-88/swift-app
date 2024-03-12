//
//  NetworkService.swift
//  project3
//
//  Created by Денис Шакуров on 12.03.2024.
//

import Foundation

final class NetworkService {
    private let session = URLSession.shared
    
    func getNews(completion: @escaping ([News]) -> Void) {
        guard let url = URL(string: "https://kudago.com/public-api/v1.4/news/?&fields=publication_date,title&actual_only=true") else {
            print("Invalid URL")
            return
        }
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return
            }
            do {
                let newsModel = try JSONDecoder().decode(NewsModel.self, from: data)
                completion(newsModel.results)
            } catch {
                print(error)
            }
        }.resume()
    }
}
