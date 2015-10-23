//
//  CustomView.swift
//  DelegateDemo
//
//  Created by 高永效 on 15/8/6.
//  Copyright © 2015年 高永效. All rights reserved.
//

import UIKit

protocol CustomAlertViewDelegate {
    
    func buttonDidClicked(buttonType: String)
}

class CustomAlertView: UIView {
    
    var delegate: CustomAlertViewDelegate!
    
    init(title: String!, message: String, buttonsNum: Int) {
        super.init(frame: CGRect(x: 10, y: UIScreen.mainScreen().bounds.height / 2 - 140, width: UIScreen.mainScreen().bounds.width - 20, height: 160))
        self.backgroundColor = UIColor.whiteColor()
        self.layer.cornerRadius = 5
        
        let titleTable = UILabel(frame: CGRect(x: 5, y: 5, width: self.frame.width - 10, height: 40))
        titleTable.font = UIFont.boldSystemFontOfSize(22)
        titleTable.textAlignment = NSTextAlignment.Center
        titleTable.text = title
        self.addSubview(titleTable)
        
        let seperateView = UIView(frame: CGRect(x: 0, y: 46, width: self.frame.width, height: 2.0))
        seperateView.backgroundColor = UIColor(red: 144.0 / 255.0, green: 117.0 / 255.0, blue: 211.0 / 255.0, alpha: 1.0)
        self.addSubview(seperateView)
        
        
        let messageTable = UILabel(frame: CGRect(x: 5, y: 60, width: self.frame.width - 10, height: 30))
        messageTable.font = UIFont.systemFontOfSize(18)
        messageTable.textAlignment = NSTextAlignment.Center
        messageTable.text = message
        self.addSubview(messageTable)
        
        let a = self.frame.width / 2.0 - (self.frame.width / 2.0 - 40) / 2.0
        let b = self.frame.width / 2.0 - 40
        if buttonsNum == 1 {
            let sureButton = UIButton(frame: CGRect(x: a , y: 110 , width: b , height: 30))
            sureButton.setTitle("确定", forState: UIControlState.Normal)
            sureButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            sureButton.setTitleColor(UIColor.lightTextColor(), forState: UIControlState.Highlighted)
            sureButton.backgroundColor = UIColor(red: 144.0 / 255.0, green: 117.0 / 255.0, blue: 211.0 / 255.0, alpha: 1.0)
            sureButton.layer.cornerRadius = 5
            
            sureButton.tag = 202
            sureButton.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)

            self.addSubview(sureButton)
        }
        
        if buttonsNum == 2 {
            
            let cancleButton = UIButton(frame: CGRect(x: 20, y: 110, width: self.frame.width / 2.0 - 30, height: 30))
            cancleButton.setTitle("取消", forState: UIControlState.Normal)
            cancleButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            cancleButton.setTitleColor(UIColor.lightTextColor(), forState: UIControlState.Highlighted)
            cancleButton.backgroundColor = UIColor(red: 251.0 / 255.0, green: 251.0 / 255.0, blue: 251.0 / 255.0, alpha: 1.0)
            cancleButton.layer.cornerRadius = 5
            cancleButton.layer.borderWidth = 0.3
            cancleButton.layer.borderColor = UIColor.grayColor().CGColor
//            cancleButton.layer.borderColor = UIColor.grayColor()
            cancleButton.tag = 201
            cancleButton.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            
            self.addSubview(cancleButton)
            
            let sureButton = UIButton(frame: CGRect(x: self.frame.width / 2.0 + 10.0, y: 110, width: self.frame.width / 2.0 - 30, height: 30))
            sureButton.setTitle("确定", forState: UIControlState.Normal)
            sureButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            sureButton.setTitleColor(UIColor.lightTextColor(), forState: UIControlState.Highlighted)
            sureButton.backgroundColor = UIColor(red: 144.0 / 255.0, green: 117.0 / 255.0, blue: 211.0 / 255.0, alpha: 1.0)
            sureButton.layer.cornerRadius = 5
            
            sureButton.tag = 202
            sureButton.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            
            self.addSubview(sureButton)
        }
        
    }
    
    func buttonClicked(sender: AnyObject) {
        
        let button = sender as! UIButton
        var buttonType: String!
        
        if button.tag == 201 {
            buttonType = "Cancle"
        }
        else {
            buttonType = "Sure"

        }
        
        
        UIView.animateWithDuration(3.5, animations: { () -> Void in
            self.layer.opacity = 0.0
            self.transform = CGAffineTransformMakeScale(0.0, 0.0)
            }) { (flag: Bool) -> Void in
                self.removeFromSuperview()
        }

        delegate.buttonDidClicked(buttonType)

    }
    required init!(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

