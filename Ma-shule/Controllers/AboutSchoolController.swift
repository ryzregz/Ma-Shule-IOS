//
//  AboutSchoolController.swift
//  Ma-shule
//
//  Created by mac on 8/9/18.
//  Copyright © 2018 Maarsharts.co.ke. All rights reserved.
//

import UIKit

class AboutSchoolController: UIViewController {

    
    @IBOutlet var desc: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.desc.text = "\(Config.sharedManager.school_description)"
        self.desc.numberOfLines = 0
        self.desc.lineBreakMode = NSLineBreakMode.byWordWrapping
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
