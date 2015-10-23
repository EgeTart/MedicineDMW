//
//  PersonalController.swift
//  DWM
//
//  Created by 高永效 on 15/9/22.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit
import Alamofire

class PersonalController: UIViewController, LoginDelegate, AlertViewDelegate {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var optionTableView: UITableView!
    @IBOutlet weak var avatorImage: UIImageView!
    @IBOutlet weak var professionalButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    var isLogin: Bool!
    
    let homeDirectory = NSHomeDirectory()
    var filePath = ""
    
    lazy var backgroundView: UIView = {
        
        let _backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
        _backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.5)
    
        return _backgroundView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isLogin = NSUserDefaults.standardUserDefaults().boolForKey("loginState")
        
        let fileUrl = NSURL(string: homeDirectory)!.URLByAppendingPathComponent("/Documents/avator.png")
        filePath = "\(fileUrl)"
        
        setupUI()
        
        optionTableView.registerNib(UINib(nibName: "optionCell", bundle: nil), forCellReuseIdentifier: "optionCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = true
        
        if isLogin != nil && isLogin == false {
            loginButton.hidden = false
            
        } else {
            loginButton.hidden = true
        }
    }

//MARK: UI初始化
    func setupUI() {
    
        loginButton.layer.borderWidth = 1.0
        loginButton.layer.borderColor = UIColor.whiteColor().CGColor
        loginButton.layer.cornerRadius = 12.5
        loginButton.clipsToBounds = true
        
        avatorImage.layer.cornerRadius = 40
        
        optionTableView.tableFooterView = UIView()
        
        professionalButton.layer.borderColor = UIColor.whiteColor().CGColor
        professionalButton.layer.borderWidth = 1.0
        professionalButton.layer.cornerRadius = 12.5
        
        settingButton.layer.borderColor = UIColor.whiteColor().CGColor
        settingButton.layer.borderWidth = 1.0
        settingButton.layer.cornerRadius = 12.5
        
        if isLogin == false {
            professionalButton.hidden = true
            professionalButton.layer.opacity = 0.0
            
            settingButton.hidden = true
            settingButton.layer.opacity = 0.0
            
            nameLabel.hidden = true
            nameLabel.layer.opacity = 0.0
            
            avatorImage.image = UIImage(named: "avator")
        }
        else {
            loginButton.hidden = true
            professionalButton.hidden = true
            
            if let image = UIImage(contentsOfFile: filePath) {
                avatorImage.image = image
            }
            else {
                avatorImage.image = UIImage(named: "avator")
            }
        }
    }
    
// MARK: 设置状态的颜色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "login" {
            let destinationVC = segue.destinationViewController as! LoginController
            destinationVC.delegate = self
        }
    }
    
//MARK: 对登陆成功做出响应
    func loginSuccess() {
        
        professionalButton.hidden = true
        settingButton.hidden = false
        nameLabel.hidden = false
        loginButton.hidden = true
        
        if let image = UIImage(contentsOfFile: filePath) {
            avatorImage.image = image
        }
        else {
            avatorImage.image = UIImage(named: "avator")
        }
        
        self.optionTableView.reloadData()
        
        UIView.animateWithDuration(0.2) { () -> Void in
            self.professionalButton.layer.opacity = 1.0
            self.settingButton.layer.opacity = 1.0
            self.nameLabel.layer.opacity = 1.0
        }

    }

//MARK: 跳转到登陆界面
    @IBAction func login(sender: AnyObject) {
        
        (sender as! UIButton).hidden = true
        
        self.performSegueWithIdentifier("login", sender: self)
    }
    
    @IBAction func registerSuccess(segue: UIStoryboardSegue) {
        print("register success")
        loginSuccess()
        loginButton.hidden = true
        optionTableView.reloadData()
    }
    
//MARK: 对AlertView的按钮点击做出响应
    func alertView(button clickedButton: UIButton) {
        
        if clickedButton.tag == 202 {
            loginButton.hidden = false
            loginButton.layer.opacity = 0
            
            Alamofire.request(.POST, "http://112.74.131.194:8080/MedicineProject/App/user/loginOut", parameters: nil, encoding: ParameterEncoding.URL, headers: nil).responseJSON(completionHandler: { (_, _, result) -> Void in
                
                let state = result.value!["result"] as! String
                
                if state == "success" {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "account")
                        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "password")
                        self.loginButton.layer.opacity = 1.0
                        self.professionalButton.layer.opacity = 0
                        self.settingButton.layer.opacity = 0.0
                        self.nameLabel.layer.opacity = 0.0
                        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "loginState")
                        self.optionTableView.reloadData()
                        
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.professionalButton.hidden = true
                            self.settingButton.hidden = true
                            self.nameLabel.hidden = true
                            self.avatorImage.image = UIImage(named: "avator")
                        })
                    })
                }
                else {
                    //MARK: need some message to metion user
                    NSUserDefaults.standardUserDefaults().setBool(false, forKey: "loginState")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    let alert = UIAlertController(title: "提示", message: "出错啦....", preferredStyle: UIAlertControllerStyle.Alert)
                    let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
                    alert.addAction(action)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            })
        }
        
        self.tabBarController?.tabBar.hidden = false
        clickedButton.superview?.superview?.removeFromSuperview()
        backgroundView.hidden = true
    }

}

//MARK: 为tableview提供数据
extension PersonalController: UITableViewDataSource {
    
    //根据是否登陆来确定section的个数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        isLogin = NSUserDefaults.standardUserDefaults().boolForKey("loginState")
        if isLogin == true {
            return 3
        }
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 3
        }
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("optionCell") as! optionCell
        
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                cell.typeImage.image = UIImage(named: "about")
                cell.label.text = "关于我们"
            case 1:
                cell.typeImage.image = UIImage(named: "share")
                cell.label.text = "分享给朋友"
            case 2:
                cell.typeImage.image = UIImage(named: "feedback")
                cell.label.text = "意见反馈"
            default:
                break
            }
        }
        
        if indexPath.section == 2 {
            cell.typeImage.image = UIImage(named: "exit")
            cell.label.text = "退出登录"
        }
        
        return cell
    }
    
}

//MARK: 实现tableview的delegate方法
extension PersonalController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 8
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 {
            self.performSegueWithIdentifier("collection", sender: self)
        
        }
        else if indexPath.section == 1 && indexPath.row == 1 {
            
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
        else if indexPath.section == 2 {
            
            let alertView = NSBundle.mainBundle().loadNibNamed("AlertView", owner: nil, options: nil).last as! AlertView
            alertView.delegate = self
            
            alertView.frame.size = CGSize(width: 280, height: 130)
            alertView.center = self.view.center
            
            self.tabBarController?.tabBar.hidden = true
            
            backgroundView.hidden = false
            self.view.addSubview(backgroundView)
            self.view.addSubview(alertView)
        }
        else if indexPath.section == 1 && indexPath.row == 2 {
            self.performSegueWithIdentifier("feedback", sender: self)
        }
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.selected = false
    }
    
}

extension PersonalController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func changeAvator(sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let albumAction = UIAlertAction(title: "从相册获取", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in

            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
        let cameraAction = UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
        let cancleAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        
        actionSheet.addAction(albumAction)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(cancleAction)
        self.presentViewController(actionSheet, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        avatorImage.image = image
        
        uploadAvator(image)
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: Upload user's avator
    func uploadAvator(avator: UIImage) {
        saveAvator(avator)
        
        let headers = ["Cookie":"JSESSIONID=\(session!)", "Content-Type": "multipart/form-data"]
        
        let fileURL = NSURL(fileURLWithPath: filePath)
        
        Alamofire.upload(
            .POST,
            "http://112.74.131.194:8080/MedicineProject/upload/image/portrait",
            headers: headers,
            multipartFormData: { multipartFormData in
                multipartFormData.appendBodyPart(fileURL: fileURL, name: "img")
            },
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON { response in
                        print(response)
                    }
                case .Failure(let encodingError):
                    print(encodingError)
                }
        })

    }
    
    func saveAvator(avator: UIImage) {
        UIImagePNGRepresentation(avator)!.writeToFile(filePath, atomically: true)
    }
    
}