//
//  ProfileModel.swift
//  Project1
//
//  Created by Денис Шакуров on 12.03.2024.
//

struct ProfileModel: Codable {
    let response: [Profile]
}

struct Profile: Codable {
    let name: String
    let surname: String
    let photo: String

    enum CodingKeys: String, CodingKey {
        case name = "first_name"
        case surname = "last_name"
        case photo = "photo_max"
    }
}
