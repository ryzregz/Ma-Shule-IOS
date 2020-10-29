//
//  SchoolModel.swift
//  Ma-shule
//
//  Created by mac on 9/3/18.
//  Copyright © 2018 Maarsharts.co.ke. All rights reserved.
//

import Foundation
struct SchoolModel: Codable {
    var ID: String?
    var post_image: String?
    var post_title: String?
    var location: String?
    var phone: String?
    var latitude: String?
    var longitude: String?
    var post_content: String?
    var comment_count : String?
    private enum CodingKeys: String, CodingKey {
        case ID
        case post_image
        case post_title
        case location
        case phone
        case latitude
        case longitude
        case post_content
        case comment_count
    }
}
