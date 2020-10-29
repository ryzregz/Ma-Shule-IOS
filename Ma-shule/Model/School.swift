//
//  School.swift
//  Ma-shule
//
//  Created by mac on 8/9/18.
//  Copyright © 2018 Maarsharts.co.ke. All rights reserved.
//

import Foundation
class School{
    var ID = ""
    var post_image = ""
    var post_title = ""
    var location = ""
    var phone = ""
    var latitude = ""
    var longitude = ""
    var post_content = ""
    var comment_count = ""
    
    
    init(ID:String,post_image: String, post_title:String,location:String,phone:String,latitude:String,
         longitude:String,post_content:String,comment_count:String){
        self.ID = ID
        self.post_title = post_title
        self.post_image = post_image
        self.longitude = longitude
        self.location = location
        self.latitude = latitude
        self.phone = phone
        self.post_content = post_content
        self.comment_count = comment_count
    }
   
    func passCardDetailsFromDict(dict:[String:Any])->School{
        if let ID=dict["ID"] as? String{
            
            self.ID=ID
        }
        
        if let post_image=dict["post_image"] as? String{
            
            self.post_image=post_image
        }
        if let post_title=dict["post_title"] as? String{
            
            self.post_title=post_title
        }
        if let location=dict["location"] as? String{
            
            self.location=location
        }
        if let phone=dict["phone"] as? String{
            
            self.phone=phone
        }
        if let latitude=dict["latitude"] as? String{
            
            self.latitude=latitude
        }
        if let longitude=dict["longitude"] as? String{
            
            self.longitude=longitude
        }
        if let comment_count=dict["comment_count"] as? String{
            
            self.comment_count=comment_count
        }
        
        
        
        
        return self
    }
}
