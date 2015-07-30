//
//  Post.swift
//  TemplateProject
//
//  Created by Riya Berry on 7/29/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse

class Post: PFObject, PFSubclassing {
    @NSManaged var Post: String?
    @NSManaged var user: PFUser?
    
    static func parseClassName() -> String {
        return "Post"
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

    
    func uploadPost() {
        // let imageFile = PFFile(
        //imageFile.saveInBackgroundWithBlock(nil)
        
        // any uploaded post should be associated with the current user
        user = PFUser.currentUser()
        //self.imageFile = imageFile
        saveInBackgroundWithBlock(nil)
    }
    
}
