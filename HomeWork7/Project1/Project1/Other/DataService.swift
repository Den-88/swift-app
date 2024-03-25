//
//  DataService.swift
//  Project1
//
//  Created by Денис Шакуров on 15.03.2024.
//

import Foundation

final class DataService {
    private var userDefaults = UserDefaults.standard

    func putFriendsData(friends: [Friends]) {
        for (index, friend) in friends.enumerated() {
            userDefaults.set(friend.name, forKey: "friendName" + String(index))
            userDefaults.set(friend.surname, forKey: "friendSurname" + String(index))
            userDefaults.set(friend.online, forKey: "isFriendOnline" + String(index))
            userDefaults.set(friend.photo, forKey: "friendPhoto" + String(index))
            userDefaults.set(friend.photoBig, forKey: "friendPhotoBig" + String(index))
        }
        userDefaults.set(Date(), forKey: "friendSyncTime")
    }

    func putGroupsData(groups: [Groups]) {
        for (index, group) in groups.enumerated() {
            userDefaults.set(group.name, forKey: "groupName" + String(index))
            userDefaults.set(group.description, forKey: "groupDescription" + String(index))
            userDefaults.set(group.photo, forKey: "GroupPhoto" + String(index))
        }
        userDefaults.set(Date(), forKey: "groupsSyncTime")
    }

    func getFriendsData() -> [Friends] {
        var models: [Friends] = []
        var index = 0
        var isExist = userDefaults.string(forKey: "friendName0") != nil
        while isExist {
            models.append(Friends(name: userDefaults.string(forKey: "friendName" + String(index)) ?? "",
                                  surname: userDefaults.string(forKey: "friendSurname" + String(index)) ?? "",
                                  online: userDefaults.integer(forKey: "isFriendOnline" + String(index)),
                                  photo: userDefaults.string(forKey: "friendPhoto" + String(index)) ?? "",
                                  photoBig: userDefaults.string(forKey: "friendPhotoBig" + String(index)) ?? ""))
            index += 1
            isExist = userDefaults.string(forKey: "friendName" + String(index)) != nil
        }
        return models
    }

    func getGroupsData() -> [Groups] {
        var models: [Groups] = []
        var index = 0
        var isExist = userDefaults.string(forKey: "groupName0") != nil
        while isExist {
            models.append(Groups(name: userDefaults.string(forKey: "groupName" + String(index)) ?? "",
                                 description: userDefaults.string(forKey: "groupDescription" + String(index)) ?? "",
                                  photo: userDefaults.string(forKey: "GroupPhoto" + String(index)) ?? ""))
            index += 1
            isExist = userDefaults.string(forKey: "groupName" + String(index)) != nil
        }
        return models
    }

    func getFriendsSyncTime() -> Date? {
        userDefaults.object(forKey: "friendSyncTime") as? Date
    }

    func getGroupsSyncTime() -> Date? {
        userDefaults.object(forKey: "groupsSyncTime") as? Date
    }
}
