//
//  Resource.swift
//  Ma-shule
//
//  Created by mac on 8/13/18.
//  Copyright © 2018 Maarsharts.co.ke. All rights reserved.
//

import Foundation
class Resource{
    var id = ""
    var name = ""
    var doc_url = ""
    var url = ""
    
    init(id:String,name:String,url:String,doc_url:String){
        self.id = id
        self.name = name
        self.url = url
        self.doc_url = doc_url
    }
}
