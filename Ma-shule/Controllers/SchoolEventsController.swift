//
//  SchoolEventsController.swift
//  Ma-shule
//
//  Created by mac on 8/9/18.
//  Copyright © 2018 Maarsharts.co.ke. All rights reserved.
//

import UIKit
import Alamofire

class SchoolEventsController: UIViewController {
    var allEvents = [Event]()
    var events: [Event]?
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    var boxView = UIView()
    let textLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))

    @IBOutlet var eventsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsCollectionView.dataSource = self
        eventsCollectionView.delegate = self
        getEvents()
    }
  
    func getEvents(){
        let URL_EVENTS = Config.sharedManager.base_url+"events"
        print("URL REQUEST: \(URL_EVENTS)")
        //getting comment parameters
        let parameters: Parameters=[
           "nameValuePairs":["post_id":Config.sharedManager.id]
        ]
        
        print("Parameters \(parameters)")
        
        
        let headers: HTTPHeaders = [ "Content-type" : "application/json"]
        //print("Headers \(headers)")
        self.textLabel.text = "loading events......"
        self.showDialog()
        Alamofire.request(URL_EVENTS, method: HTTPMethod.post, parameters : parameters,  encoding: JSONEncoding(options: []), headers: headers).responseJSON {
            response in
            
            print("Response Data: \(response)")
            self.activityIndicator.stopAnimating()
            self.hideDialog()
           
            if response.result.value != nil
            {
                //getting the json value from the server
                if let result = response.result.value {
                
                        let jsonData = result as! [[String: Any]]
                        self.allEvents.removeAll()
                        for data in jsonData {
                            let id = data["id"] as! String
                            let event_name = data["event_name"] as! String
                            let event_date = data["event_date"] as! String
                            let event_from = data["event_from"] as! String
                            let event_to = data["event_to"] as! String
                            
                            
                            self.allEvents.append(Event(id:id,event_name:event_name,event_date:event_date,event_from:event_from,event_to:event_to))
                            
                        }
                        self.events = self.allEvents
                        DispatchQueue.main.async {
                            self.eventsCollectionView.reloadData()
                        }
                    
                 
                
                    
                }else{
                    print((response.result.error)?.localizedDescription as Any)
                }
            }
        }
        
    }
    
    func showDialog(){
        
        boxView = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25, width: 180, height: 50))
        boxView.backgroundColor = UIColor.gray
        boxView.alpha = 0.8
        boxView.layer.cornerRadius = 10
        
        //Here the spinnier is initialized
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.hidesWhenStopped = true
        
        textLabel.textColor = UIColor.white
        textLabel.font = textLabel.font.withSize(10)
        
        boxView.addSubview(activityIndicator)
        boxView.addSubview(textLabel)
        activityIndicator.startAnimating()
        view.addSubview(boxView)
        
        
        
        
    }
    
    func hideDialog(){
        if boxView.alpha > 0{
            boxView.removeFromSuperview()
        }
        
    }


}
extension SchoolEventsController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let _ = events {
            // print("here")
            return events!.count
            
        } else {
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EventCell
        cell.event = self.events?[indexPath.row]
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
            self.eventsCollectionView.reloadData()
        }
        
        
        return cell
        
    }
    
    
}

