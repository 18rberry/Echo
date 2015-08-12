//
//  TabBarViewController.swift
//  TemplateProject
//
//  Created by Riya Berry on 8/11/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor.whiteColor()
    
        
        // Sets the default color of the background of the UITabBar
        UITabBar.appearance().backgroundColor = UIColor.yellowColor()
        
    
        // UITabBar.appearance().imageTint = UIColor.blackColor()
        

        // Do any additional setup after loading the view.
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

}
