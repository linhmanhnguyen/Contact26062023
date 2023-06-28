//
//  FriendResponseModel.swift
//  DemoFriend26062023
//
//  Created by Nguyễn Mạnh Linh on 26/06/2023.
//

import Foundation

struct FriendsResponseModel: Decodable{
    var fullName: String
    var nickName: String
    var avatar: String
    var phoneNumber: String
    var id: String
    
    enum CodingKeys: String, CodingKey{
        case fullName = "fullName"
        case nickName = "nickName"
        case avatar = "avatar"
        case phoneNumber = "phoneNumber"
        case id = "id"
    }
}

typealias Friends = [FriendsResponseModel]
