//
//  optionCell.swift
//  DWM
//
//  Created by 高永效 on 15/9/21.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class optionCell: UITableViewCell {

    @IBOutlet weak var typeImage: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
