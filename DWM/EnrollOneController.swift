//
//  EnrollOneController.swift
//  DWM
//
//  Created by MacBook on 9/26/15.
//  Copyright © 2015 EgeTart. All rights reserved.
//

import UIKit
import Alamofire

//全局变量
var session:String?

class EnrollOneController: UIViewController {
    
    var phoneNum: String?
    var code:String?

    @IBOutlet weak var phoneNumTF: UITextField!
    
    @IBOutlet weak var codeTF: UITextField!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var captchaButton: CountDownButton!

    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "注册"
        captchaButton.backgroundColor = UIColor(red: 96/255, green: 200/255, blue: 75/255, alpha: 1)
        captchaButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        phoneNumTF.delegate = self
        codeTF.delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.title = ""
        
        self.tabBarController?.tabBar.hidden = true
        
        setupUI()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBarHidden = true
        self.tabBarController?.tabBar.hidden = false
    }
    
    func setupUI() {
        
        disableButton()
        
        containerView.layer.borderColor = UIColor(red: 204.0 / 255.0, green: 204.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0).CGColor
        containerView.layer.borderWidth = 0.5
        containerView.layer.shadowColor = UIColor(white: 0, alpha: 0.1).CGColor
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        containerView.layer.shadowOpacity = 1.0
        
        nextButton.layer.cornerRadius = 5.0
        nextButton.clipsToBounds = true
        
        captchaButton.layer.cornerRadius = 3.0
        captchaButton.clipsToBounds = true
    }
    
    func enableButton() {
        nextButton.enabled = true
        nextButton.backgroundColor = UIColor(red: 96/255, green: 200/255, blue: 75/255, alpha: 1)
        nextButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    }
    
    func disableButton() {
        nextButton.enabled = false
        nextButton.backgroundColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1.0)
        nextButton.setTitleColor(UIColor.lightTextColor(), forState: UIControlState.Disabled)
    }

    
    //上传验证码;点击下一步，跳转到“第二步”页面
    @IBAction func next(sender: UIButton) {
        
        dismissKeyboard()
        code = codeTF.text
    
        let params = ["Cookie":"JSESSIONID=laaas", "code": code!]

        Alamofire.request(.POST, "http://112.74.131.194:8080/MedicineProject/App/verifyCode", parameters: params, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (_, _, result) -> Void in
            
            let state = result.value!["result"] as! String
            
            if state == "success" {
                self.performSegueWithIdentifier("enroll", sender: self)
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
    
    //MARK: 获取验证码
    @IBAction func getCode(sender: AnyObject) {
        
        captchaButton.originCountDownTime = 60
        captchaButton.startCountDown()
        
        phoneNum = phoneNumTF.text
        let params = ["phoneNumber":phoneNum!,"type": "1"]
        
        Alamofire.request(.POST, "http://112.74.131.194:8080/MedicineProject/App/getVerificationCode", parameters: params, encoding: ParameterEncoding.URL, headers: nil)
            .responseJSON { (_, _, result) -> Void in
            
            let state = result.value!["result"] as! String
            
            if state == "success" {
                session = result.value!["sessionid"] as? String
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! EnrollSecondController
        destinationVC.phoneNum = phoneNum
    }
    
}

extension EnrollOneController: UITextFieldDelegate {
    
    func dismissKeyboard() {
        phoneNumTF.resignFirstResponder()
        codeTF.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dismissKeyboard()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if (textField == codeTF) {
            if (textField.text != "") {
                enableButton()
            }
            else {
                disableButton()
            }
        }
    }
    
}
