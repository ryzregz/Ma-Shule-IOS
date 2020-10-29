//
//  DisplayResourceController.swift
//  Ma-shule
//
//  Created by mac on 8/13/18.
//  Copyright © 2018 Maarsharts.co.ke. All rights reserved.
//

import UIKit
import PDFKit
import WebKit

class DisplayResourceController: UIViewController {
    @IBOutlet var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let webView = UIWebView(frame: view.bounds)
        let request = URLRequest(url: URL(string:Config.sharedManager.doc_url)!)
        webView.loadRequest(request)
        view.addSubview(webView)
        
        
    }

}
