//
//  SchoolDetailsViewController.swift
//  Ma-shule
//
//  Created by mac on 8/1/18.
//  Copyright © 2018 Maarsharts.co.ke. All rights reserved.
//

import UIKit
import Alamofire

class SchoolDetailsViewController: UIViewController {
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    var boxView = UIView()
    let textLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
    var image_item: ImageItem!
    // OUTLETS AND VARIABLES
    @IBOutlet weak var showSchoolDetails: UIView!
    @IBOutlet weak var showSchoolMap: UIView!
    @IBOutlet weak var showSchoolEvents: UIView!

    @IBOutlet weak var schoolDeatilHeaderView: SchoolImageHeaderView!
    struct Storyboard {
       static let showSchoolImagesPageViewController = "showSchoolImagesPageViewController"
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.showSchoolImagesPageViewController{
            if let imagesPageVC = segue.destination as? ShoolImagesPageViewController {
                //imagesPageVC.schooImages = image_item.imagesurls
                imagesPageVC.pageViewControllerDelegate = schoolDeatilHeaderView
            }
        }
    }
    

    


}
