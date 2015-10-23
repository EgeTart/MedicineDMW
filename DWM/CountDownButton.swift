//
//  CountDownButton.swift
//  DWM
//
//  Created by HM on 15/10/15.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class CountDownButton: UIButton {

    var timer:NSTimer!
    var countDownTime = 0
    var originCountDownTime:Int!
    var countRearString:String = ""
    
    func startCountDown() {
        
        self.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.1)
        self.setTitleColor(UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1), forState: UIControlState.Normal)
        countDownTime = originCountDownTime
        enabled = false
        setTitle("\(countDownTime)s后重新获取", forState: UIControlState.Disabled)
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "countDown", userInfo: nil, repeats: true)
    }

    func countDown() {
        countDownTime--
        setTitle("\(countDownTime)s后重新获取", forState: UIControlState.Disabled)
        if (countDownTime == 0) {
            reset()
        }
    }
    
    func reset() {
        self.backgroundColor = UIColor(red: 96/255, green: 200/255, blue: 75/255, alpha: 1)
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        timer.invalidate()
        enabled = true
        setTitle("获取验证码", forState: UIControlState.Normal)
    }
    

}
