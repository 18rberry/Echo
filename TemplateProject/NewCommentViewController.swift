//
//  NewCommentViewController.swift
//  TemplateProject
//
//  Created by Riya Berry on 8/6/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class NewCommentViewController: UIViewController, UITextViewDelegate {
    let reply = Reply()
    var post: Post?

    @IBOutlet weak var postComment: UIButton!
    
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        if identifier == "showComment" {
            // perform your computation to determine whether segue should occur
            
            if count(self.commentView.text) == 0 {
                let notPermitted = UIAlertView(title: "Alert", message: "Please enter a comment", delegate: nil, cancelButtonTitle: "OK")
                
                // shows alert to user
                notPermitted.show()
                
                // prevent segue from occurring
                return false
            }
        }
        
        // by default perform the segue transitio
        createReply()
        return true
    }

    

//    @IBAction func postNewComment(sender: AnyObject) {
//        // self.performSegueWithIdentifier("showComment", sender: self)
//        //comment.post = post
//            createReply()
//        
//        
//    }
    
    @IBOutlet weak var charLeft: UILabel!
    @IBOutlet weak var commentView: UITextView!
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        commentView.delegate = self
        commentView.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        var newLength:Int = (textView.text as NSString).length + (text as NSString).length - range.length
        var remainingChar:Int = 200 - newLength
        
        charLeft.text = "\(remainingChar)"
        
        return (newLength > 200) ? false : true
        
    }
    
    func createReply(){
        reply.replyContent = commentView.text
        reply.date = NSDate()
        reply.post = post
    
        
        reply.save()
        reply.uploadReply()
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
