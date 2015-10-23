//
//  AlertView.swift
//  DWM
//
//  Created by MacBook on 9/25/15.
//  Copyright © 2015 EgeTart. All rights reserved.
//

import UIKit

protocol AlertViewDelegate {
    func alertView(button clickedButton: UIButton)
}

class AlertView: UIView {

    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var cancleButton: UIButton!
    
    @IBOutlet weak var sureButton: UIButton!
    
    var delegate: AlertViewDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderColor = UIColor(red: 204.0 / 255.0, green: 204.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0).CGColor
        self.layer.borderWidth = 1.0
        
        cancleButton.layer.borderColor = UIColor(red: 204.0 / 255.0, green: 204.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0).CGColor
        cancleButton.layer.borderWidth = 1.0
        
        sureButton.layer.borderColor = UIColor(red: 204.0 / 255.0, green: 204.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0).CGColor
        sureButton.layer.borderWidth = 1.0
    }
    
    
    @IBAction func buttonClicked(sender: UIButton) {
        
        self.delegate.alertView(button: sender)
    }

}
