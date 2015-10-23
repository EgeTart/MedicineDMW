//
//  FeedbackController.swift
//  DWM
//
//  Created by MacBook on 9/26/15.
//  Copyright © 2015 EgeTart. All rights reserved.
//

import UIKit
import Alamofire

class FeedbackController: UIViewController{
    
    
    @IBOutlet weak var feedbackTextView: UITextView!

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var suggestionTF: UITextView!
    
    @IBOutlet weak var phoneNumTF: UITextField!
    
    @IBOutlet weak var qqTF: UITextField!
    
    var suggestion:String?
    var phoneNum:String?
    var qq:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "意见反馈"
        phoneNumTF.delegate = self
        qqTF.delegate = self
        feedbackTextView.delegate = self
        
        setupUI()

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.title = ""
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBarHidden = true
    }
    
    func setupUI() {
        feedbackTextView.layer.borderWidth = 0.5
        feedbackTextView.layer.borderColor = UIColor(red: 204.0 / 255.0, green: 204.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0).CGColor
        feedbackTextView.layer.shadowOpacity = 1.0
        feedbackTextView.layer.shadowColor = UIColor(white: 0, alpha: 0.1).CGColor
        feedbackTextView.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor(red: 204.0 / 255.0, green: 204.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0).CGColor
        containerView.layer.shadowOpacity = 1.0
        containerView.layer.shadowColor = UIColor(white: 0, alpha: 0.1).CGColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 3.0)

        sendButton.layer.cornerRadius = 5.0
        sendButton.clipsToBounds = true
        
        disableButton()
    }
    
    func enableButton() {
        sendButton.enabled = true
        sendButton.backgroundColor = UIColor(red: 96/255, green: 200/255, blue: 75/255, alpha: 1)
        sendButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    }
    
    func disableButton() {
        sendButton.enabled = false
        sendButton.backgroundColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1.0)
        sendButton.setTitleColor(UIColor.lightTextColor(), forState: UIControlState.Disabled)
    }
    
    @IBAction func sendSuggestion(sender: AnyObject) {

        suggestion = suggestionTF.text
        phoneNum = phoneNumTF.text
        qq = qqTF.text
        
        let params = ["content":suggestion!,"phone":phoneNum!,"qqNumber":qq!]
        
        Alamofire.request(.POST, "http://112.74.131.194:8080/MedicineProject/App//user/addFeedBack", parameters: params, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (_, _, result) -> Void in
            
            let state = result.value!["result"] as! String
            
            if state == "success" {
                //MARK: waiting to do
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
    
}

extension FeedbackController: UITextFieldDelegate, UITextViewDelegate {
    func dismissKeyboard() {
        phoneNumTF.resignFirstResponder()
        qqTF.resignFirstResponder()
        feedbackTextView.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
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
        
        if ((phoneNumTF.text != "" || qqTF.text != "") && feedbackTextView.text != "") {
            enableButton()
        }
        else {
            disableButton()
        }
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        
        if (textView.text == "请填写您的宝贵意见:") {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if ((phoneNumTF.text != "" || qqTF.text != "") && feedbackTextView.text != "") {
            enableButton()
        }
        else {
            disableButton()
        }
    }

}
