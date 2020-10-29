//
//  HomeTableViewController.swift
//  Ma-shule
//
//  Created by mac on 7/23/18.
//  Copyright © 2018 Maarsharts.co.ke. All rights reserved.
//

import UIKit
import Alamofire
import DropDown
import RxSwift
import RxCocoa

class HomeTableViewController: UIViewController{
    @IBOutlet weak var main_cover_image: UIImageView!
    var featuredSchools = [School]()
    var schools: [School]?
    let footerId = "footerId"
    let chooseCategory = DropDown()

    @IBOutlet var searchString: UITextField!
    @IBOutlet var categorySpinner: CustomButton!
    @IBOutlet var featuredCollection: UICollectionView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        featuredCollection.dataSource = self
        featuredCollection.delegate = self
        getFeaturedSchool()
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        main_cover_image.layer.opacity = 5.0
        featuredCollection.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerId)
        
        chooseCategory.anchorView = categorySpinner
        chooseCategory.dataSource = ["All Categories", "Kindergatten", "Pre Schools","Primary Schools", "Secondary Schools","International Schools", "Colleges"]
        
        chooseCategory.selectionAction = { [unowned self] (index: Int, item: String) in
            self.categorySpinner.setTitle("\(item)",for: .normal)
        }
    }
    

    @IBAction func spinnerClicked(_ sender: UIButton) {
         chooseCategory.show()
    }
    
    
    @IBAction func search(_ sender: UIButton) {
        let search_string = self.searchString.text!
        let category = self.categorySpinner.currentTitle!
        
        Config.sharedManager.searchString = search_string
        Config.sharedManager.selectedCategory = category
        let searchController = self.storyboard?.instantiateViewController(withIdentifier: "Search") as! SearchViewController
        let navigationController = UINavigationController(rootViewController: searchController)
        self.present(_:navigationController, animated: false, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getFeaturedSchool(){
        let parameters: Parameters=[
            "": ""
        ]
        ApiService.sendApiRequest(parameters: parameters, method: "featuredPosts", onSuccess: { data in
            self.showData(data:data )
            print("Data Successful \(data)")
        }, onError: {error in
            print(error!)
        })
    }
    
    func showData(data:[[String:Any]]){
        for d in data {
            let ID = d["ID"] as! String
            let post_title = d["post_title"] as! String
            let post_image = d["post_image"] as! String
            let location = d["location"] as! String
            let phone_no = d["phone"] as! String
            let latitude = d["latitude"] as! String
            let longitude = d["longitude"] as! String
            let post_content = d["post_content"] as! String
            let comment_count = d["comment_count"] as! String
            
            self.featuredSchools.append(School(ID:ID,post_image:post_image,post_title:post_title,location:location,phone:phone_no,latitude:latitude,longitude:longitude,post_content:post_content,comment_count:comment_count))
            
        }
        self.schools = self.featuredSchools
        DispatchQueue.main.async {
            self.featuredCollection.reloadData()
        }
        
    }

    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
        
    }
    

}

extension HomeTableViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let _ = schools {
            // print("here")
            return schools!.count
           
        } else {
            return 0
        }
        }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SchoolCollectionViewCell
        cell.school = self.schools?[indexPath.row]
        cell.contentView.layer.cornerRadius = 5.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.cornerRadius = 5.0
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.gray.cgColor
       // cell.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
       // cell.layer.shadowRadius = 5.0
        //cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = true
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius : cell.contentView.layer.cornerRadius).cgPath
        
        DispatchQueue.main.async {
            self.featuredCollection.reloadData()
        }
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let school_desc = self.schools?[indexPath.row].post_content
        Config.sharedManager.school_description = school_desc!
        Config.sharedManager.id = (self.schools?[indexPath.row].ID)!
        Config.sharedManager.lat = (self.schools?[indexPath.row].latitude)!
        Config.sharedManager.lon = (self.schools?[indexPath.row].longitude)!
        Config.sharedManager.school_location = (self.schools?[indexPath.row].location)!
        

        let schoolDetails = self.storyboard?.instantiateViewController(withIdentifier: "Details") as! DetailsPageViewController
        let navigationController = UINavigationController(rootViewController: schoolDetails)
        self.present(_:navigationController, animated: false, completion: nil)
        
    }

    
    
    
 
    
    
}
