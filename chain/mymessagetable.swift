//
//  mymessagetable.swift
//  chain
//
//  Created by Chao Shen on 2018/5/19.
//  Copyright © 2018年 Chao Shen. All rights reserved.
//

import Foundation
import UIKit
class mymessagetable:UITableViewController{
    let datainfo=["Mary","hgvfctdfghgv"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return datainfo.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cuscell=tableView.dequeueReusableCell(withIdentifier:"cell")as!customercell
    cuscell.celllabel.text=datainfo[indexPath.row]
    cuscell.backgroundColor=UIColor.white
    return cuscell
    }
}
