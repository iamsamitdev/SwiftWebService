//
//  ViewController.swift
//  SwiftWebService
//
//  Created by Samit Koyom on 14/1/59.
//  Copyright © พ.ศ. 2559 Samit Koyom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // เมื่อปิดหน้าจอ ให้ออกจากระบบ
    override func viewDidDisappear(animated: Bool) {
        self.performSegueWithIdentifier("goto_login", sender: self)
    }

    @IBAction func logoutTapped(sender: UIButton) {
        self.performSegueWithIdentifier("goto_login", sender: self)
    }

}

