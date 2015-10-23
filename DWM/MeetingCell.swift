//
//  MeetingCell.swift
//  DWM
//
//  Created by MacBook on 9/25/15.
//  Copyright © 2015 EgeTart. All rights reserved.
//

import UIKit

class MeetingCell: UITableViewCell {

    
    @IBOutlet weak var meetingImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        meetingImage.layer.borderColor = UIColor(white: 0, alpha: 0.3).CGColor
        meetingImage.layer.borderWidth = 0.5
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
