//
//  Event.swift
//  GithubEvents
//
//  Created by Òscar Muntal on 10/3/23.
//

import Foundation

struct Event: Decodable {
    let id: String
    let type: String
    let actor: Actor
    let repo: Repo
}

struct Actor: Decodable {
    let id: Int
    let name: String
    let avatarUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name = "login"
        case avatarUrl = "avatar_url"
    }
}

extension Actor {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        avatarUrl = try values.decode(String.self, forKey: .avatarUrl)
    }
}

struct Repo: Decodable {
    let id: Int
    let name: String
    let url: String
}
