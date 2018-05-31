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
import AWSS3


class loginVC: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    var completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
    var progressBlock: AWSS3TransferUtilityProgressBlock?
    
    let imagePicker = UIImagePickerController()
    let transferUtility = AWSS3TransferUtility.default()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        
        self.completionHandler = { (task, error) -> Void in
            DispatchQueue.main.async(execute: {
                if let error = error {
                    print("Failed with error: \(error)")
                   // self.statusLabel.text = "Failed"
                }
                
            })
        }
        
        
        
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
    
    @IBAction func upload(_ sender: UIButton) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
    
    func uploadImage(with data: Data) {
        let expression = AWSS3TransferUtilityUploadExpression()
        expression.progressBlock = progressBlock
        
        transferUtility.uploadData(
            data,
            bucket: "chance-userfiles-mobilehub-653619147",
            key: (AWSCognitoUserPoolsSignInProvider.sharedInstance().getUserPool().currentUser()?.username)!,
            contentType: "image/png",
            expression: expression,
            completionHandler: completionHandler).continueWith { (task) -> AnyObject! in
                if let error = task.error {
                    print("Error: \(error.localizedDescription)")
                    
                    DispatchQueue.main.async {
                     //   self.statusLabel.text = "Failed"
                    }
                }
                
                if let _ = task.result {
                    
                    DispatchQueue.main.async {
                  //      self.statusLabel.text = "Generating Upload File"
                        print("Upload Starting!")
                    }
                    
                    // Do something with uploadTask.
                }
                
                return nil;
        }
    }

    
    @IBOutlet weak var ownner_profilepicture: UIImageView!
    
    
    
    
    
    
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




@objc extension loginVC {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if "public.image" == info[UIImagePickerControllerMediaType] as? String {
            print("in")
            let image: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            self.uploadImage(with: UIImagePNGRepresentation(image)!)
            self.ownner_profilepicture.image = image
        }
        
        
        dismiss(animated: true, completion: nil)
}
}
