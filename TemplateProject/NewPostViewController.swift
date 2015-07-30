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
    
    @IBOutlet weak var postView: UITextView!
    
    @IBOutlet weak var characterCount: UILabel!

    
    @IBAction func postPressed(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        post.Post = postView.text
        
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
