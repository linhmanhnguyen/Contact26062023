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
}



