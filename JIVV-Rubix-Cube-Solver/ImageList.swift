//
//  ImageList.swift
//  JIVV-Rubix-Cube-Solver
//
//  Created by Jay Ravaliya on 9/26/15.
//  Copyright © 2015 JRav. All rights reserved.
//

import UIKit

class ImageList : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView!
    
    var dismissVC : UIBarButtonItem!
    var submit : UIBarButtonItem!
    
    var images : [UIImage] = []
    var sides : [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.title = "Images"
        
        dismissVC = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: "editImages:")
        self.navigationItem.leftBarButtonItem = dismissVC
        
        submit = UIBarButtonItem(title: "Solve", style: UIBarButtonItemStyle.Plain, target: self, action: "solve:")
        self.navigationItem.rightBarButtonItem = submit
        
        tableView = UITableView(frame: view.frame)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")!
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func editImages(sender: UIButton!) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    func solve(sender: UIButton!) {
        print("Solving...")
    }
    
}