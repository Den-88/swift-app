//
//  PhotosModel.swift
//  Project1
//
//  Created by Денис Шакуров on 07.03.2024.
//

struct PhotosModel: Codable {
    let response: PhotosdData
}

struct PhotosdData: Codable {
    let items: [Photos]
}

struct Photos: Codable {
    let id: Double
    let sizes: [Urls]
}

struct Urls: Codable {
    let url: String
}

