//
//  ParseHelper.swift
//  TemplateProject
//
//  Created by Riya Berry on 8/2/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import Foundation
import Parse

class ParseHelper {

    // Like Relation
    static let ParseEchoClass         = "Echo"
    static let ParseEchoToPost        = "toPost"
    static let ParseEchoFromUser      = "fromUser"
    
    // Post Relation
    static let ParsePostUser          = "user"
    static let ParsePostCreatedAt     = "createdAt"
    
    // Flagged Content Relation
    static let ParseFlaggedContentClass    = "FlaggedContent"
    static let ParseFlaggedContentFromUser = "fromUser"
    static let ParseFlaggedContentToPost   = "toPost"
    
    static let ParseFlaggedContentToReply = "toReply"
    
    
    // User Relation
    static let ParseUserUsername      = "username"
    
    // MARK: Timeline
    
    static func timelineRequestforCurrentUser(range: Range<Int>, completionBlock: PFArrayResultBlock) {
        
        let postsFromAllUsers = Post.query()
        
//        let postsFromThisUser = Post.query()
//        postsFromThisUser!.whereKey(ParsePostUser, equalTo: PFUser.currentUser()!)
        
        // let query = PFQuery([postsFromAllUsers])
        postsFromAllUsers!.includeKey(ParsePostUser)
        postsFromAllUsers!.orderByDescending(ParsePostCreatedAt)
        
        postsFromAllUsers!.skip = range.startIndex
        postsFromAllUsers!.limit = range.endIndex - range.startIndex
        
        postsFromAllUsers!.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
    // MARK: Likes
    
    static func echoPost(user: PFUser, post: Post) {
        let echoObject = PFObject(className: ParseEchoClass)
        echoObject.setObject(user, forKey: ParseEchoFromUser)
        echoObject.setObject(post, forKey: ParseEchoToPost)
        
        echoObject.saveInBackgroundWithBlock(ErrorHandling.errorHandlingCallback)
    }
    
    static func unechoPost(user: PFUser, post: Post) {
        let query = PFQuery(className: ParseEchoClass)
        query.whereKey(ParseEchoFromUser, equalTo: user)
        query.whereKey(ParseEchoToPost, equalTo: post)
        
        query.findObjectsInBackgroundWithBlock {
            (results: [AnyObject]?, error: NSError?) -> Void in
            if let error = error {
                ErrorHandling.defaultErrorHandler(error)
            }
            
            if let results = results as? [PFObject] {
                for echoes in results {
                    echoes.deleteInBackgroundWithBlock(ErrorHandling.errorHandlingCallback)
                }
            }
        }
    }
    
        static func echoesForPost(post: Post, completionBlock: PFArrayResultBlock) {
            let query = PFQuery(className: ParseEchoClass)
            query.whereKey(ParseEchoToPost, equalTo: post)
            query.includeKey(ParseEchoFromUser)
            
            query.findObjectsInBackgroundWithBlock(completionBlock)
        }
    
    //MARK: Flagging
    
    static func flagPost(user: PFUser, post: Post) {
        let flagObject = PFObject(className: ParseFlaggedContentClass)
        flagObject.setObject(user, forKey: ParseFlaggedContentFromUser)
        flagObject.setObject(post, forKey: ParseFlaggedContentToPost)
        
        let ACL = PFACL(user: PFUser.currentUser()!)
        ACL.setPublicReadAccess(true)
        flagObject.ACL = ACL
        
        //TODO: add error handling
        flagObject.saveInBackgroundWithBlock(ErrorHandling.errorHandlingCallback)
    }
    
    static func flagReply(user: PFUser, reply: Reply) {
        let flagObject = PFObject(className: ParseFlaggedContentClass)
        flagObject.setObject(user, forKey: ParseFlaggedContentFromUser)
        flagObject.setObject(reply, forKey: ParseFlaggedContentToReply)
        
        let ACL = PFACL(user: PFUser.currentUser()!)
        ACL.setPublicReadAccess(true)
        flagObject.ACL = ACL
        
        //TODO: add error handling
        flagObject.saveInBackgroundWithBlock(ErrorHandling.errorHandlingCallback)
    }

    
    // MARK: Following
    
    /**
    Fetches all users that the provided user is following.
    
    :param: user The user who's followees you want to retrive
    :param: completionBlock The completion block that is called when the query completes
    */
    
    /**
    Establishes a follow relationship between two users.
    
    :param: user    The user that is following
    :param: toUser  The user that is being followed
    */
        /**
    Deletes a follow relationship between two users.
    
    :param: user    The user that is following
    :param: toUser  The user that is being followed
    */
    
    // MARK: Users
    
    /**
    Fetch all users, except the one that's currently signed in.
    Limits the amount of users returned to 20.
    
    :param: completionBlock The completion block that is called when the query completes
    
    :returns: The generated PFQuery
    */
    static func allUsers(completionBlock:PFArrayResultBlock) -> PFQuery {
        let query = PFUser.query()!
        // exclude the current user
        query.whereKey(ParseHelper.ParseUserUsername,
            notEqualTo: PFUser.currentUser()!.username!)
        query.orderByAscending(ParseHelper.ParseUserUsername)
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
        
        return query
    }
    
    /**
    Fetch users who's username matches the provided search term.
    
    :param: searchText The text that should be used to search for users
    :param: completionBlock The completion block that is called when the query completes
    
    :returns: The generated PFQuery
    */
    static func searchUsers(searchText: String, completionBlock: PFArrayResultBlock)
        -> PFQuery {
            /*
            NOTE: We are using a Regex to allow for a case insensetive compare of usernames.
            Regex can be slow on large datasets. For large amount of data it's better to store
            lowercased username in a separate column and perform a regular string compare.
            */
            let query = PFUser.query()!.whereKey(ParseHelper.ParseUserUsername,
                matchesRegex: searchText, modifiers: "i")
            
            query.whereKey(ParseHelper.ParseUserUsername,
                notEqualTo: PFUser.currentUser()!.username!)
            
            query.orderByAscending(ParseHelper.ParseUserUsername)
            query.limit = 20
            
            query.findObjectsInBackgroundWithBlock(completionBlock)
            
            return query
    }
    
    
}

extension PFObject : Equatable {
    
}

public func ==(lhs: PFObject, rhs: PFObject) -> Bool {
    return lhs.objectId == rhs.objectId
}