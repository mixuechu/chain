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
class UserPool: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    var _userId: String?
    var _career: String? = "Empty"
    var _chanceId: String?
    var _gender: String?
    var _nickName: String?
    var _resume: String?
    var _walletAddress: String?
    
    class func dynamoDBTableName() -> String {
        
        return "chance-mobilehub-653619147-UserPool"
    }
    
    class func hashKeyAttribute() -> String {
        
        return "_userId"
    }
    
    override class func jsonKeyPathsByPropertyKey() -> [AnyHashable: Any] {
        return [
            "_userId" : "userId",
            "_career" : "Career",
            "_chanceId" : "ChanceId",
            "_gender" : "Gender",
            "_nickName" : "NickName",
            "_resume" : "Resume",
            "_walletAddress" : "WalletAddress",
        ]
    }


    
    func createProfilePicture() {
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        
        // Create data object using data models you downloaded from Mobile Hub
        let newsItem: UserPool = UserPool()
        let username: String? = AWSCognitoUserPoolsSignInProvider.sharedInstance().getUserPool().currentUser()?.username
        let un: String = username!
        print (un)
        newsItem._userId = un
        newsItem._career = "Doctor"
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
    
    func update_career(career:String) {
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        
        // Create data object using data models you downloaded from Mobile Hub
        let newsItem: UserPool = UserPool()
        let username: String? = AWSCognitoUserPoolsSignInProvider.sharedInstance().getUserPool().currentUser()?.username
        let un: String = username!
        print (un)
        newsItem._userId = un
        newsItem._career = "Doctor"
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
    
    func update_gender(gender:String) {
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        
        // Create data object using data models you downloaded from Mobile Hub
        let newsItem: UserPool = UserPool()
        let username: String? = AWSCognitoUserPoolsSignInProvider.sharedInstance().getUserPool().currentUser()?.username
        let un: String = username!
        print (un)
        newsItem._userId = un
        newsItem._career = "Doctor"
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
    
    func update_name(name:String) {
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        
        // Create data object using data models you downloaded from Mobile Hub
        let newsItem: UserPool = UserPool()
        let username: String? = AWSCognitoUserPoolsSignInProvider.sharedInstance().getUserPool().currentUser()?.username
        let un: String = username!
        print (un)
        newsItem._userId = un
        newsItem._career = "Doctor"
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
    
    
    
    
    
    
    func read() {
        
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        let username: String? = AWSCognitoUserPoolsSignInProvider.sharedInstance().getUserPool().currentUser()?.username
        
        dynamoDbObjectMapper.load(UserPool.self, hashKey: username, rangeKey: "", completionHandler: { (objectModel: AWSDynamoDBObjectModel?, error: Error?) -> Void in
            if let error = error {
                print("Amazon DynamoDB Read Error: \(error)")
                return
            }
            print("An item was read.")
            
            DispatchQueue.main.async {
                print(objectModel?.dictionaryValue["_career"] as? String)
            }

        })
    }
    
    
}
