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
    
    @IBOutlet weak var career: UITextField!
    
    @IBOutlet weak var gender: UITextField!
    
    @IBOutlet weak var name: UITextField!
    
    @IBAction func MyInfo_make_sure(_ sender: UIButton) {
        
        
        
    }
    
    
    @IBAction func logout(_ sender: UIButton) {
        print (AWSCognitoUserPoolsSignInProvider.sharedInstance().getUserPool().currentUser()?.username
        )
        let pp:UserPool = UserPool()
        pp.read()
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
                    let pp:UserPool = UserPool()
                    pp.createProfilePicture()
                    print (AWSCognitoUserPoolsSignInProvider.sharedInstance().getUserPool().currentUser()?.username
                    )
                    
                    
                    
                } else {
                    // end user faced error while loggin in, take any required action here.
                }
        })
    }
}
