//
//  Post.swift
//  TemplateProject
//
//  Created by Riya Berry on 7/29/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Foundation
import Bond
import Parse
import ConvenienceKit

class Post: PFObject, PFSubclassing {
    @NSManaged var postContent: String?
    @NSManaged var user: PFUser?
    @NSManaged var date: NSDate
    @NSManaged var replyCount: NSNumber
    
    
    var echoes =  Dynamic<[PFUser]?>(nil)
    
    
    // let theUser = PFUser(className: "Riya")
    // let thePost = Post(postContent: "hi")
    
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
    func fetchEchoes() {
        // 1
        if (echoes.value != nil) {
            return
        }
        
        // 2
        ParseHelper.echoesForPost(self, completionBlock: { (var echoes: [AnyObject]?, error: NSError?) -> Void in
            // 3
            echoes = echoes?.filter { echo in echo[ParseHelper.ParseEchoFromUser] != nil }
            
            // 4
            self.echoes.value = echoes?.map { echo in
                let echo = echo as! PFObject
                let fromUser = echo[ParseHelper.ParseEchoFromUser] as! PFUser
                
                return fromUser
            }
        })
    }


    func doesUserEchoPost(user: PFUser) -> Bool {
        if let echoes = echoes.value {
            return contains(echoes, user)
        } else {
            return false
        }
    }

    
    func toggleEchoPost(user: PFUser) {
        if (doesUserEchoPost(user)) {
            // if image is liked, unlike it now
            // 1
            echoes.value = echoes.value?.filter { $0 != user }
            ParseHelper.unechoPost(user, post: self)
        } else {
            // if this image is not liked yet, like it now
            // 2
            echoes.value?.append(user)
            ParseHelper.echoPost(user, post: self)
        }
    }
    
    func flagPost(user: PFUser) {
        ParseHelper.flagPost(user, post: self)
    }

    
}
