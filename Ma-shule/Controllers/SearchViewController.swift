//
//  SearchViewController.swift
//  Ma-shule
//
//  Created by mac on 8/10/18.
//  Copyright © 2018 Maarsharts.co.ke. All rights reserved.
//

import UIKit
import Alamofire
import GoogleMaps

class SearchViewController: UIViewController {
    var resultSchools = [School]()
    var schools: [School]?

    @IBOutlet var mapView: GMSMapView!
    @IBOutlet var searchCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCollectionView.dataSource = self
        searchCollectionView.delegate = self
       searchSchool()
    }
    
    func searchSchool(){
        let parameters: Parameters=[
            "nameValuePairs":["searchValue": Config.sharedManager.searchString,
                              "category": Config.sharedManager.selectedCategory]
            
        ]
        ApiService.sendApiRequest(parameters: parameters, method: "searchPosts", onSuccess: { data in
            self.showResult(data:data )
            print("Data Successful \(data)")
        }, onError: {error in
            if let e = error{
                print(e)
            }
            
        })
    }
    
    func showResult(data: [[String:Any]]){
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
            
            self.resultSchools.append(School(ID:ID,post_image:post_image,post_title:post_title,location:location,phone:phone_no,latitude:latitude,longitude:longitude,post_content:post_content,comment_count:comment_count))
            
            if (data.first != nil){
                let pos = GMSCameraPosition.camera(withLatitude: Double(latitude)!,
                                                   longitude: Double(longitude)!,
                                                   zoom: 10,
                                                   bearing: 270,
                                                   viewingAngle: 45)
                self.mapView.camera = pos
            }
            
            let position = CLLocationCoordinate2D(latitude: Double(latitude)!, longitude: Double(longitude)!)
            let marker = GMSMarker(position: position)
            marker.title = post_title
            marker.map = self.mapView
            
        }
        self.schools = self.resultSchools
        DispatchQueue.main.async {
            self.searchCollectionView.reloadData()
        }
    }
    


}
extension SearchViewController : UICollectionViewDelegate,UICollectionViewDataSource{
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! SearchCollectionCell
        cell.school = self.schools?[indexPath.row]
        cell.contentView.layer.cornerRadius = 5.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.cornerRadius = 5.0
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.masksToBounds = true
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius : cell.contentView.layer.cornerRadius).cgPath
        
        DispatchQueue.main.async {
            self.searchCollectionView.reloadData()
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

extension SearchViewController : GMSMapViewDelegate{
    /* handles Info Window tap */
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("didTapInfoWindowOf")
    }
    
    /* handles Info Window long press */
    func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
        print("didLongPressInfoWindowOf")
    }
    
    /* set a custom Info Window */
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 70))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 6
        
        let lbl1 = UILabel(frame: CGRect.init(x: 8, y: 8, width: view.frame.size.width - 16, height: 15))
        lbl1.text = marker.title
        view.addSubview(lbl1)
        
        return view
    }
}
