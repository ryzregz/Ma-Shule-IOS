//
//  DetailsPageViewController.swift
//  Ma-shule
//
//  Created by mac on 8/8/18.
//  Copyright © 2018 Maarsharts.co.ke. All rights reserved.
//

import UIKit
import Auk
import moa
import Alamofire
import TwicketSegmentedControl

class DetailsPageViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var viewContainer: UIView!
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    var boxView = UIView()
    let textLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
    var imageDescriptions = [String]()
    var imageURLs = [String]()
    @IBOutlet weak var scrollView: UIScrollView!
    var views : [UIView]!
    // OUTLETS AND VARIABLES
    @IBOutlet weak var showSchoolDetails: UIView!
    @IBOutlet weak var showSchoolMap: UIView!
    @IBOutlet weak var showSchoolEvents: UIView!
    
    @IBOutlet weak var segmentedControl: TwicketSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         getImageURLS()
        // Do any additional setup after loading the view.
        segmentedControl.delegate = self
        // LOADING THE  THE DEFAULT VIEW
        didSelect(0)
        // decryptData()
        let titles = ["About", "Location", "Events"]
        segmentedControl.setSegmentItems(titles)
        
        // SETTING THE TEXT COLOR OF THE CHOSEN SEGMENT TO WHITE
        segmentedControl.highlightTextColor = UIColor.white
        
        // SETTING THE TEXT COLOR OF THE OTHER SEGMENTS TO A DARK GRAY
        segmentedControl.defaultTextColor = UIColor.init(red: 171/255.0, green: 183/255.0, blue: 183/255.0, alpha: 1.0)
        
        // SETTING THE BACKGROUND COLOR OF THE CHOSEN SEGMENT TO RED
        segmentedControl.sliderBackgroundColor = UIColor.init(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        
        
        // Turn on the image logger. The download log will be visible in the Xcode console
        Moa.logger = MoaConsoleLogger
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getImageURLS(){
        let parameters: Parameters=[
            "nameValuePairs":["post_id": Config.sharedManager.id]
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
                    let jsonData = result as! [[String: Any]]
                    
                    for data in jsonData {
                            let url =  "\(data["image_url"] as! String)"
                            let desc = data["image_name"] as! String
                         self.imageURLs.append(url)
                        
                            
                            self.imageDescriptions.append(desc)
                        }
                    
                 
                    
                }
                
                // Preload the next and previous images
                self.scrollView.auk.settings.preloadRemoteImagesAround = 1
                
                for url in self.imageURLs{
                    self.scrollView.auk.show(url: url, accessibilityLabel: "")
                    self.scrollView.auk.startAutoScroll(delaySeconds: 5)
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
    
    
    @IBAction func switchController(_ sender: UISegmentedControl) {
       self.viewContainer.bringSubview(toFront: views[sender.selectedSegmentIndex])
        print("Front: \(views[sender.selectedSegmentIndex].description)")
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
    
    /// Animate scroll view on orientation change
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        guard let pageIndex = scrollView.auk.currentPageIndex else { return }
        let newScrollViewWidth = size.width // Assuming scroll view occupies 100% of the screen width
        
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.scrollView.auk.scrollToPage(atIndex: pageIndex, pageWidth: newScrollViewWidth, animated: false)
            }, completion: nil)
    }
    
    /// Animate scroll view on orientation change
    /// Support iOS 7 and older
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation,
                             duration: TimeInterval) {
        
        super.willRotate(to: toInterfaceOrientation, duration: duration)
        
        var screenWidth = UIScreen.main.bounds.height
        if UIInterfaceOrientationIsPortrait(toInterfaceOrientation) {
            screenWidth = UIScreen.main.bounds.width
        }
        
        guard let pageIndex = scrollView.auk.currentPageIndex else { return }
        scrollView.auk.scrollToPage(atIndex: pageIndex, pageWidth: screenWidth, animated: false)
    }
    
    func hideDialog(){
        if boxView.alpha > 0{
            boxView.removeFromSuperview()
        }
        
    }

}
extension DetailsPageViewController:TwicketSegmentedControlDelegate {
    func didSelect(_ segmentIndex: Int) {
        switch segmentIndex
        {
        case 0:
            // SHOWING ABOUT VIEW
            showSchoolDetails.alpha = 1
            showSchoolMap.alpha = 0
            showSchoolEvents.alpha = 0
            
        case 1:
            // SHOWING LOCATION VIEW
            showSchoolDetails.alpha = 0
            showSchoolMap.alpha = 1
            showSchoolEvents.alpha = 0
            
        case 2:
            // SHOWING EVENTS VIEW
            showSchoolDetails.alpha = 0
            showSchoolMap.alpha = 0
            showSchoolEvents.alpha = 1
            
        default:
            break;
        }
        
    }
    
}

