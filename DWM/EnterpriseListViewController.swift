//
//  EnterpriseViewController.swift
//  Medicine
//
//  Created by 高永效 on 15/8/11.
//  Copyright © 2015年 高永效. All rights reserved.
//

import UIKit

class EnterpriseListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var enterpriseScrollView: UIScrollView!
    
    @IBOutlet weak var foreginTableView: UITableView!
    
    @IBOutlet weak var cooperateTableView: UITableView!
    
    @IBOutlet weak var innerTableView: UITableView!
    
    @IBOutlet weak var slideView: UIView!
    
    @IBOutlet weak var foreginButton: UIButton!
    
    @IBOutlet weak var cooperateButton: UIButton!
    
    @IBOutlet weak var innerButton: UIButton!
    //特么列表怎么显示“最近浏览”
//    let sectionIndex = ["#", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
//    
//     let sectionTitle  = ["#最近浏览", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
//    
    var offset: CGFloat = 0.0
    
    var foreginEnterprises: EnterpriseListData!
    var cooperateEnterprises: EnterpriseListData!
    var innerEnterprises: EnterpriseListData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foreginEnterprises = EnterpriseListData(enterpriseType: "1")
        cooperateEnterprises = EnterpriseListData(enterpriseType: "2")
        innerEnterprises = EnterpriseListData(enterpriseType: "0")

        
        self.view.tintColor = UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1)
        
        self.innerButton.setTitleColor(UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1.0), forState: UIControlState.Normal)
        self.cooperateButton.setTitleColor(UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1.0), forState: UIControlState.Normal)

        //changes here,这样最像了。
        let slideImage = UIImageView(frame: CGRect(x: 15, y: -1.5, width: self.view.frame.width / 3.0 - 30, height: 1.5))
        
        slideImage.tag = 1000
        slideImage.image = UIImage(named: "slider.png")
        slideView.addSubview(slideImage)
        
        
        foreginTableView.dataSource = self
        foreginTableView.delegate = self
        
        cooperateTableView.dataSource = self
        cooperateTableView.delegate = self
        
        innerTableView.dataSource = self
        innerTableView.delegate = self
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "swipe:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        swipeLeft.numberOfTouchesRequired = 1
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "swipe:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        swipeRight.numberOfTouchesRequired = 1
        
        enterpriseScrollView.addGestureRecognizer(swipeLeft)
        enterpriseScrollView.addGestureRecognizer(swipeRight)
        
        foreginEnterprises.getEnterprises() {
            self.foreginTableView.reloadData()
        }
        
        cooperateEnterprises.getEnterprises { Void in
            self.cooperateTableView.reloadData()
        }
        
        innerEnterprises.getEnterprises { Void in
            self.innerTableView.reloadData()
        }

    }
    
    func swipe(gesture: UISwipeGestureRecognizer) {
        
        let slideImage = self.view.viewWithTag(1000) as! UIImageView
        
        if gesture.direction == UISwipeGestureRecognizerDirection.Left {
            
            if offset < self.view.frame.width * 2 {
                offset += self.view.frame.width
                setButtonColor()
                UIView.animateWithDuration(0.3) {
                    self.enterpriseScrollView.contentOffset = CGPoint(x: self.offset, y: 0.0)
                    slideImage.frame.origin = CGPoint(x: self.offset / 3.0 + 14, y: -1.5)
                    
                }
            }
        }
        else {
            
            if offset > 0.0 {
                offset -= self.view.frame.width
                setButtonColor()
                UIView.animateWithDuration(0.3) {
                    self.enterpriseScrollView.contentOffset = CGPoint(x: self.offset, y: 0.0)
                    slideImage.frame.origin = CGPoint(x: self.offset / 3.0 + 15, y: -1.5)
                    
                }
            }
        }
    }
    
//MARK: 设置按钮颜色
    func setButtonColor(){
        self.innerButton.setTitleColor(UIColor(red: 144.0/255.0, green: 117.0 / 255.0, blue: 211.0/255.0, alpha: 1.0), forState: UIControlState.Normal)
        self.foreginButton.setTitleColor(UIColor(red: 144.0/255.0, green: 117.0 / 255.0, blue: 211.0/255.0, alpha: 1.0), forState: UIControlState.Normal)
        self.cooperateButton.setTitleColor(UIColor(red: 144.0/255.0, green: 117.0 / 255.0, blue: 211.0/255.0, alpha: 1.0), forState: UIControlState.Normal)
        
        switch offset {
        case 0.0:
            self.innerButton.setTitleColor(UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1.0), forState: UIControlState.Normal)
            self.cooperateButton.setTitleColor(UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1.0), forState: UIControlState.Normal)
        case self.view.frame.width:
            self.innerButton.setTitleColor(UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1.0), forState: UIControlState.Normal)
            self.foreginButton.setTitleColor(UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1.0), forState: UIControlState.Normal)
        case self.view.frame.width * 2.0:
            self.foreginButton.setTitleColor(UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1.0), forState: UIControlState.Normal)
            self.cooperateButton.setTitleColor(UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1.0), forState: UIControlState.Normal)
        default:
            break
        }
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    //这里修改每一部分的section上面的字母
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sectionTitle[section]
//    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("enterprise", sender: self)
    }

    //上面三个按钮的点击事件
    @IBAction func tabChange(sender: AnyObject) {
        let slideImage = self.view.viewWithTag(1000) as! UIImageView
        let button = sender as! UIButton
        offset = CGFloat(button.tag - 600) * self.view.frame.width
        setButtonColor()
        UIView.animateWithDuration(0.3) {
            self.enterpriseScrollView.contentOffset = CGPoint(x: self.offset, y: 0.0)
            slideImage.frame.origin = CGPoint(x: self.offset / 3.0 + 15, y: -1.5)
            
        }
    }
    
    //改变section上索引的字体
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).textLabel?.font = UIFont.systemFontOfSize(14)
        if section == 0 {
           (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor(red: 234/255, green: 123/255, blue: 116/255, alpha: 1)
        }
        else {
             (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor(white: 0, alpha: 0.5)
        }
    }

}

extension EnterpriseListViewController {

//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return sectionTitle.count
//    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView.tag {
            
        case 501:
            return foreginEnterprises.enterprises.count
        case 502:
            return cooperateEnterprises.enterprises.count
        case 503:
            return innerEnterprises.enterprises.count
        default:
            break
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var reusedID = ""
        
        switch tableView.tag {
            
        case 501:
            reusedID = "foreginCell"
        case 502:
            reusedID = "cooperateCell"
        case 503:
            reusedID = "innerCell"
        default:
            break
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reusedID) as UITableViewCell!
        
        switch tableView.tag {
            
        case 501:
            cell.textLabel!.text = foreginEnterprises.enterprises[indexPath.row]["name"] as? String
            //            cell.imageView?.image = UIImage(named: foreginEnterprises[indexPath.row].logo)
        case 502:
            cell.textLabel!.text = cooperateEnterprises.enterprises[indexPath.row]["name"] as? String
            //            cell.imageView?.image = UIImage(named: cooperateEnterprises[indexPath.row].logo)
        case 503:
            cell.textLabel!.text = innerEnterprises.enterprises[indexPath.row]["name"] as? String
            //            cell.imageView?.image = UIImage(named: innerEnterprises[indexPath.row].logo)
        default:
            break
        }
        
        cell.textLabel?.textColor = UIColor(red: 33.0 / 255.0, green: 33.0 / 255.0, blue: 33.0 / 255.0, alpha: 1.0)
        //每行cell加箭头
        cell.accessoryType = .DisclosureIndicator
        
        return cell
    }
    
//    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
//        return sectionIndex
//    }
    
}

extension EnterpriseListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset)
    }
    
}




