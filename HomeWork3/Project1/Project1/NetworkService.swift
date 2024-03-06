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
    
    func getFriends() {
        let url = URL(string: "https://api.vk.com/method/friends.get?fields=first_name,last_name&access_token=\(token)&v=5.131")
        
        session.dataTask(with: url!) { (data, _, error) in
            guard let data = data else {
                return
            }
            do {
                let friends = try JSONDecoder().decode(FriendsModel.self, from: data)
                print(friends)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getGroups() {
        let url = URL(string: "https://api.vk.com/method/groups.get?access_token=\(token)&extended=1&v=5.131")
        
        session.dataTask(with: url!) { (data, _, error) in
            guard let data = data else {
                return
            }
            do {
                let groups = try JSONDecoder().decode(GroupsModel.self, from: data)
                print(groups)
            } catch {
                print(error)
            }
        }.resume()
    }
    
        func getPhotos() {
            let url = URL(string: "https://api.vk.com/method/photos.get?access_token=\(token)&album_id=wall&v=5.131")
    
            session.dataTask(with: url!) { (data, _, error) in
                guard let data = data else {
                    return
                }
                do {
                    let photos = try JSONDecoder().decode(PhotosModel.self, from: data)
                    print(photos)
                } catch {
                    print(error)
                }
            }.resume()
        }
}
