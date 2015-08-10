//
//  TimelineViewController.swift
//  TemplateProject
//
//  Created by Riya Berry on 7/19/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse
import ConvenienceKit
// var postContent: String? = "hello today"

class TimelineViewController: UIViewController {
    
    var posts: [Post]?
    var postsInChronoOrder: [Post] = []
    var postsInPopularOrder: [Post] = []
    var selectedPost: Post!
    var replyCount: String?
    var refreshControl: UIRefreshControl!
    
    //    var chronoClicked: Int = 0
    //    var popularClicked: Int = 0
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func segmentedControlAction(sender: AnyObject) {
        queries()
          }
    
    func queries(){
        if(segmentedControl.selectedSegmentIndex == 0) {
            if postsInChronoOrder.count == 0 {
                let postsQueryInChronoOrder  = Post.query()
                postsQueryInChronoOrder!.includeKey("user")
                
                postsQueryInChronoOrder!.orderByDescending("createdAt")
                postsQueryInChronoOrder!.findObjectsInBackgroundWithBlock{(result: [AnyObject]?, error: NSError?) -> Void in
                    self.postsInChronoOrder = result as? [Post] ?? []
                    self.posts = self.postsInChronoOrder
                    self.postTableView.reloadData()
                    
                }
            } else {
                self.posts = self.postsInChronoOrder
                self.postTableView.reloadData()}
        }
        
        if(segmentedControl.selectedSegmentIndex == 1) {
            if postsInPopularOrder.count == 0 {
                let postsQueryInPopularOrder = Post.query()
                postsQueryInPopularOrder!.includeKey("user")
                postsQueryInPopularOrder!.orderByDescending("Echoes")
                
                postsQueryInPopularOrder!.findObjectsInBackgroundWithBlock{(result: [AnyObject]?, error: NSError?) -> Void in
                    self.postsInPopularOrder = result as? [Post] ?? []
                    self.posts = self.postsInPopularOrder
                    self.postTableView.reloadData()
                    
                }
            }
            else {
                self.posts = self.postsInPopularOrder
                self.postTableView.reloadData()
                
            }
            
            
        }
        
        self.refreshControl?.endRefreshing()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var postTableView: UITableView!
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        
        postTableView.delegate = self
  queries()
        self.postTableView.reloadData()
        self.postTableView.scrollEnabled = true
        
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "queries", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        
        self.postTableView.addSubview(refreshControl)
        
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // ZS: Updated the identifier text to match what is in Main.storyboard
        //     "showExistingPost" instead of "ShowExistingPost"
        if segue.identifier == "showExistingPost" {
            var rowIndex = postTableView.indexPathForSelectedRow()?.row
            let p = posts
            selectedPost = p![rowIndex!] as Post
            
            let PostDetailVC = segue.destinationViewController as! PostDetailViewController
            PostDetailVC.post = selectedPost
            
            
        }
    }
    
}

//     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // if segue.identifier == "ShowExistingPost" {
//            let PostDetailVC = segue.destinationViewController as! PostDetailViewController
//            PostDetailVC.post = selectedPost



//            if sender as! UITableView == self {
//                let indexPath = self.indexPathForSelectedRow()!
//                PostDetailViewController.post = destinationPost
//            } else {
//                let indexPath = self.postTableView.indexPathForSelectedRow()
//                let destinationPost = self.posts[indexPath!.row].post
//                PostDetailViewController.title = "x"

//PostDetailViewController.title = "x"



/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
}
*/
extension TimelineViewController: UITableViewDelegate {
    //func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //}
    //
    //func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    //    return false
    //}
    
}
extension TimelineViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (posts != nil) {
            return posts!.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 2
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
        let p = posts
        
        if (p != nil) {
            var cellPost = p![indexPath.row] as Post
            cellPost.fetchEchoes()
            cell.post = cellPost
            cell.timeline = self
            cell.replyQuery()

            
        }
        return cell
    }
}



    