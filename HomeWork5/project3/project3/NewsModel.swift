//
//  NewsModel.swift
//  project3
//
//  Created by Денис Шакуров on 12.03.2024.
//

struct NewsModel: Codable {
    let results: [News]
}

struct News: Codable {
    let publicationDate: Double
    let title: String

    enum CodingKeys: String, CodingKey {
        case publicationDate = "publication_date"
        case title
    }
}
