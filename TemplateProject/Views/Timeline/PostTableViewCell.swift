//
//  PostTableViewCell.swift
//  TemplateProject
//
//  Created by Riya Berry on 7/30/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import Parse
import UIKit
import Bond

class PostTableViewCell: UITableViewCell {
    weak var timeline: TimelineViewController?
    var echoBond: Bond<[PFUser]?>!
    
    @IBOutlet weak var numberOfReplies: UILabel!
    
    
    
    @IBOutlet weak var echoesLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // 1
        echoBond = Bond<[PFUser]?>() { [unowned self] echoList in
            // 2
            if let echoList = echoList {
                // 3
                
                self.echoesLabel.text = self.stringFromUserList(echoList)
                // 4
                self.echoButton.selected = contains(echoList, PFUser.currentUser()!)
                // 5
            } else {
                // 6
                // if there is no list of users that like this post, reset everything
                self.echoesLabel.text = ""
                self.echoButton.selected = false
            }
        }
    }
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var flagButton: UIButton!
    @IBAction func echoButtonPressed(sender: AnyObject) {
        post?.toggleEchoPost(PFUser.currentUser()!)
    }
    @IBAction func flagButtonPressed(sender: AnyObject) {
        
        if (post!.user == PFUser.currentUser()) {
            let actionSheetController: UIAlertController = UIAlertController(title: "Do you want to delete this post?", message: "", preferredStyle: .ActionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        //Create and add first option action
        let deleteAction: UIAlertAction = UIAlertAction(title: "Delete", style: .Default) { action -> Void in
            //Code for launching the camera goes here
            self.post!.deleteInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                    self.post!.delete()
                

            })
            }
            
            actionSheetController.addAction(deleteAction)
            
            actionSheetController.popoverPresentationController?.sourceView = sender as! UIView;
            
            //Present the AlertController
            timeline!.presentViewController(actionSheetController, animated: true, completion: nil)
            
        }
            
        else  {
            let actionSheetController: UIAlertController = UIAlertController(title: "Do you want to flag this post?", message: "", preferredStyle: .ActionSheet)
        
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
                //Just dismiss the action sheet
            }
            actionSheetController.addAction(cancelAction)
            
            let flagAction:UIAlertAction = UIAlertAction(title: "Flag", style: .Default) { action -> Void in
                self.post!.flagPost(PFUser.currentUser()!)
                
                let postQuery = PFQuery(className: "Post")
                var flagCount = 0
                postQuery.whereKey("postContent", equalTo: self.post!.postContent!)
                postQuery.findObjectsInBackgroundWithBlock {
                    (results: [AnyObject]?, error: NSError?) -> Void in
                    if let results = results as? [PFObject] {
                        for somepost in results {
                            
                            flagCount++
                            if flagCount >= 5 {
                                somepost.deleteInBackgroundWithBlock(nil)
                            }
                            else {
                                somepost["flagContent"] = flagCount
                            somepost.saveInBackground()
                            }
                        }
                        
                    }
                }
            }
            
            actionSheetController.addAction(flagAction)
            
        //Create and add a second option action
        
        //We need to provide a popover sourceView when using it on iPad
        actionSheetController.popoverPresentationController?.sourceView = sender as! UIView;
        
        //Present the AlertController
        timeline!.presentViewController(actionSheetController, animated: true, completion: nil)
    }
}
    
    var post: Post? {
        didSet {
            if let post = post {
            postCellTextView.text = post.postContent
            usernameLabel.text = post.user?.username
            dateLabel.text = post.createdAt?.shortTimeAgoSinceDate(NSDate()) ?? ""
            post.echoes ->> echoBond
            postCellTextView.editable = false
            postCellTextView.userInteractionEnabled = true
                
            // let aVariable = post.replyCount
            // numberOfReplies.text = "\(aVariable) replies"
                
            }
        }
    }
    
    func replyQuery() {
        let replyQueryInChronoOrder  = Reply.query()
        replyQueryInChronoOrder!.includeKey("user")
        replyQueryInChronoOrder!.orderByDescending("createdAt")
        replyQueryInChronoOrder!.whereKey("post", equalTo: post!)
        replyQueryInChronoOrder!.countObjectsInBackgroundWithBlock{(count: Int32, error: NSError?) -> Void in
            self.numberOfReplies.text = "\(count) Replies"
            
        }
         
    }
    
    func stringFromUserList(userList: [PFUser]) -> String {
        // 1
        let usernameList = userList.map { user in user.username! }
        // 2

        let number = userList.count
        var stringValue = "\(number)"
        
        //let postQuery = PFQuery(className: "Post")
        let postQuery = Post.query()
        // println(post!.description)
        postQuery!.whereKey("postContent", equalTo: post!.postContent!)
        postQuery!.findObjectsInBackgroundWithBlock {
            (results: [AnyObject]?, error: NSError?) -> Void in
            if let results = results as? [PFObject] {
                for somepost in results {
                    somepost["Echoes"] = number
                    somepost.saveInBackground()
                }
            }
        }
        
        return stringValue
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var postCellTextView: UITextView!
    
    }
