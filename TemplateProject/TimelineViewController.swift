//
//  TimelineViewController.swift
//  TemplateProject
//
//  Created by Riya Berry on 7/19/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse 

class TimelineViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // 3
        let postsFromThisUser = Post.query()
        postsFromThisUser!.whereKey("user", equalTo: PFUser.currentUser()!)
        
        // 4
        let query = PFQuery.orQueryWithSubqueries([postsFromThisUser!])
        // 5
        query.includeKey("user")
        // 6
        query.orderByDescending("createdAt")
        
        // 7
//        query.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
//            // 8
//            self.posts = result as? [Post] ?? []
//            
//            for post in self.posts {
//                // 2
//                let data = post.imageFile?.getData()
//                // 3
//            }
//            
//            self.tableView.reloadData()
//        }
        
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

//extension TimelineViewController: UITableViewDataSource {
//        
////        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////            // 1
////            return posts.count
////        }
////        
////        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
////            // 2
////            let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! UITableViewCell
////            
////            cell.textLabel!.text = "Post"
////            
////            cell.postTextView.image = posts[indexPath.row].image
////            
////            return cell
////        }
//    
//}
