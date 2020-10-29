//
//  Config.swift
//  Ma-shule
//
//  Created by mac on 8/9/18.
//  Copyright © 2018 Maarsharts.co.ke. All rights reserved.
//

import Foundation
class Config{
    var base_url = "http://marshaarts.co.ke/The-Young/post/"
    var school_title = ""
    var id = ""
    var lat = ""
    var lon = ""
    var searchString = ""
    var selectedCategory = ""
    var school_description = ""
    var doc_url = ""
    var school_location = ""
    class var sharedManager: Config {
        struct Static {
            static let instance = Config()
        }
        return Static.instance
    }
    
}

