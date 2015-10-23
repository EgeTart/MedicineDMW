//
//  SectionHeaderView.swift
//  DWM
//
//  Created by 高永效 on 15/9/22.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView {

//    override func drawRect(rect: CGRect) {
//        // Drawing code
//        
//    }
    
    @IBOutlet weak var secondLevelLabel: UILabel!
    
    @IBOutlet weak var thirdLevelLabel: UILabel!

    @IBOutlet weak var stateImage: UIImageView!
    
    @IBOutlet weak var stateButton: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let grayLine = UIView(frame: CGRect(x: 0, y: 49, width: UIScreen.mainScreen().bounds.width, height: 0.3))
        grayLine.backgroundColor = UIColor(red: 153.0 / 255.0, green: 153.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0)
        self.addSubview(grayLine)
    }

}
