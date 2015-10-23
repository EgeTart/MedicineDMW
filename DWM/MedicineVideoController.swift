//
//  MedicineVideoController.swift
//  DWM
//
//  Created by HM on 15/9/30.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class MedicineVideoController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var meetingTableView: UITableView!
    
    let DetailMeetingController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DetailMeetingController")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        meetingTableView.tableFooterView = UIView()
        
        meetingTableView.registerNib(UINib(nibName: "MeetingCell", bundle: nil), forCellReuseIdentifier: "meetingCell")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //显示 navigation bar
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "医药视频"
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBarHidden = true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return 10
    }
        
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("meetingCell", forIndexPath: indexPath) as! MeetingCell
            
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            
            return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.navigationController?.pushViewController(DetailMeetingController, animated: true)
    }
    
}

