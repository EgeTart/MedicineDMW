//
//  EnterpriseHeaderView.swift
//  DWM
//
//  Created by MacBook on 9/26/15.
//  Copyright © 2015 EgeTart. All rights reserved.
//

import UIKit

class EnterpriseHeaderView: UITableViewHeaderFooterView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    @IBOutlet weak var controlButton: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let grayLine = UIView(frame: CGRect(x: 15, y: 43, width: UIScreen.mainScreen().bounds.width - 31, height: 0.3))
        grayLine.backgroundColor = UIColor(red: 204 / 255.0, green: 204.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0)
        self.addSubview(grayLine)
    }

}
