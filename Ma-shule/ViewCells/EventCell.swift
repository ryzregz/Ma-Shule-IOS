//
//  EventCell.swift
//  Ma-shule
//
//  Created by Eclectics on 17/09/2018.
//  Copyright © 2018 Maarsharts.co.ke. All rights reserved.
//

import UIKit

class EventCell: UICollectionViewCell {
    @IBOutlet weak var month : UILabel!
    @IBOutlet weak var date : UILabel!
    @IBOutlet weak var day : UILabel!
    @IBOutlet weak var event_name : UILabel!
    @IBOutlet weak var event_time : UILabel!
    
    
    var event: Event!{
        didSet{
            self.updateUI()
        }
    }
    
    
    func updateUI(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: event.event_date)
        let mf = DateFormatter()
        mf.setLocalizedDateFormatFromTemplate("MMM")
        let mon = mf.string(from: date!)
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("EEEE")
        let da = df.string(from: date!)
        
        self.month.text = mon
        self.day.text = String(da.prefix(3))
        self.event_name.text = event.event_name
        self.event_time.text = "\(event.event_from) - \(event.event_to)"
        
        
    }
}
