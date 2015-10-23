//
//  SetPasswordController.swift
//  DWM
//
//  Created by MacBook on 9/26/15.
//  Copyright © 2015 EgeTart. All rights reserved.
//

import UIKit
import Alamofire

class SetPasswordController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var oldPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var displayButton: UIButton!
    
    let personalController =   UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("confirmToPersonal")

    var oldPassword:String?
    var newPassword:String?
    
    var displayState = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "修改密码"

        oldPasswordTF.delegate = self
        newPasswordTF.delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.title = ""
        
        setupUI()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = true
    }

    func setupUI() {
        containerView.layer.borderColor = UIColor(red: 204.0 / 255.0, green: 204.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0).CGColor
        containerView.layer.borderWidth = 0.5
        containerView.layer.shadowColor = UIColor(white: 0, alpha: 0.1).CGColor
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        containerView.layer.shadowOpacity = 1.0
        
        confirmButton.layer.cornerRadius = 5.0
        confirmButton.clipsToBounds = true
                
        disableButton()
    }
    
    func enableButton() {
        confirmButton.enabled = true
        confirmButton.backgroundColor = UIColor(red: 96/255, green: 200/255, blue: 75/255, alpha: 1)
        confirmButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    }
    
    func disableButton() {
        confirmButton.enabled = false
        confirmButton.backgroundColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1.0)
        confirmButton.setTitleColor(UIColor.lightTextColor(), forState: UIControlState.Disabled)
    }
    
    //MARK: 请求修改密码
    @IBAction func confirmChange(sender: AnyObject) {
    
        oldPassword = oldPasswordTF.text
        newPassword = newPasswordTF.text
        let params = ["Cookie":"JSESSIONID=\(session!)", "newPassword": newPassword!, "oldPassword": oldPassword!]
        
        Alamofire.request(.POST, "http://112.74.131.194:8080/MedicineProject/App/user/updatePassword", parameters: params, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (_, _, result) -> Void in
            
            let state = result.value!["result"] as! String
            
            if state == "success" {
                NSUserDefaults.standardUserDefaults().setValue(self.newPassword!, forKey: "password")
                //刷新数据库
                NSUserDefaults.standardUserDefaults().synchronize()
                //修改完记住新密码，保存登录状态，跳回个人的页面
                self.navigationController?.pushViewController(self.personalController, animated: true)
            }
            else {
                //MARK: make some messages to user .... waiting to do
                let alert = UIAlertController(title: "提示", message: "出错啦......", preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }

    }
    
    @IBAction func displayPassword(sender: AnyObject) {
        newPasswordTF.secureTextEntry = !displayState
        displayState = !displayState
    }
    
}

extension SetPasswordController: UITextFieldDelegate {
    
    func dismissKeyboard() {
        oldPasswordTF.resignFirstResponder()
        newPasswordTF.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dismissKeyboard()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if (oldPasswordTF.text != "" && newPasswordTF.text != "") {
            enableButton()
        }
        else {
            disableButton()
        }
    }
    
}
