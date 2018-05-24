//
//  profile_picture.swift
//  chain
//
//  Created by xuechuan mi on 2018-05-24.
//  Copyright © 2018 Chao Shen. All rights reserved.
//

import Foundation
import AWSDynamoDB
import AWSAuthUI
import AWSAuthCore
import AWSMobileClient
import AWSUserPoolsSignIn

import Foundation
import UIKit
import AWSDynamoDB
@objcMembers
class ProfilePicture: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    var _userId: String?
    var _set: String?
    
    class func dynamoDBTableName() -> String {
        
        return "chance-mobilehub-653619147-profile_picture"
    }
    
    class func hashKeyAttribute() -> String {
        
        return "_userId"
    }
    
    override class func jsonKeyPathsByPropertyKey() -> [AnyHashable: Any] {
        return [
            "_userId" : "userId",
            "_set" : "set",
        ]
    }


    
    func createProfilePicture() {
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        
        // Create data object using data models you downloaded from Mobile Hub
        let newsItem: ProfilePicture = ProfilePicture()
        let username: String? = AWSCognitoUserPoolsSignInProvider.sharedInstance().getUserPool().currentUser()?.username
        let un: String = username!
        print (un)
        newsItem._userId = un
        newsItem._set = "yes"
        
        //Save a new item
        dynamoDbObjectMapper.save(newsItem, completionHandler: {
            (error: Error?) -> Void in
            
            if let error = error {
                print("Amazon DynamoDB Save Error: \(error)")
                return
            }
            print("An item was saved.")
        })
    }
}
