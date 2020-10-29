//
//  ResourceViewController.swift
//  Ma-shule
//
//  Created by mac on 8/13/18.
//  Copyright © 2018 Maarsharts.co.ke. All rights reserved.
//

import UIKit
import Alamofire

class ResourceViewController: UITableViewController {
    var allResources = [Resource]()
    var resources: [Resource]?

    @IBOutlet var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        getAllResources()
        tableView.reloadData()

        
    }

    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
        
    }
    
    
    func getAllResources(){
        let URL_RESOURCES = Config.sharedManager.base_url+"resources"
        print("URL REQUEST: \(URL_RESOURCES)")
        //getting comment parameters
        let parameters: Parameters = [
            "nameValuePairs":["":""]
            ]
        
        print("Parameters \(parameters)")
        
        
        let headers: HTTPHeaders = [ "Content-type" : "application/json"]
        //print("Headers \(headers)")
        Alamofire.request(URL_RESOURCES, method: HTTPMethod.post, parameters : parameters,  encoding: JSONEncoding(options: []), headers: headers).responseJSON {
            response in
            
            print("Response Data: \(response)")
            
            
            if response.result.value != nil
            {
                //getting the json value from the server
                if let result = response.result.value {
                    let jsonData = result as! [[String: Any]]
                    self.allResources.removeAll()
                    for data in jsonData {
                        let id = data["id"] as! String
                        let name = data["name"] as! String
                        let url = data["url"] as! String
                        let doc_url = data["doc_url"] as! String
                        self.allResources.append(Resource(id:id,name:name,url:url,doc_url:doc_url))
                    }
                    
                    self.resources = self.allResources
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                    
                }else{
                    print((response.result.error)?.localizedDescription as Any)
                }
                
               
            }
        }
        
    }

 

}
extension ResourceViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let resources = resources {
            return resources.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resourceCell", for: indexPath) as! ResourceCell
        cell.resource = self.resources?[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Config.sharedManager.doc_url = (self.resources?[indexPath.row].doc_url)!
        
        
        let resourceDetails = self.storyboard?.instantiateViewController(withIdentifier: "Resource") as! DisplayResourceController
        let navigationController = UINavigationController(rootViewController: resourceDetails)
        self.present(_:navigationController, animated: false, completion: nil)
    }
}
