//
//  SchoolImagesViewController.swift
//  Ma-shule
//
//  Created by mac on 8/1/18.
//  Copyright © 2018 Maarsharts.co.ke. All rights reserved.
//

import UIKit
import SDWebImage

class SchoolImagesViewController: UIViewController {
    @IBOutlet weak var sliderImage : UIImageView!
    var imageurl : String? {
        didSet{
          // self.sliderImage?.image = image
            self.sliderImage.sd_setImage(with: URL(string: imageurl!), placeholderImage: UIImage(named: "widget-callout-1.png"))
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sliderImage.sd_setImage(with: URL(string: imageurl!), placeholderImage: UIImage(named: "widget-callout-1.png"))
        // Do any additional setup after loading the view.
    }

}
