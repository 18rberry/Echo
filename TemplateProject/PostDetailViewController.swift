//
//  PostDetailViewController.swift
//  TemplateProject
//
//  Created by Riya Berry on 7/31/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import Parse
import UIKit


// var globalVar: String? = "x"

class PostDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var repliesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var date: UILabel!
    var refreshControl: UIRefreshControl!
    
    @IBAction func newReply(sender: AnyObject) {
        self.performSegueWithIdentifier("newReply", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newReply" {
            let destinationVC = segue.destinationViewController as! NewCommentViewController
            destinationVC.post = self.post
        }
    }
    
    
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            switch identifier {
            case "Post":
                println("post")
                let source = segue.sourceViewController as! NewCommentViewController
            case "newComment":
                println()
            default:
                println("default ")
            }
        }
    }
    
    var replies: [Reply] = []
    var repliesInChronoOrder: [Reply] = []
    // var repliesForPost: [Reply] = []
    
    let reply = Reply()
    
    @IBOutlet weak var contentTextView: UITextView!
    
    func queryOfReplies() {
        let replyQueryInChronoOrder  = Reply.query()
        replyQueryInChronoOrder!.includeKey("user")
        //replyQueryInChronoOrder!.includeKey("post")
        replyQueryInChronoOrder!.orderByAscending("createdAt")
        replyQueryInChronoOrder!.whereKey("post", equalTo: post)
        replyQueryInChronoOrder!.findObjectsInBackgroundWithBlock{(result: [AnyObject]?, error: NSError?) -> Void in
            self.repliesInChronoOrder = result as? [Reply] ?? []
            self.replies = self.repliesInChronoOrder
            let countOfReplies = self.repliesInChronoOrder.count
            self.repliesLabel.text = "\(countOfReplies) Replies"
            self.tableView.reloadData()
        }
        self.refreshControl?.endRefreshing()

    }
    
    @IBAction func tBackButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryOfReplies()
        contentTextView.text = post.postContent
        username.text = post.user?.username
        date.text = post.createdAt?.shortTimeAgoSinceDate(NSDate()) ?? ""
        tableView.delegate = self
        tableView.dataSource = self

      var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "queryOfReplies", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        
        self.tableView.addSubview(refreshControl)
    }


        // Do any additional setup after loading the view.

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // let theUser = PFUser(className: "Riya")
    // let thePost = Post(postContent: "hi", user: PFUser(), date: NSDate?())
    // let thePost = Post("hi", theUser, NSDate?())
    
    
    
   // var post: Post?
    var post = Post()

    
//    {
//        didSet {
//            displayPost(post)
//        }
//    }
//    
      func displayPost(post: Post?) {
        if let post = post, contentTextView = contentTextView  {
        //    contentTextView.text = "x"
        //}
        
        }
    }
    
//    func commentQuery() {
//        if repliesInChronoOrder.count == 0 {
//            let postsQueryInChronoOrder  = Post.query()
//            postsQueryInChronoOrder!.includeKey("user")
//            postsQueryInChronoOrder!.orderByDescending("createdAt")
//            postsQueryInChronoOrder!.findObjectsInBackgroundWithBlock{(result: [AnyObject]?, error: NSError?) -> Void in
//                self.repliesInChronoOrder = result as? [Reply] ?? []
//                self.replies = self.repliesInChronoOrder
//                self.tableView.reloadData()
//                
//            }
//        } else {
//            self.replies = self.repliesInChronoOrder
//            self.tableView.reloadData()}
//        
//    }
}

        extension PostDetailViewController: UITableViewDataSource {
            
            func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
                if replies.isEmpty {
                    return 0
                    }
                else {
                    return replies.count
                }
            }
            
            
            func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
                // 2
                let cell = tableView.dequeueReusableCellWithIdentifier("CommentTableViewCell") as! CommentTableViewCell
                    var cellReply = replies[indexPath.row] as Reply
                    cell.reply = cellReply
                cell.postDetail = self
                return cell
}
}

            extension PostDetailViewController: UITableViewDelegate {
                func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
                    return true
                }
                
                
                func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
                    if (editingStyle == .Delete) {
                        let reply = replies[indexPath.row] as Reply
                        println(self.reply)
                        reply.deleteInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                              self.reply.delete()
                         
                        })
                        replies.removeAtIndex(indexPath.row)
                        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                    
     
                }

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
    
 // table view - did select row at index path

