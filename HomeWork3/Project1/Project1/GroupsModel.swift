//
//  GroupsModel.swift
//  Project1
//
//  Created by Денис Шакуров on 07.03.2024.
//

struct GroupsModel: Codable {
    let response: GroupsdData
}

struct GroupsdData: Codable {
    let items: [Groups]
}

struct Groups: Codable {
    var name: String
}
