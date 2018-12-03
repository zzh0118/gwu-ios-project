//
//  MetroTableViewCell.swift
//  Metro Explorer
//
//  Created by zhenghao zhang on 12/2/18.
//  Copyright © 2018 zhenghao zhang. All rights reserved.
//

import UIKit

class MetroTableViewCell: UITableViewCell {

    @IBOutlet weak var metroNameLabel: UILabel!
    @IBOutlet weak var metroLogoImage: UIImageView!
    @IBOutlet weak var metroAddressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
