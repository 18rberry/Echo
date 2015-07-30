//
//  ViewController.swift
//  Template Project
//
//  Created by Benjamin Encz on 5/15/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate{
    
    var logInViewController: PFLogInViewController? = PFLogInViewController()
    var signUpViewController: PFSignUpViewController? = PFSignUpViewController()
    var arr:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arr = [9, 10, 11, 12]
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (PFUser.currentUser() == nil) {
            
            self.logInViewController!.fields = PFLogInFields.UsernameAndPassword | PFLogInFields.LogInButton | PFLogInFields.SignUpButton | PFLogInFields.PasswordForgotten | PFLogInFields.DismissButton
            self.logInViewController!.logInView?.backgroundColor = UIColor.whiteColor()
            
            var logInLogoTitle = UILabel()
            logInLogoTitle.text = "Escuela"
            
            self.logInViewController!.logInView!.logo = logInLogoTitle
            
            self.logInViewController!.delegate = self
            
            var signUpLogoTitle = UILabel()
            signUpLogoTitle.text = "Escuela"
            
            self.signUpViewController!.signUpView!.logo = signUpLogoTitle
            
            self.signUpViewController!.delegate = self
            
            self.logInViewController!.signUpController = self.signUpViewController
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Parse Login
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        
        if (!username.isEmpty || !password.isEmpty) {
            return true
        }
        else {
            return false
        }
        
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        println("Failed to login")
        
    }
    
    //Mark: Parse signup
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        println("Failed to signup ...")
        
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        println("User dismissed signup")
}
}