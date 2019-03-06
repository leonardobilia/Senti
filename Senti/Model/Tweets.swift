//
//  Tweets.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/4/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import Foundation

struct Tweet: Decodable {
    let created_at: String?
    let id_str: String?
    let text: String?
    let user: User?
    let lang: String?
}

struct User: Decodable {
    let id_str: String?
    let name: String?
    let screen_name: String?
    let location: String?
    let description: String?
    let url: String?
    let followers_count: Int?
    let friends_count: Int?
    let created_at: String?
    let favourites_count: Int?
    let verified: Bool?
    let lang: String?
    let profile_background_color: String?
    let profile_background_image_url: String?
    let profile_background_image_url_https: String?
    let profile_image_url: String?
    let profile_image_url_https: String?
}

