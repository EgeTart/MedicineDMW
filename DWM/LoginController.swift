//
//  LoginController.swift
//  DWM
//
//  Created by 🐑🐑🐑 on 15/9/24.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit
import Alamofire

protocol LoginDelegate {
    func loginSuccess()
}

class LoginController: UIViewController {
    
    @IBOutlet weak var accountView: UIView!
    
    @IBOutlet weak var enrollButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var accountTF: UITextField!
    
    @IBOutlet weak var cipherTF: UITextField!
    
    var userName:String?
    var userCipher: String?
    
    var delegate: LoginDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        accountTF.delegate = self
        cipherTF.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.tabBar.hidden = false
    }

    func setupUI() {
        accountView.layer.borderColor = UIColor(red: 204.0 / 255.0, green: 204.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0).CGColor
        accountView.layer.borderWidth = 1.0
        accountView.layer.cornerRadius = 5.0
        accountView.clipsToBounds = true
        
        enrollButton.layer.cornerRadius = 5.0
        loginButton.layer.cornerRadius = 5.0
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    @IBAction func login(sender: AnyObject) {
        
        dismissKeyboard()
    
        userName = accountTF.text
        userCipher = cipherTF.text
        let params = ["account": userName!, "password": userCipher!,"device": "2"]

        //登陆请求
        Alamofire.request(.POST, "http://112.74.131.194:8080/MedicineProject/App/login", parameters: params, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (_, _, result) -> Void in
            
            let state = result.value!["result"] as! String
            
            if state == "success" {
                session = result.value!["sessionid"] as? String
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.navigationController?.popViewControllerAnimated(true)
                    NSUserDefaults.standardUserDefaults().setValue(self.userName!, forKey: "account")
                    NSUserDefaults.standardUserDefaults().setValue(self.userCipher!, forKey: "password")
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "loginState")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    self.delegate.loginSuccess()
                })
            }
            else {
                //MARK: need some message to metion user
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: "loginState")
                NSUserDefaults.standardUserDefaults().synchronize()
                let alert = UIAlertController(title: "提示", message: "请检查您的帐号和密码是否有误....", preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }

    }
    
    @IBAction func enroll(sender: UIButton) {
        dismissKeyboard()
        self.performSegueWithIdentifier("enroll", sender: self)
    }
}

extension LoginController: UITextFieldDelegate {
    
    func dismissKeyboard() {
        accountTF.resignFirstResponder()
        cipherTF.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dismissKeyboard()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        UIView.animateWithDuration(0.3) { () -> Void in
            self.view.frame.origin.y = -100.0
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        UIView.animateWithDuration(0.3) { () -> Void in
            self.view.frame.origin.y = 0.0
        }
    }

}
