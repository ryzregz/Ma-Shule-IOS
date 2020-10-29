//
//  SchoolImageHeaderView.swift
//  Ma-shule
//
//  Created by mac on 8/1/18.
//  Copyright © 2018 Maarsharts.co.ke. All rights reserved.
//

import UIKit

class SchoolImageHeaderView: UIView {
    @IBOutlet weak var pageControl: UIPageControl!
}

extension SchoolImageHeaderView : SchoolImagesViewControllerDelegate
{
    func setupPageController(numberOfPages: Int)
    {
        pageControl.numberOfPages = numberOfPages
    }
    
    func turnPageController(to index: Int)
    {
        pageControl.currentPage = index
    }
}

