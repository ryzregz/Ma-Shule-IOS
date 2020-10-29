//
//  EventsCollectionViewCell.swift
//  Ma-shule
//
//  Created by mac on 8/13/18.
//  Copyright © 2018 Maarsharts.co.ke. All rights reserved.
//

import UIKit

class EventsCollectionViewCell: UICollectionViewCell {
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
        self.day.text = da
        self.event_name.text = event.event_name
        
        
    }

}
