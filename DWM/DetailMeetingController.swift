//
//  DetailMeetingController.swift
//  DWM
//
//  Created by HM on 15/9/30.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class DetailMeetingController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
         self.title = "会议详情"
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.title = ""
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
