//
//  ShoolImagesPageViewController.swift
//  Ma-shule
//
//  Created by mac on 8/1/18.
//  Copyright © 2018 Maarsharts.co.ke. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
protocol SchoolImagesViewControllerDelegate: class
{
    func setupPageController(numberOfPages: Int)
    func turnPageController(to index: Int)
}

class ShoolImagesPageViewController: UIPageViewController {
   // var schooImages : [UIImage]? = [UIImage(named: "2nd_edition_img")!,UIImage(named: //"page-home-featured-image")!,UIImage(named: "widget-callout-1")!]
    var schooImages : [String]?
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    var boxView = UIView()
    let textLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
    weak var pageViewControllerDelegate: SchoolImagesViewControllerDelegate?
    struct Storyboard {
        static let schoolImageViewController = "SchoolImageViewController"
    }
    
    lazy var controllers : [UIViewController] = {
        let storyboard = UIStoryboard(name : "Main", bundle : nil)
        var controllers = [UIViewController]()
        if let images = self.schooImages {
            for image in images{
                let schoolImageVc = storyboard.instantiateViewController(withIdentifier: Storyboard.schoolImageViewController)
                     controllers.append(schoolImageVc)
            }
        }
        self.pageViewControllerDelegate?.setupPageController(numberOfPages: controllers.count)
        return controllers
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self
        delegate = self
         getImageURLS()
        self.turnToPage(index : 0)
    }

    func turnToPage(index: Int){
        let controller = controllers[index]
        var direction = UIPageViewControllerNavigationDirection.forward
        if let currentVc = viewControllers?.first{
            let currentIndex = controllers.index(of: currentVc)!
            if currentIndex > index {
                direction = .reverse
            }
        }
        self.configureDisplaying(viewController : controller)
        setViewControllers([controller], direction: direction, animated: true, completion : nil)
    }
    
    
    func configureDisplaying(viewController : UIViewController){
        for (index , vc) in controllers.enumerated(){
            if viewController === vc {
                if let schoolImageVc = viewController as? SchoolImagesViewController{
                   // schoolImageVc.sliderImage.image = self.schooImages?[index]
                    schoolImageVc.sliderImage.sd_setImage(with: URL(string: (self.schooImages?[index])!), placeholderImage: UIImage(named: "widget-callout-1.png"))
                }
            }
        }
    }
    
    func getImageURLS(){
        let parameters: Parameters=[
            "post_id": "82"
        ]
        
        // print("Data: \(parameters)")
        
        
        let headers: HTTPHeaders = [ "Content-type" : "application/json" ,"access-key" : "18101987QWERTY" , "app-id" : "1" , "version-name" : "1.3.3"]
        //print("Headers: \(headers)")
        //making a post request
        self.textLabel.text = "loading images......"
        self.showDialog()
        let IMAGELOCATIONS = "http://marshaarts.co.ke/The-Young/post/postImages"
        
        Alamofire.request(IMAGELOCATIONS, method: HTTPMethod.post, parameters : parameters, encoding: JSONEncoding(options: []), headers: headers).responseJSON {
            response in
            
            print("Document Types: \(response)")
            
            
            if response.result.value != nil
            {
                self.activityIndicator.stopAnimating()
                self.hideDialog()
                
                //getting the json value from the server
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    
                    print("Code: \(jsonData.value(forKey: "code") as! Int)")
                    
                    //if there is no error
                    if((jsonData.value(forKey: "code") as! Int) == 1001){
                        let data = jsonData["data"] as? [[String: Any]]
                        for data in data! {
                            self.schooImages?.append(data["image_url"] as! String)
                        }
                        
                        
                    }else if ((jsonData.value(forKey: "code") as! Int) == 1010) {
                        
                        let responseMessage = jsonData.value(forKey: "message") as! String
                        print("\(responseMessage)")
                        
                        
                        
                    }else if ((jsonData.value(forKey: "code") as! Int) == 1030) {
                        let responseMessage = jsonData.value(forKey: "message") as! String
                        print("\(responseMessage)")
                        
                        
                        
                    }
                    
                    
                }
                
                
            } else
            {
                self.activityIndicator.stopAnimating()
                self.hideDialog()
                //let error = response.result.error as NSError?
                
                // self.showAlertDialog(messageString: response.result.error as! String)
                print(response.result.error!)
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

extension ShoolImagesPageViewController : UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = controllers.index(of: viewController){
            if index > 0{
                return controllers[index - 1]
            }
        }
        
        return controllers.last
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = controllers.index(of: viewController){
            if index < controllers.count - 1 {
                return controllers[index + 1]
            }
        }
        
        return controllers.first
    }
    
    
}

extension ShoolImagesPageViewController : UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        self.configureDisplaying(viewController: pendingViewControllers.first as! SchoolImagesViewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed{
            self.configureDisplaying(viewController: previousViewControllers.first as! SchoolImagesViewController)
        }
    }
    
}
