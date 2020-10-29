//
//  SchoolLocationController.swift
//  Ma-shule
//
//  Created by mac on 8/9/18.
//  Copyright © 2018 Maarsharts.co.ke. All rights reserved.
//

import UIKit
import GoogleMaps

class SchoolLocationController: UIViewController {
    
    @IBOutlet var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
       let lati = Double(Config.sharedManager.lat)!
        let longi = Double(Config.sharedManager.lon)!
        

        // Do any additional setup after loading the view.
        let pos = GMSCameraPosition.camera(withLatitude: lati,
                                           longitude: longi,
                                           zoom: 16,
                                           bearing: 270,
                                           viewingAngle: 45)
        self.mapView.camera = pos
     let position = CLLocationCoordinate2D(latitude: lati, longitude: longi)
        let marker = GMSMarker(position: position)
        marker.title = Config.sharedManager.school_title
        marker.snippet = Config.sharedManager.school_location
        marker.map = mapView
        
    }

    

}
extension SchoolLocationController: GMSMapViewDelegate{
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
        lbl1.text = Config.sharedManager.school_title
        view.addSubview(lbl1)
        
        let lbl2 = UILabel(frame: CGRect.init(x: lbl1.frame.origin.x, y: lbl1.frame.origin.y + lbl1.frame.size.height + 3, width: view.frame.size.width - 16, height: 15))
            lbl2.text = Config.sharedManager.school_location
            lbl2.font = UIFont.systemFont(ofSize: 14, weight: .light)
            view.addSubview(lbl2)
        
        return view
    }
}

