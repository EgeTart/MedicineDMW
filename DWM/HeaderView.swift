//
//  HeaderView.swift
//  DWM
//
//  Created by 高永效 on 15/9/21.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    //添加虚线
    override func drawRect(rect: CGRect) {
        let shapeLayer = CAShapeLayer(layer: self)
        shapeLayer.bounds = self.bounds
        shapeLayer.position = self.center
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        
        shapeLayer.strokeColor = UIColor(red: 153.0 / 255.0, green: 153.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0).CGColor
        //shapeLayer.strokeColor = UIColor.blackColor().CGColor
        shapeLayer.lineWidth = 0.5
        
        shapeLayer.lineDashPattern = [3, 1]
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 0, 39)
        CGPathAddLineToPoint(path, nil, self.frame.width, 39)
        
        shapeLayer.path = path
        
        self.layer.addSublayer(shapeLayer)
    }

    @IBOutlet weak var moreButton: UIButton!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}
