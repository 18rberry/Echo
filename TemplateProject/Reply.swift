//
//  Reply.swift
//  TemplateProject
//
//  Created by Riya Berry on 8/5/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Foundation
import Bond
import Parse
import ConvenienceKit

class Reply: PFObject, PFSubclassing  {
    @NSManaged var replyContent: String?
    @NSManaged var date: NSDate?
    @NSManaged var user: PFUser?
    @NSManaged var post: PFObject?
    
    static func parseClassName() -> String {
        return "Replies"
    }
    
    override init () {
        super.init()
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
    
    func uploadReply() {
        //post = PFObject.currentPost()
        user = PFUser.currentUser()
        
        saveInBackgroundWithBlock(nil)
        
    }

    
    func flagReply(user: PFUser) {
        ParseHelper.flagReply(user, reply: self)
    }
    
    

}

