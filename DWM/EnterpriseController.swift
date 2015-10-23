//
//  EnterpriseController.swift
//  DWM
//
//  Created by MacBook on 9/26/15.
//  Copyright © 2015 EgeTart. All rights reserved.
//

import UIKit

class EnterpriseController: UIViewController {
    
    
    @IBOutlet weak var enterpriseTableView: UITableView!
    
    let detailController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("detailController")
    
    let MeetingController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MeetingController")
    
    var expandState = false
    
    var rowsOfThirdSection = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        enterpriseTableView.registerNib(UINib(nibName: "optionCell", bundle: nil), forCellReuseIdentifier: "optionCell")
        enterpriseTableView.registerNib(UINib(nibName: "EnterpriseHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "headerView")
        
        let tabelFootView = UIView(frame: CGRect(x: 0, y: 0, width: enterpriseTableView.frame.width, height: 1000.0))
        tabelFootView.backgroundColor = UIColor(red: 248.0 / 255.0, green: 248.0 / 255.0, blue: 248.0 / 255.0, alpha: 1)
        enterpriseTableView.tableFooterView = tabelFootView
        enterpriseTableView.scrollEnabled = false
    
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.title = ""

    }
 
}

extension EnterpriseController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return rowsOfThirdSection
        default:
            break
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("enterpriseCell", forIndexPath: indexPath)
            
            let imageView = cell.viewWithTag(101) as! UIImageView
            imageView.layer.borderColor = UIColor(red: 204.0 / 255.0, green: 204.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0).CGColor
            imageView.layer.borderWidth = 0.5
            
            let button = cell.viewWithTag(103) as! UIButton
            button.layer.cornerRadius = 3
            button.clipsToBounds = true
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("optionCell", forIndexPath: indexPath) as! optionCell
            
            switch indexPath.row {
            case 0:
                cell.typeImage.image = UIImage(named: "medicine_red")
                cell.label.text = "药品"
            case 1:
                cell.typeImage.image = UIImage(named: "video")
                cell.label.text = "医药视频"
            case 2:
                cell.typeImage.image = UIImage(named: "meeting")
                cell.label.text = "会议视频"
            default:
                break
            }
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("consultCell", forIndexPath: indexPath)
            
            if indexPath.row == 1 {
                let wayLabel = cell.viewWithTag(201) as! UILabel
                let consultLabel = cell.viewWithTag(202) as! UILabel
                
                wayLabel.text = "邮箱:"
                consultLabel.text = "123456789@163.com"
            }
            
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }

}

extension EnterpriseController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 110
        }
        return 44
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 {
            let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("headerView") as! EnterpriseHeaderView
            
            headerView.controlButton.addTarget(self, action: "changeExpandState:", forControlEvents: UIControlEvents.TouchUpInside)
            
            return headerView
        }
        
        return nil
    }
    
    func changeExpandState(button: UIButton) {
        
        if !expandState {
            rowsOfThirdSection = 2
            button.setImage(UIImage(named: "up"), forState: UIControlState.Normal)
        }
        else {
            rowsOfThirdSection = 0
            button.setImage(UIImage(named: "down"), forState: UIControlState.Normal)
        }
        
        enterpriseTableView.reloadData()
        
        expandState = !expandState
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 44
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 0
        }
        return 8
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 && indexPath.row == 0 {
            self.navigationController?.pushViewController(detailController, animated: true)
            
        } else if indexPath.section == 1 && indexPath.row == 1 {
            self.performSegueWithIdentifier("meeting", sender: self)
        } else if indexPath.section == 1 && indexPath.row == 2 {
            self.navigationController?.pushViewController(MeetingController, animated: true)
        }
  
    }
    
    
    
    
    
    
}
