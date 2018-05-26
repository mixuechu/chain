//
//  infoViewController.swift
//  chain
//
//  Created by xuechuan mi on 2018-05-25.
//  Copyright © 2018 Chao Shen. All rights reserved.
//

import UIKit

class infoViewController: UIViewController {
    @IBOutlet weak var nicknameoutput: UILabel!
    
    @IBOutlet weak var genderoutput: UILabel!
    
    @IBOutlet weak var occupationoutput: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nicknameoutput.text = name
        genderoutput.text = gender
        occupationoutput.text = career
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
