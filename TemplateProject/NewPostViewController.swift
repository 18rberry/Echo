//
//  NewPostViewController.swift
//  TemplateProject
//
//  Created by Riya Berry on 7/19/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController, UITextViewDelegate {

    //let post = Post()
//    var post: Post? {
//        didSet {
//            displayPost(post)
//        }
//        }

    let post = Post()
    
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var postView: UITextView!
    
    
    @IBOutlet weak var charRemaining: UILabel!

    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        if identifier == "addPost" {
            // perform your computation to determine whether segue should occur
            
            if count(self.postView.text) == 0 {
                let notPermitted = UIAlertView(title: "Alert", message: "Please enter a post", delegate: nil, cancelButtonTitle: "OK")
                
                // shows alert to user
                notPermitted.show()
                
                // prevent segue from occurring
                return false
            }
        }
        
        // by default perform the segue transitio
        createPost()
        return true
    }
    
//    @IBAction func postPressed(sender: AnyObject) {
//        if count(self.postView.text) < 1 {
//            postButton.enabled = !postView.text.isEmpty
//            postButton.enabled = false
//            
//            var alert = UIAlertView(title: "Invalid", message: "Please enter something", delegate: self, cancelButtonTitle: "OK")
//            alert.show()
//            
//        }
//        
//        else {
//        self.performSegueWithIdentifier("addPost", sender: self)
//        createPost()
//        }
//    
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postView.delegate = self
        postView.becomeFirstResponder()
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    
//    override func viewWillAppear(animated: Bool) {
//        displayPost(post)
//    }
//    
//    func displayPost(post: Post?) {
//        if let post = post, postView = postView {
//            postView.text = post.yakText
//            
//            if count(postView.text) == 0 {
//                postView.becomeFirstResponder()
//            }
//            
//        }
//    }
    
    func createPost(){
        post.postContent = postView.text
        post.date = NSDate()
        
        post.save()
        post.uploadPost()
    }
    
    func DismissKeyboard() {
        view.endEditing(true)
    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        var newLength:Int = (textView.text as NSString).length + (text as NSString).length - range.length
        var remainingChar:Int = 300 - newLength
        
        charRemaining.text = "\(remainingChar)"
        
        return (newLength > 300) ? false : true

    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "addPost" {
//            var destination = segue.destinationViewController as! TimelineViewController
//            postView.text = destination.postContent
//        }
//    }
//
//}
}