//
//  MedicineListController.swift
//  DWM
//
//  Created by 高永效 on 15/9/22.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

enum ExpandState: Int {
    
    case close = 0
    case open = 1
}

class MedicineListController: UIViewController {

    
    @IBOutlet weak var mordenTableView: UITableView!
    
    @IBOutlet weak var tradictionTableView: UITableView!
    
    @IBOutlet weak var separateView: UIView!
    
    @IBOutlet weak var medicineScrollView: UIScrollView!
    
    @IBOutlet weak var mordenButton: UIButton!
    
    @IBOutlet weak var tradictionButton: UIButton!
    
    var mordenState = ExpandState.close
    var mordenSection = -1
    
    var tradictionState = ExpandState.close
    var tradictionSection = -1
    
    var medicinesType = MedicineType()
    
    var mordenMedicineLevels = MedicineLevel(parentTypeID: "1")
    var tradictionMedicineLevels = MedicineLevel(parentTypeID: "12")
    var mordenSubLevelMedicine = [Dictionary<String, String!>]()
    var tradictionSubLevelMedicine = [Dictionary<String, String!>]()
    
    var selectedMedicineType = ""
    var selectedMedicineID = ""
    var medicineCategory = 1
    
    let db = MedicineDB.sharedInstance()
    
    var offset: CGFloat = 0 {
        didSet {
            medicineScrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
            
            setButtonColor()
            
            medicineCategory = Int(offset / self.view.frame.width) + 1
            
            let slideImage = self.view.viewWithTag(1000) as! UIImageView
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                slideImage.frame.origin.x = self.offset / 2.0 + 15.0
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mordenTableView.registerNib(UINib(nibName: "SectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "headerView")
        
        mordenTableView.registerNib(UINib(nibName: "MedicineCell", bundle: nil), forCellReuseIdentifier: "medicineCell")
        
        mordenTableView.sectionFooterHeight = 0
        
        tradictionTableView.registerNib(UINib(nibName: "SectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "headerView")
        
        tradictionTableView.registerNib(UINib(nibName: "MedicineCell", bundle: nil), forCellReuseIdentifier: "medicineCell")
        
        tradictionTableView.sectionFooterHeight = 0

        setupScrollView()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = false
        
        if offset == self.view.frame.width {
            offset = self.view.frame.width
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    @IBAction func tabChoosed(sender: AnyObject) {
        
        offset = CGFloat((sender as! UIButton).tag - 200) * self.view.frame.width
    }
    
    func setupScrollView() {
        
        let slideImage = UIImageView(frame: CGRect(x: 15, y: -1.5, width: self.view.frame.width / 2.0 - 30, height: 1.5))
        
        slideImage.tag = 1000
        slideImage.image = UIImage(named: "slider.png")
        separateView.addSubview(slideImage)

        self.tradictionButton.setTitleColor(UIColor(red: 153.0/255.0, green: 153.0 / 255.0, blue: 153.0/255.0, alpha: 1.0), forState: UIControlState.Normal)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "swipe:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        swipeLeft.numberOfTouchesRequired = 1
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "swipe:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        swipeRight.numberOfTouchesRequired = 1
        
        medicineScrollView.addGestureRecognizer(swipeLeft)
        medicineScrollView.addGestureRecognizer(swipeRight)
    
    }
    
    func swipe(gesture: UISwipeGestureRecognizer) {
        
        if gesture.direction == UISwipeGestureRecognizerDirection.Left {
            
            if offset == 0.0 {
                offset += self.view.frame.width
            }
        }
        else {
            if offset == self.view.frame.width {
                offset -= self.view.frame.width
            }
        }
    }

    func setButtonColor(){
        
        self.mordenButton.setTitleColor(UIColor(red: 150.0/255.0, green: 118.0 / 255.0, blue: 214.0/255.0, alpha: 1.0), forState: UIControlState.Normal)
        self.tradictionButton.setTitleColor(UIColor(red: 150.0/255.0, green: 118.0 / 255.0, blue: 214.0/255.0, alpha: 1.0), forState: UIControlState.Normal)
        
        switch offset {
        case 0.0:
           self.tradictionButton.setTitleColor(UIColor(red: 153.0/255.0, green: 153.0 / 255.0, blue: 153.0/255.0, alpha: 1.0), forState: UIControlState.Normal)
        case self.view.frame.width:
            self.mordenButton.setTitleColor(UIColor(red: 153.0/255.0, green: 153.0 / 255.0, blue: 153.0/255.0, alpha: 1.0), forState: UIControlState.Normal)
        default:
            break
        }
    }

}

//MARK tableview datasources
extension MedicineListController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView == mordenTableView {
            //return medicinesType.mordenMedicine.sencondLevel.count
            return mordenMedicineLevels.subTypes.count
        }
        return tradictionMedicineLevels.subTypes.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == mordenTableView {
            if mordenState == ExpandState.open && mordenSection == section {
                //return medicinesType.mordenMedicine.thirdLevel.count
                return mordenSubLevelMedicine.count
            }
            return 0
        }
        else {
            if tradictionState == ExpandState.open && tradictionSection == section {
                //return 5
                return tradictionSubLevelMedicine.count
            }
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("medicineCell") as! MedicineCell
        
        if (tableView == mordenTableView) {
            cell.medicineLabel.text = mordenSubLevelMedicine[indexPath.row]["name"]
        }
        else {
            cell.medicineLabel.text = tradictionSubLevelMedicine[indexPath.row]["name"]
        }
        return cell
    }

}





//MARK tableview delegate
extension MedicineListController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("headerView") as! SectionHeaderView
        headerView.stateButton.tag = section + 100
        
        if tableView == mordenTableView {
            headerView.secondLevelLabel.text = mordenMedicineLevels.subTypes[section]["name"]
        }
        else {
            headerView.secondLevelLabel.text = tradictionMedicineLevels.subTypes[section]["name"]
        }
        
        headerView.stateButton.addTarget(self, action: "closeOrOpen:", forControlEvents: UIControlEvents.TouchUpInside)
        
        if (mordenState == ExpandState.open && mordenSection == section && tableView == mordenTableView) || (tradictionState == ExpandState.open && tradictionSection == section && tableView == tradictionTableView) {
            
            headerView.stateImage.image = UIImage(named: "close")
            headerView.secondLevelLabel.textColor = UIColor(red: 234.0 / 255/0, green: 123.0 / 255.0, blue: 116.0 / 255.0, alpha: 1.0)
        }
        else {
            headerView.stateImage.image = UIImage(named: "expand")
            headerView.secondLevelLabel.textColor = UIColor.blackColor()
        }
        
        return headerView
    }
    
    func closeOrOpen(button: UIButton) {
        
        if offset == 0.0 {
            if mordenSection == button.tag - 100 {
                mordenState = ExpandState(rawValue: (mordenState.rawValue + 1) % 2)!
            }
            else {
                mordenSection = button.tag - 100
                mordenState = ExpandState.open
                let parentTypeID = mordenMedicineLevels.subTypes[button.tag - 100]["id"]!
                getSubLevelData(parentTypeID)
            }
            
            mordenTableView.reloadData()
        }
        else {
            if tradictionSection == button.tag - 100 {
                tradictionState = ExpandState(rawValue: (tradictionState.rawValue + 1) % 2)!
            }
            else {
                tradictionSection = button.tag - 100
                tradictionState = ExpandState.open
                let parentTypeID = tradictionMedicineLevels.subTypes[button.tag - 100]["id"]!
                getSubLevelData(parentTypeID)
            }
            
            tradictionTableView.reloadData()
        }
    }
    
    func getSubLevelData(parentTypeID: String) {
        
        var subLevelMedicine = [Dictionary<String, String!>]()
        
        db.open()
        
        let results = db.executeQuery("select id from medicine_type where parent_type_id=\(parentTypeID)", withArgumentsInArray: nil)
        
        while(results.next()) {
            let thirdLevelID = results.stringForColumn("id")
            
            let fourthLevelResults = db.executeQuery("select id, name from medicine_type where parent_type_id=\(thirdLevelID)", withArgumentsInArray: nil)
            
            while(fourthLevelResults.next()) {
                let id = fourthLevelResults.stringForColumn("id")
                let name = fourthLevelResults.stringForColumn("name")
                let medicine = ["id": id, "name": name]
                subLevelMedicine.append(medicine)
            }
        }
        
        if (medicineCategory == 1) {
            mordenSubLevelMedicine = subLevelMedicine
        }
        else {
            tradictionSubLevelMedicine = subLevelMedicine
        }
        
        db.close()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 40
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (tableView == mordenTableView) {
            selectedMedicineType = mordenSubLevelMedicine[indexPath.row]["name"]!
            selectedMedicineID = mordenSubLevelMedicine[indexPath.row]["id"]!
        }
        else {
            selectedMedicineType = tradictionSubLevelMedicine[indexPath.row]["name"]!
            selectedMedicineID = tradictionSubLevelMedicine[indexPath.row]["id"]!
        }
        
        self.performSegueWithIdentifier("medicine", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destinatonVC = segue.destinationViewController as! MedicineController
        destinatonVC.parentType = selectedMedicineType
        destinatonVC.medicineTypeID = selectedMedicineID
        destinatonVC.medicineCategory = medicineCategory
    }
}


//MARK: 取消粘滞效果
extension MedicineListController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let sectionHeaderHeight: CGFloat = 50.0
        
        if scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0 {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)
        }
        else if scrollView.contentOffset.y >= sectionHeaderHeight {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0)
        }
    }
}
