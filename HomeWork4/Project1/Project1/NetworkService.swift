//
//  NetworkService.swift
//  Project1
//
//  Created by Денис Шакуров on 07.03.2024.
//

import Foundation

final class NetworkService {
    var token: String
    
    init(token: String) {
        self.token = token
    }
    
    private let session = URLSession.shared
    
    func getFriends(completion: @escaping ([Friends]) -> Void) {
        guard let url = URL(string: "https://api.vk.com/method/friends.get?fields=first_name,last_name,online,photo_100&access_token=\(token)&v=5.131") else {
            print("Invalid URL")
            return
        }
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return
            }
            do {
                let friendsModel = try JSONDecoder().decode(FriendsModel.self, from: data)
                let friends = friendsModel.response.items
                completion(friends)
//                print(friends)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getGroups(completion: @escaping ([Groups]) -> Void) {
        guard let url = URL(string: "https://api.vk.com/method/groups.get?fields=description&access_token=\(token)&extended=1&v=5.131") else {
            print("Invalid URL")
            return
        }
        
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return
            }
            do {
                let groupsModel = try JSONDecoder().decode(GroupsModel.self, from: data)
                let groups = groupsModel.response.items
                completion(groups)
//                print(groups)
            } catch {
                print(error)
            }
        }.resume()
    }
    
        func getPhotos(completion: @escaping ([Photos]) -> Void) {
            guard let url = URL(string: "https://api.vk.com/method/photos.get?access_token=\(token)&album_id=wall&v=5.131") else {
                print("Invalid URL")
                return
            }
    
            session.dataTask(with: url) { (data, _, error) in
                guard let data = data else {
                    return
                }
                do {
                    let photosModel = try JSONDecoder().decode(PhotosModel.self, from: data)
                    let photos = photosModel.response.items
                    completion(photos)
//                    print(photos)
                } catch {
                    print(error)
                }
            }.resume()
        }
}
