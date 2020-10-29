//
//  Event.swift
//  Ma-shule
//
//  Created by mac on 8/13/18.
//  Copyright © 2018 Maarsharts.co.ke. All rights reserved.
//

import Foundation

class Event{
    var id = ""
    var event_name = ""
    var event_date = ""
    var event_from = ""
    var event_to = ""
    
    init(id:String,event_name:String,event_date:String,event_from:String,event_to:String){
        self.id = id
        self.event_name = event_name
        self.event_date = event_date
        self.event_from = event_from
        self.event_to = event_to
}
}
