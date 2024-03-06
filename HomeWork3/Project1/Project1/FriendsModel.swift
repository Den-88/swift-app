//
//  FriendsModel.swift
//  Project1
//
//  Created by Денис Шакуров on 07.03.2024.
//
struct FriendsModel: Codable {
    let response: FriensdData
}

struct FriensdData: Codable {
    let items: [Friends]
}

struct Friends: Codable {
    var name: String
    var surname: String

    enum CodingKeys: String, CodingKey {
        case name = "first_name"
        case surname = "last_name"
    }
}
