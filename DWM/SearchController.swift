//
//  SearchController.swift
//  DWM
//
//  Created by 高永效 on 15/9/21.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UISearchBarDelegate, UITableViewDelegate , UITableViewDataSource {
    
    let searchBar = UISearchBar()

    @IBOutlet weak var searchTableView: UITableView!
    
    
    let sectionIndex = ["#", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    let sectionTitle  = ["药品","会议","企业","视频"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTableView.hidden = true
        
        self.navigationController?.navigationBar.backItem?.title = ""
        searchTableView.dataSource = self
        searchTableView.delegate = self
        
        self.view.tintColor = UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1)
        
        setupSearchBar()
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBarHidden = false
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBarHidden = true
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    func setupSearchBar() {
        searchBar.delegate = self
        
        self.searchBar.frame = CGRect(x: 40, y: 0, width: self.view.frame.width - 60, height: 44)
        self.searchBar.placeholder = "药品、会议、企业、视频"
        
//        let textField = searchBar.valueForKey("_searchField") as! UITextField
//        textField.tintColor = UIColor.whiteColor()
//        textField.attributedPlaceholder = NSAttributedString(string: "药品、会议、企业、视频", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
//        textField.borderStyle = UITextBorderStyle.None
//        textField.textAlignment = NSTextAlignment.Left
//        textField.textColor = UIColor.whiteColor()
        //textField.backgroundColor = UIColor.whiteColor()

        //searchBar.setSearchFieldBackgroundImage(UIImage(named: "slider"), forState: UIControlState.Normal)
        //searchBar.showsCancelButton = true
        searchBar.searchBarStyle = UISearchBarStyle.Minimal
        self.navigationController?.navigationBar.addSubview(searchBar)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchCell") as UITableViewCell!
        cell.textLabel?.text = "blah blah balh (hahaha)"
        cell.textLabel?.textColor = UIColor(red: 33.0 / 255.0, green: 33.0 / 255.0, blue: 33.0 / 255.0, alpha: 1.0)
        //每行cell加箭头
        cell.accessoryType = .DisclosureIndicator

        return cell
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
            
            return sectionIndex
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    //改变section上索引的字体
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).textLabel?.font = UIFont.systemFontOfSize(14)

            (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor(white: 0, alpha: 0.5)

    }
    
}

