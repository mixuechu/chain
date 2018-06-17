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
    var completionHandler2: AWSS3TransferUtilityDownloadCompletionHandlerBlock?
    var progressBlock: AWSS3TransferUtilityProgressBlock?
   var progressBlock2: AWSS3TransferUtilityProgressBlock?
    let imagePicker = UIImagePickerController()
    let transferUtility = AWSS3TransferUtility.default()
    //let transferUtility = AWSS3TransferUtility.s3TransferUtility(forKey: "USEast1S3TransferUtility")
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
     //   print((type(of: self.transferUtility)))
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
    
    @IBOutlet weak var ownner_profilepicture: UIImageView!
    
    
    @IBAction func info_update(_ sender: UIButton) {
        let pp:UserPool = UserPool()
        pp.update(name_:nameinput.text!,career_:careerinput.text!,gender_:genderinput.text!)
            pp.read()
    }
    
    @IBAction func upload(_ sender: UIButton) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        //self.download(key_: (AWSCognitoUserPoolsSignInProvider.sharedInstance().getUserPool().currentUser()?.username)!)
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    
    func uploadImage(with data: Data) {
        let expression = AWSS3TransferUtilityUploadExpression()
        expression.progressBlock = progressBlock
        
        transferUtility.uploadData(
            data,
            bucket: "chance-userfiles-mobilehub-653619147",
            key:("download.png"),
            //key: (AWSCognitoUserPoolsSignInProvider.sharedInstance().getUserPool().currentUser()?.username)!,
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
    
    
    
    
    func download(key_:String){
        print("hola")
        //let data: Data = Data()
        let expression = AWSS3TransferUtilityDownloadExpression()
        expression.progressBlock = {(task, progress) in
            DispatchQueue.main.async(execute: {
                print("166")
            })
        }

        print("163")
        self.completionHandler2 = { (task, url, data, error) -> Void in
            DispatchQueue.main.async(execute: {
                print("166")
                if let error = error {
                    NSLog("Failed with error: \(error)")
                   // self.statusLabel.text = "Failed"
                   // triggered 9:01
                    print("failed: 169: \(error)")
                }
                else{
                   // self.statusLabel.text = "Success"
                    print("successed: 174")
                    self.ownner_profilepicture.image = UIImage(data: data!)
                }
            })
        }
        print("181")// 1. keep the register and try upload to make sure it works; 2. if it does, add progress sign to it, to see if its about the download speed. 3. if not, hehehehehe
        print(key_)
        transferUtility.downloadData(
            fromBucket: "chance-userfiles-mobilehub-653619147",
            key: key_,
            expression: expression,
            completionHandler: completionHandler2).continueWith { (task) -> AnyObject! in
                print("193")
                if let error = task.error {
                    NSLog("Error: %@",error.localizedDescription);
                   // self.statusLabel.text = "Failed"
                    print("failed 191")
                }
                
                if let _ = task.result {
                    //self.statusLabel.text = "Starting Download"
                    NSLog("Download Starting!"); print("successed 196")
                    // Do something with uploadTask.
                }
                return nil;
        }
        print("201")
        
    }

}




@objc extension loginVC {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if "public.image" == info[UIImagePickerControllerMediaType] as? String {
            print("in")
            let image: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            self.uploadImage(with: UIImagePNGRepresentation(image)!)
            self.download(key_: "download.png")
            //self.download(key_: (AWSCognitoUserPoolsSignInProvider.sharedInstance().getUserPool().currentUser()?.username)!)
            //self.ownner_profilepicture.image = image
        }
        
        
        dismiss(animated: true, completion: nil)
}
}


