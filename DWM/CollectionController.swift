//
//  CollectionController.swift
//  DWM
//
//  Created by MacBook on 9/25/15.
//  Copyright © 2015 EgeTart. All rights reserved.
//

import UIKit

class CollectionController: UIViewController {
    
    
let detailController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("detailController")
    
    @IBOutlet weak var medicineButton: UIButton!
    
    @IBOutlet weak var meetingButton: UIButton!
    
    @IBOutlet weak var videoButton: UIButton!
    
    @IBOutlet weak var enterpriseButton: UIButton!
    
    @IBOutlet weak var slideView: UIView!
    
    
    @IBOutlet weak var medicineTableView: UITableView!
    
    @IBOutlet weak var meetingTableView: UITableView!
    
    @IBOutlet weak var videoTableView: UITableView!
    
    @IBOutlet weak var enterpriseTableView: UITableView!
    
    @IBOutlet weak var collectionScrollView: UIScrollView!
    
    @IBOutlet weak var buttonsSuperView: UIStackView!
    
    var slideImage: UIImageView!
    
    var offset: CGFloat = 0.0 {
        didSet {
            adjustUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我的收藏"
        
        meetingTableView.registerNib(UINib(nibName: "MeetingCell", bundle: nil), forCellReuseIdentifier: "meetingCell")
        videoTableView.registerNib(UINib(nibName: "MeetingCell", bundle: nil), forCellReuseIdentifier: "meetingCell")
        
        setupUI()
        
        setupScrollView()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: nil)
        
        collectionScrollView.setContentOffset(CGPoint(x: offset, y: 0.0), animated: false)
 
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBarHidden = true
        
    }

// MARK: UI初始化
    func setupUI() {
        medicineTableView.tableFooterView = UIView()
        videoTableView.tableFooterView = UIView()
        meetingTableView.tableFooterView = UIView()
        enterpriseTableView.tableFooterView = UIView()
        
        medicineButton.setTitleColor(UIColor(red: 150.0/255.0, green: 118.0 / 255.0, blue: 214.0/255.0, alpha: 1.0), forState: UIControlState.Normal)
        
        slideImage = UIImageView(frame: CGRect(x: 8, y: -1.5, width: self.view.frame.width / 4.0 - 16, height: 1.5))
        
        slideImage.tag = 1000
        slideImage.image = UIImage(named: "slider.png")
        slideView.addSubview(slideImage)

    }

// MARK: 在滑动之后,对界面做调整
    @IBAction func tabChanged(sender: UIButton) {
        
        offset = CGFloat(sender.tag - 300) * self.view.frame.width
    }
    
    
    func setupScrollView() {
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "swipe:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        swipeLeft.numberOfTouchesRequired = 1
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "swipe:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        swipeRight.numberOfTouchesRequired = 1
        
        collectionScrollView.addGestureRecognizer(swipeLeft)
        collectionScrollView.addGestureRecognizer(swipeRight)
        
    }
    
    func swipe(gesture: UISwipeGestureRecognizer) {
        
        if gesture.direction == UISwipeGestureRecognizerDirection.Left {
            
            if offset < self.view.frame.width * 3.0 {
                offset += self.view.frame.width
            }
        }
        else {
            if offset > 0.0 {
                self.offset -= self.view.frame.width
            }
        }
    }

    func adjustUI() {
        
        self.collectionScrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        
        UIView.animateWithDuration(0.3) { () -> Void in
            self.slideImage.frame.origin.x = self.offset / 4.0 + 8
        }
        
        setButtonColor()
    }
    
    func setButtonColor() {
        
        for subview in buttonsSuperView.subviews {
            
            //灰色
            (subview as! UIButton).setTitleColor(UIColor(red: 153.0/255.0, green: 153.0 / 255.0, blue: 153.0/255.0, alpha: 1.0), forState: UIControlState.Normal)
            //紫色
            if (subview as! UIButton).tag == Int(offset / self.view.frame.width) + 300 {
                (subview as! UIButton).setTitleColor(UIColor(red: 150.0/255.0, green: 118.0 / 255.0, blue: 214.0/255.0, alpha: 1.0), forState: UIControlState.Normal)
            }
        }
    }

}

extension CollectionController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 500:
            return 2
        case 501:
            return 10
        case 502:
            return 7
        case 503:
            return 6
        default:
            break
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch tableView.tag {
        case 500:
            let cell = tableView.dequeueReusableCellWithIdentifier("medicineCell", forIndexPath: indexPath)
            cell.textLabel?.text = "美西律(成分名)"
            cell.detailTextLabel?.text = "正大天晴药业"
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return cell
        case 501:
            let cell = tableView.dequeueReusableCellWithIdentifier("meetingCell", forIndexPath: indexPath) as! MeetingCell
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return cell
        case 502:
            let cell = tableView.dequeueReusableCellWithIdentifier("meetingCell", forIndexPath: indexPath) as! MeetingCell
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return cell
        case 503:
            let cell = tableView.dequeueReusableCellWithIdentifier("enterpriseCell", forIndexPath: indexPath)
            cell.textLabel?.text = "安徽医药有限公司(安徽制药)"
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
}

extension CollectionController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView.tag == 500 || tableView.tag == 503 {
            return 50
        }
        return 80
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (medicineTableView == tableView) {
              self.navigationController?.pushViewController(detailController, animated: true)
        }
    }
    
    
}
