//
//  CustomSignupViewController.swift
//  TemplateProject
//
//  Created by Riya Berry on 7/19/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse

class CustomSignupViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    var grade = ["9th grade", "10th grade", "11th grade", "12th grade"]
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var myPicker: UIPickerView!
    var chosenGrade: String = ""
    
    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView

        // Do any additional setup after loading the view.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(self.actInd)
        usernameField.delegate = self
        passwordField.delegate = self
        myPicker.delegate = self
        myPicker.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    @IBAction func signUpAction(sender: AnyObject) {
        var username = self.usernameField.text
        var password = self.passwordField.text
        var chosenGrade = grade[myPicker.selectedRowInComponent(0)]
        
        
        if count(self.usernameField.text) < 4 || count(self.passwordField.text) < 5 {
            
            var alert = UIAlertView(title: "Invalid", message: "Username must be greater than 4 and password must be greater than 5", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        }
            
        else {
            
            self.actInd.startAnimating()
            
            println(username)
            println(password)
            println(chosenGrade)
            
            var newUser = PFUser()
            newUser.username = username
            newUser.password = password
            newUser.setObject(chosenGrade, forKey: "grade")
            
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                
                
                self.actInd.stopAnimating()
                
                if ((error) != nil) {
                    
                    var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                }else {
                    
                    var alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                    self.performSegueWithIdentifier("sign up", sender: self)
                    
                }
                
            })
            
        }
        
    }

            
    @IBAction func backButton(sender: AnyObject) {
        self.performSegueWithIdentifier("back button", sender: self)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return grade.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return grade[row]
    }
    
    func checkIsUserExists(username: String, completion: ((isUser: Bool?) -> Void)!) {
        
        var isPresent: Bool = false;
        
        let query: PFQuery = PFQuery(className: "User")
        query.whereKey("username", equalTo:username)
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if (objects!.count > 0) {
                    isPresent = true;
                }
                
            } else {
                // Log details of the failure
                println("Error: \(error) \(error!.userInfo!)")
            }
            
            completion(isUser: isPresent);
        }
}
}