//
//  CommentTableViewCell.swift
//  TemplateProject
//
//  Created by Riya Berry on 8/5/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse

class CommentTableViewCell: UITableViewCell {
    weak var postDetail: PostDetailViewController?

    @IBAction func flagButton(sender: AnyObject) {
        if (reply!.user != PFUser.currentUser()) {
        let actionSheetController: UIAlertController = UIAlertController(title: "Do you want to flag this reply?", message: "", preferredStyle: .ActionSheet)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        
        let flagAction:UIAlertAction = UIAlertAction(title: "Flag", style: .Default) { action -> Void in
            self.reply!.flagReply(PFUser.currentUser()!)
            
            let replyQuery = PFQuery(className: "Replies")
            var flagReplyCount = 0
            replyQuery.whereKey("replyContent", equalTo: self.reply!.replyContent!)
            replyQuery.findObjectsInBackgroundWithBlock {
                (results: [AnyObject]?, error: NSError?) -> Void in
                if let results = results as? [PFObject] {
                    for somepost in results {
                        
                        flagReplyCount++
                        if flagReplyCount >= 5 {
                            somepost.deleteInBackgroundWithBlock(nil)
                        }
                        else {
                            somepost["flagReplyCount"] = flagReplyCount
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
        postDetail!.presentViewController(actionSheetController, animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var reply: Reply? {
        didSet {
            if let reply = reply {
                commentTextLabel.text = reply.replyContent
                usernameLabel.text = reply.user?.username
                dateLabel.text = reply.createdAt?.shortTimeAgoSinceDate(NSDate()) ?? ""

                
            }
        }
    }

}
