//
//  MedicineCell.swift
//  DWM
//
//  Created by 高永效 on 15/9/22.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class MedicineCell: UITableViewCell {

    
    @IBOutlet weak var medicineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let shapeLayer = CAShapeLayer(layer: self)
        shapeLayer.bounds = self.bounds
        shapeLayer.position = self.center
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        
        shapeLayer.strokeColor = UIColor(red: 153.0 / 255.0, green: 153.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0).CGColor
        //shapeLayer.strokeColor = UIColor.blackColor().CGColor
        shapeLayer.lineWidth = 0.3
        
        shapeLayer.lineDashPattern = [3, 1]
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 45, 40)
        CGPathAddLineToPoint(path, nil, self.frame.width, 40)
        
        shapeLayer.path = path
        
        self.layer.addSublayer(shapeLayer)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
