//
//  SchoolTableViewCell.swift
//  Ma-shule
//
//  Created by mac on 7/23/18.
//  Copyright © 2018 Maarsharts.co.ke. All rights reserved.
//

import UIKit

class SchoolTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
