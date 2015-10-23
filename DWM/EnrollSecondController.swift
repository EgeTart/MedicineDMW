//
//  EnrollSecondController.swift
//  DWM
//
//  Created by MacBook on 9/26/15.
//  Copyright © 2015 EgeTart. All rights reserved.
//

import UIKit
import Alamofire

class EnrollSecondController: UIViewController {
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmTF: UITextField!
    @IBOutlet weak var displayButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var enrollButton: UIButton!
    
    var password: String?
    var confirm: String?
    var phoneNum: String?
    
    var displayState = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "注册"
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.title = ""
        self.tabBarController?.tabBar.hidden = true
        
        passwordTF.delegate = self
        confirmTF.delegate = self
        
        setupUI()
        
        print(phoneNum)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBarHidden = true
        self.tabBarController?.tabBar.hidden = false
    }
    
    func setupUI() {
        containerView.layer.borderColor = UIColor(red: 204.0 / 255.0, green: 204.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0).CGColor
        containerView.layer.borderWidth = 0.5
        containerView.layer.shadowColor = UIColor(white: 0, alpha: 0.1).CGColor
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        containerView.layer.shadowOpacity = 1.0
        
        enrollButton.layer.cornerRadius = 5.0
        enrollButton.clipsToBounds = true
        
        disableButton()
    }
    
    func enableButton() {
        enrollButton.enabled = true
        enrollButton.backgroundColor = UIColor(red: 96/255, green: 200/255, blue: 75/255, alpha: 1)
        enrollButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    }
    
    func disableButton() {
        enrollButton.enabled = false
        enrollButton.backgroundColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1.0)
        enrollButton.setTitleColor(UIColor.lightTextColor(), forState: UIControlState.Disabled)
    }

    @IBAction func register(sender: AnyObject) {

        password = passwordTF.text
        let params = ["Cookie": "JSESSIONID=\(session!)", "password": password!, "device": "2"]

        Alamofire.request(.POST, "http://112.74.131.194:8080/MedicineProject/App/register", parameters: params, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (_, _, result) -> Void in
 
            let state = result.value!["result"] as! String
            
            if state == "success" {
                NSUserDefaults.standardUserDefaults().setValue(self.phoneNum!, forKey: "account")
                NSUserDefaults.standardUserDefaults().setValue(self.password!, forKey: "password")
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "loginState")
                NSUserDefaults.standardUserDefaults().synchronize()
                self.performSegueWithIdentifier("registerSuccess", sender: self)
            }
            else {
                let alert = UIAlertController(title: "提示", message: "出错啦......", preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func displayPassword(sender: AnyObject) {
        confirmTF.secureTextEntry = !displayState
        displayState = !displayState
    }
    
}

extension EnrollSecondController: UITextFieldDelegate {
    
    func dismissKeyboard() {
        passwordTF.resignFirstResponder()
        confirmTF.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dismissKeyboard()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if (passwordTF.text != "" && confirmTF.text != "") {
            enableButton()
        }
        else {
            disableButton()
        }
    }

}
