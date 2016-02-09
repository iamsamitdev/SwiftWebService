//
//  HomeVC.swift
//  SwiftWebService
//
//  Created by Samit Koyom on 14/1/59.
//  Copyright © พ.ศ. 2559 Samit Koyom. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        // รับค่าตัวแปรจากหน้า login
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        
        // ถ้าไม่พบ ตัวแปร ส่งมาจากหน้า login ให้ทำการ login ก่อน
        if(isLoggedIn != 1)
        {
            // ส่งไปหน้า login
            self.performSegueWithIdentifier("goto_login", sender: self)
        }else{
            // แสดง username ที่หน้า home
            self.usernameLabel.text = prefs.valueForKey("USERNAME") as? String
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // คำสั่งเมื่อกดปุ่ม logout
    @IBAction func logoutTapped(sender: UIButton) {
        
        // เคลียร์ค่าตัวแปร session ออก
        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        
        self.performSegueWithIdentifier("goto_login", sender: self)
    }

}
