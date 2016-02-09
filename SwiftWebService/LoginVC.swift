//
//  LoginVC.swift
//  SwiftWebService
//
//  Created by Samit Koyom on 14/1/59.
//  Copyright © พ.ศ. 2559 Samit Koyom. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signinTapped(sender: UIButton) {
        let username:NSString = txtUsername.text!
        let password:NSString = txtPassword.text!
        
        // เช็คว่ากรอกข้อมูลครบหรือไม่
        if(username.isEqualToString("") || password.isEqualToString(""))
        {
            // แสดง Alert เตือน
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Fail"
            alertView.message = "Please enter Username and Password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }else{
            // ทำการเช็คข้อมูล user ในฐานข้อมูล
            do{
                let post:NSString = "username=\(username)&password=\(password)"
                NSLog("PostData: %@", post)
                
                let url:NSURL = NSURL(string: "http://localhost/swiftwebapi/loginservice.php")!
                let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
                let postLength:NSString = String(post.length)
                let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
                
                // กำหนดรูปแบบการส่งข้อมูล
                request.HTTPMethod = "POST"
                request.HTTPBody = postData
                
                // แปลงและส่งเป็น JSON Format
                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
                request.setValue("application/json", forHTTPHeaderField:"Accept")
                
                // สร้างชุดตัวแปรเก็บข้อมูล error
                var responseError:NSError?
                var response:NSURLResponse?
                var urlData: NSData?
                
                // เช็คข้อมูลตัวแปร urlData ว่ามีค่าส่งมาหรือไม่
                do{
                    urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
                }catch let error as NSError{
                    responseError = error
                    urlData = nil
                }
                
                // ทดสอบแสดง ข้อมูล url
                if(urlData != nil){
                    let res = response as! NSHTTPURLResponse
                    NSLog("Response code: %ld", res.statusCode)
                    
                    // กรณีทีีเชื่อมต่อ web api ได้
                    if(res.statusCode == 200)
                    {
                        let responseData:NSString = NSString(data:urlData!, encoding: NSUTF8StringEncoding)!
                        NSLog("Response ==> %@", responseData)
                        
                        // สร้างตัวแปรรับค่าจาก response ที่เป็น json
                        let jsonData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(urlData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                        
                        // แยกข้อมูลจาก JSON
                        let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
                        
                        // ตรวจสอบว่าสถานะ success เป็น 1 หรือไม่
                        if(success == 1)
                        {
                            // กำหนดตัวแปรไว้เช็คที่หน้า home
                            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                            
                            prefs.setObject(username, forKey: "USERNAME")
                            prefs.setInteger(1, forKey: "ISLOGGEDIN");
                            prefs.synchronize()
                            
                            // ส่งไปหน้า Home
                            self.dismissViewControllerAnimated(true, completion: nil)
                        }else{
                            // แจ้ง Alert เตือนว่ากรอกข้อมูลไม่ถูกต้อง
                            let alertView:UIAlertView = UIAlertView()
                            alertView.title = "Sign in Failed!"
                            alertView.message = "ข้อมูลเข้าระบบไม่ถูกต้อง"
                            alertView.delegate = self
                            alertView.addButtonWithTitle("OK")
                            alertView.show()
                        }
                    }
                }

                
            }catch{
                // แสดง Alert เตือน
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign in Fail"
                alertView.message = "Server Error"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
        }
    }

    

}
