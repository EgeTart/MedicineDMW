//
//  DetailController.swift
//  DWM
//
//  Created by MacBook on 9/26/15.
//  Copyright © 2015 EgeTart. All rights reserved.
//

import UIKit

class DetailController: UIViewController {

    
    @IBOutlet weak var detailTableView: UITableView!
    
    var medicineCategory = 1
    var medicineID = ""
    
    let db = MedicineDB.sharedInstance()
    
    var navigationButton: NavigationButton!
    
    var optionTitles = [String]()
    
    var details = [Dictionary<String, [String]>]()
    var detailContent = [Dictionary<String, String!>]()
    
    var showState = false
    
    lazy var navigationTableView: UITableView! = {
        let _navigationTableView = UITableView(frame: CGRect(x: UIScreen.mainScreen().bounds.width, y: UIScreen.mainScreen().bounds.height - 9.0 * 44.0 - 70.0, width: 141, height: 9.0 * 44.0))
        _navigationTableView.delegate = self
        _navigationTableView.dataSource = self
        _navigationTableView.tag = 101
        _navigationTableView.separatorStyle = UITableViewCellSeparatorStyle.None

        _navigationTableView.layer.cornerRadius = 5
        _navigationTableView.layer.shadowColor = UIColor(white: 000000, alpha: 0.3).CGColor
        _navigationTableView.layer.shadowOffset = CGSize(width: -6, height: 6)
        _navigationTableView.layer.shadowOpacity = 1
        //_navigationTableView.clipsToBounds = false
        _navigationTableView.bounces = true
        
        _navigationTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "optionCell")
        return _navigationTableView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTableView.registerNib(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: "detailCell")

        detailTableView.rowHeight = UITableViewAutomaticDimension
        detailTableView.estimatedRowHeight = detailTableView.frame.height
        
        self.view.addSubview(navigationTableView)
        
        getMedicineDetail()
        
        print(medicineID)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.title = ""
        
        navigationButton = NSBundle.mainBundle().loadNibNamed("NavigationButton", owner: nil, options: nil).last as! NavigationButton
        navigationButton.frame = CGRect(x: self.view.frame.width - 141, y: 7, width: 120, height: 30)
        
        //分享按钮，添加事件
        navigationButton.shareButton.addTarget(self, action: "share", forControlEvents: UIControlEvents.TouchUpInside)

        self.navigationController?.navigationBar.addSubview(navigationButton)
        
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        
        self.tabBarController?.tabBar.hidden = false
        
        navigationButton.removeFromSuperview()
    }
    
    
    @IBAction func changeState(sender: UIButton) {
        
        self.view.bringSubviewToFront(navigationTableView)
        
        //加上偏移量，收起菜单就可以完全隐藏了。
        var offset: CGFloat = self.view.frame.width + 6
        
        if showState == false {
            
            offset -= 141.0
        }
        
        UIView.animateWithDuration(0.3) { () -> Void in
            self.navigationTableView.frame.origin.x = offset
        }
        
        showState = !showState
    }

}

extension DetailController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == navigationTableView {
            return optionTitles.count
        }
        return detailContent.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView == navigationTableView {
            let cell = tableView.dequeueReusableCellWithIdentifier("optionCell", forIndexPath: indexPath)
            cell.textLabel?.font = UIFont.systemFontOfSize(16)
            cell.textLabel?.text = optionTitles[indexPath.row]
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("detailCell", forIndexPath: indexPath) as! DetailCell
        
        cell.titleLabel.text = detailContent[indexPath.row]["title"]
        cell.detailLabel.text = detailContent[indexPath.row]["info"]
        cell.detailLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell.detailLabel.sizeToFit()
        
        return cell
    }
    
    func share() {
        let shareParames = NSMutableDictionary()
        shareParames.SSDKSetupShareParamsByText("分享内容",
            images : UIImage(named: "shareImg.png"),
            url : NSURL(string:"http://mob.com"),
            title : "分享标题",
            type : SSDKContentType.Auto)
        //2.进行分享
        ShareSDK.showShareActionSheet(self.view, items: nil, shareParams: shareParames) { (state : SSDKResponseState, platformType : SSDKPlatformType, userdata : [NSObject : AnyObject]!, contentEnity : SSDKContentEntity!, error : NSError!, Bool end) -> Void in
            
            switch state{
                
            case SSDKResponseState.Success: print("分享成功")
            case SSDKResponseState.Fail:    print("分享失败,错误描述:\(error)")
            case SSDKResponseState.Cancel:  print("分享取消")
                
            default:
                break
            }
        }
    }
    
    func getMedicineDetail() {
        db.open()
        
        var tableName = "west_medicine"
        if (medicineCategory == 2) {
            tableName = "chinese_medicine"
        }
        
        let results = db.executeQuery("select * from \(tableName) where id=\(medicineID)", withArgumentsInArray: nil)
        
        if (medicineCategory == 1) {
            
            let fieldName = ["ADRS", "content", "current_application", "dose_explain", "interaction", "manual", "name", "other_name", "pharmacolo", "preparations", "warn"]
            
            while(results.next()) {
                for field in fieldName {
                    let information = results.stringForColumn(field)
                    let title = getTitle(information)
                    optionTitles.append(title)
                    let content = ["title": title, "info": information]
                    detailContent.append(content)
                }
            }
            
        }
            //查询中药的数据 : medicineCategory == 2
        else {
            let fieldName = ["annouce","category","content","efficacy","manual","name","preparations","price","store"]
            
            while(results.next()) {
                for field in fieldName {
                    let information = results.stringForColumn(field)
                    let title  = getTitle(information)
                    optionTitles.append(title)
                    let content = ["title":title,"info":information]
                    detailContent.append(content)
                }
            }
        }
    }
    
    func getTitle(information: String) -> String {
        
        var index = 0
        
        for character in information.characters {
            index++
            if (character == "】" || character == "］") {
                break
            }
        }
        
        return information.substringToIndex(information.startIndex.advancedBy(index))
    }

}

extension DetailController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == navigationTableView {
            showState = false
            
            detailTableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.Top)
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                tableView.frame.origin.x = self.view.frame.width
            })
        }
    }
}

extension DetailController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView.superview == navigationTableView) {
            navigationTableView.frame = CGRect(x: UIScreen.mainScreen().bounds.width, y: UIScreen.mainScreen().bounds.height - 9.0 * 44.0 - 70.0, width: 141, height: 9.0 * 44.0)
        }
    }
}
