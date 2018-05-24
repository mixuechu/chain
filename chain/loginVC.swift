//
//  ViewController.swift
//  chain
//
//  Created by Chao Shen on 2018/5/18.
//  Copyright © 2018年 Chao Shen. All rights reserved.
//

import UIKit
import AWSAuthUI
import AWSAuthCore
import AWSMobileClient
import AWSUserPoolsSignIn



class loginVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !AWSSignInManager.sharedInstance().isLoggedIn {
            presentAuthUIViewController()
        }
    }
    
   
    @IBAction func logout(_ sender: UIButton) {
        print (AWSCognitoUserPoolsSignInProvider.sharedInstance().getUserPool().currentUser()?.username
        )
        AWSSignInManager.sharedInstance().logout(completionHandler: {(result: Any?, error: Error?) in
        })
    }
    
    func presentAuthUIViewController() {
        let config = AWSAuthUIConfiguration()
        config.enableUserPoolsUI = true

        config.backgroundColor = UIColor.blue
        config.font = UIFont (name: "Helvetica Neue", size: 20)
        config.isBackgroundColorFullScreen = true
        config.canCancel = true
        
        AWSAuthUIViewController.presentViewController(
            with: self.navigationController!,
            configuration: config, completionHandler: { (provider: AWSSignInProvider, error: Error?) in
                if error == nil {
                    // SignIn succeeded.
                      print("sign in successfully")
                    let pp:ProfilePicture = ProfilePicture()
                    pp.createProfilePicture()
                    print (AWSCognitoUserPoolsSignInProvider.sharedInstance().getUserPool().currentUser()?.username
                    )
                    
                    
                    
                } else {
                    // end user faced error while loggin in, take any required action here.
                }
        })
    }
}
