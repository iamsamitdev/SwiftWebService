//
//  PersonalViewController.swift
//  SwiftWebService
//
//  Created by Samit Koyom on 15/1/59.
//  Copyright © พ.ศ. 2559 Samit Koyom. All rights reserved.
//

import UIKit

class PersonalViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var mTableView: UITableView!
    var mDataArray:NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        let urlPath:String = "http://localhost/swiftwebapi/personal.php"
        let url:NSURL = NSURL(string: urlPath)!
        let request:NSURLRequest = NSURLRequest(URL:url)
        
        // Background thread
        let queue:NSOperationQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue) {
            (response:NSURLResponse?, data:NSData?,error:NSError?) -> Void in
            let tmp = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            // parsing json
            self.mDataArray = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as! NSArray
            
            // Main thread
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.mTableView.reloadData() // call in main thread only
            })
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:CustomTableViewCell = tableView.dequeueReusableCellWithIdentifier("custom_cell") as! CustomTableViewCell
        
        let item:NSDictionary = self.mDataArray.objectAtIndex(indexPath.row) as! NSDictionary
        
        // เติมข้อมูลเข้าใน Cell
        cell.mFullname.text = item.objectForKey("firstname") as! String
        cell.mEmail.text = item.objectForKey("email") as! String
        cell.mTel.text = item.objectForKey("mobile_number") as! String
        
        let _picProfile = item.objectForKey("pic_profile") as! String
        let _picUrl = "http://localhost/swiftwebapi/pic_profile/\(_picProfile)"
        
        print(_picProfile)
        print(_picUrl)
        
        
        ImageLoader.sharedLoader.imageForUrl(_picUrl, completionHandler: {(image:UIImage?,url:String) in cell.mPersonImage.image = image})
        
        return cell
    }
    

}
