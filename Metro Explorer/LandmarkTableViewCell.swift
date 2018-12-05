//
//  MetroTableViewCell.swift
//  Metro Explorer
//
//  Created by zhenghao zhang on 12/2/18.
//  Copyright © 2018 zhenghao zhang. All rights reserved.
//

import UIKit

class LandmarkTableViewCell: UITableViewCell {
    
    @IBOutlet weak var landmarkNameLabel: UILabel!
    @IBOutlet weak var landmarkLogoImage: UIImageView!
    @IBOutlet weak var landmarkAddressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
