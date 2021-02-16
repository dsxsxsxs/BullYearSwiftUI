//
//  Issue.swift
//  BullYearSwiftUI
//
//  Created by Jiacheng Shih on 2021/02/16.
//

import Foundation

struct User {
    let login: String
    let avatarURL: URL
}

extension User: Decodable, Hashable {
    private enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}

struct Issue: Identifiable, Hashable {
    var id: Int {
        self.hashValue
    }
    let number: Int
    let title: String
    let body: String
    let url: URL
    let user: User
}

extension Issue: Decodable {
    private enum CodingKeys: String, CodingKey {
        case number, title, body, user
        case url = "html_url"
    }
}
