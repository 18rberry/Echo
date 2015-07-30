//
//  SettingsViewController.swift
//  TemplateProject
//
//  Created by Riya Berry on 7/19/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//


import UIKit
import Parse
import ParseUI

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutAction(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("logOut", sender: self)
    
    }
    

 /*   @IBAction func feedSettings(sender: AnyObject) {
        self.performSegueWithIdentifier("feedSettings", sender: self)
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
