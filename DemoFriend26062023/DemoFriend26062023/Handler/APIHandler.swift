//
//  APIHandler.swift
//  DemoFriend26062023
//
//  Created by Nguyễn Mạnh Linh on 26/06/2023.
//

import Foundation
import Alamofire

class APIHandler{
    func getFriends(completion: @escaping(Friends) -> ()){
        AF.request("https://6499b82279fbe9bcf83fdd9c.mockapi.io/friends", method:.get).responseDecodable(of: Friends.self){
            (response) in
            if let friendsResponse = response.value{
                completion(friendsResponse)
            }
        }
    }
    func addFriend(_friend: FriendsResponseModel, completion: @escaping (Bool) -> ()) {
        let url = "https://6499b82279fbe9bcf83fdd9c.mockapi.io/friends"
        let parameters: [String: Any] = [
            "fullName": _friend.fullName,
            "nickName": _friend.nickName,
            "phoneNumber": _friend.phoneNumber
        ]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).response { response in
            if response.error == nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    func updateFriend(id: String, _friend: FriendsResponseModel, completion: @escaping (Bool) -> ()){
        let url = "https://6499b82279fbe9bcf83fdd9c.mockapi.io/friends/\(id)"
        let parameters: [String: Any] = [
            "fullName": _friend.fullName,
            "nickName": _friend.nickName,
            "phoneNumber": _friend.phoneNumber
        ]
        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default).response { respose in
            if respose.error == nil {
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    func deleteFriend(id: String, completion: @escaping (Bool) -> ()){
        let url = "https://6499b82279fbe9bcf83fdd9c.mockapi.io/friends/\(id)"
        AF.request(url, method: .delete).response { respose in
            if respose.error == nil {
                completion(true)
            }else{
                completion(false)
            }
        }
    }
}
