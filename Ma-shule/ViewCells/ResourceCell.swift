//
//  ResourceCell.swift
//  Ma-shule
//
//  Created by mac on 8/13/18.
//  Copyright © 2018 Maarsharts.co.ke. All rights reserved.
//

import UIKit
import SDWebImage

class ResourceCell: UITableViewCell {

    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var coverImage : UIImageView!
    
    var resource: Resource!{
        didSet{
            self.updateUI()
        }
    }
    
    
    func updateUI(){
        self.coverImage.sd_setImage(with: URL(string: resource.url), placeholderImage: UIImage(named: "widget-callout-1.png"))
        self.name.text = resource.name
        
        
    }
    
}

