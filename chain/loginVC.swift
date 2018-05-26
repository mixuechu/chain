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
    
    @IBOutlet weak var careerinput: UITextField!
   
    @IBOutlet weak var nameinput: UITextField!
    
    @IBOutlet weak var genderinput: UITextField!
    
    
    @IBAction func info_update(_ sender: UIButton) {
        let pp:UserPool = UserPool()
        pp.update(name_:nameinput.text!,career_:careerinput.text!,gender_:genderinput.text!)
            pp.read()
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
