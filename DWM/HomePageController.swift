//
//  HomePageController.swift
//  DWM
//
//  Created by 高永效 on 15/9/20.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class HomePageController: UIViewController {
    
    @IBOutlet weak var homeTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let collectionController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("collectionController")
    
    let MeetingController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MeetingController")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        
        homeTableView.dataSource = self
        homeTableView.delegate = self
        
        let tabelFootView = UIView(frame: CGRect(x: 0, y: 0, width: homeTableView.frame.width, height: 1000.0))
        tabelFootView.backgroundColor = UIColor(red: 248.0 / 255.0, green: 248.0 / 255.0, blue: 248.0 / 255.0, alpha: 1)
        homeTableView.tableFooterView = tabelFootView
        
        homeTableView.registerNib(UINib(nibName: "HeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "headerView")
        
        homeTableView.registerNib(UINib(nibName: "optionCell", bundle: nil), forCellReuseIdentifier: "optionCell")
        
        searchBar.delegate = self
        
        homeTableView.scrollEnabled = false
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationController?.navigationBarHidden = false
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
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

//MARK: 为tableview提供数据
extension HomePageController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var reusedID = ""
        
        if indexPath.section == 0 {
            reusedID = "meetingCell"
        }
        else {
            reusedID = "optionCell"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reusedID, forIndexPath: indexPath)
        
        if reusedID == "optionCell" {
            
            if indexPath.section == 2 {
                (cell as! optionCell).typeImage.image = UIImage(named: "video")
                (cell as! optionCell).label.text = "医药视频"
            }
        }
        
        return cell
    }
}

//MARK: 实现tableview的delegate方法
extension HomePageController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 97
        }
        return 40
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 8
    }
    
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("headerView") as! HeaderView
        headerView.moreButton.addTarget(self, action: "lookForMore:", forControlEvents: UIControlEvents.TouchUpInside)
        self.homeTableView.tableHeaderView = headerView
    }
    
    func lookForMore(sender: UIButton) {
        self.performSegueWithIdentifier("lastest", sender: self)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            self.navigationController?.pushViewController(collectionController, animated: true)
        } else if indexPath.section == 2 {
            self.navigationController?.pushViewController(MeetingController, animated: true)
        }
    }

}

//MARK: 实现UISearchBar Delegate
extension HomePageController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        
        self.performSegueWithIdentifier("search", sender: self)
        
        searchBar.resignFirstResponder()
        
        return false
    }

}

