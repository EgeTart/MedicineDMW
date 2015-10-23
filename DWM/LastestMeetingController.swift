//
//  LastestMeetingController.swift
//  DWM
//
//  Created by MacBook on 9/26/15.
//  Copyright © 2015 EgeTart. All rights reserved.
//

import UIKit

class LastestMeetingController: UIViewController {

    
    @IBOutlet weak var lastestTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lastestTableView.tableFooterView = UIView()
        
        lastestTableView.registerNib(UINib(nibName: "MeetingCell", bundle: nil), forCellReuseIdentifier: "meetingCell")

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.title = ""
         self.title = "会议更新"
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBarHidden = true
    }
}

extension LastestMeetingController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("meetingCell", forIndexPath: indexPath) as! MeetingCell
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }

}

extension LastestMeetingController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("detailMeeting", sender: self)
    }
    
    
    
}

