//
//  SearchCollectionCell.swift
//  Ma-shule
//
//  Created by mac on 8/10/18.
//  Copyright © 2018 Maarsharts.co.ke. All rights reserved.
//

import UIKit

class SearchCollectionCell: UICollectionViewCell {
    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var location : UILabel!
    @IBOutlet weak var phone : UILabel!
    @IBOutlet weak var coverImage : UIImageView!
    @IBOutlet weak var rating : UIView!
    
    
    var school: School!{
        didSet{
            self.updateUI()
        }
    }
    
    
    func updateUI(){
        self.coverImage.sd_setImage(with: URL(string: school.post_image), placeholderImage: UIImage(named: "widget-callout-1.png"))
        self.title.text = school.post_title
        self.location.text = school.location
        //self.phone.text = school.phone
        
        
    }
    
}
