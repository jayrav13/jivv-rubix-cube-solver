//
//  ImageList.swift
//  JIVV-Rubix-Cube-Solver
//
//  Created by Jay Ravaliya on 9/26/15.
//  Copyright © 2015 JRav. All rights reserved.
//

import UIKit
import GPUImage

class ImageList : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // var test : GPUImagePicture = GPUImagePicture
    
    var tableView : UITableView!
    
    var dismissVC : UIBarButtonItem!
    var submit : UIBarButtonItem!
    
    var images : [UIImageView] = []
    var sides : [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        print(sides.count)
        
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
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")!
        
        cell.textLabel?.text = sides[indexPath.row].text
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let ip : ImageProcessing = ImageProcessing()
        ip.image = images[indexPath.row].image
        self.navigationController?.pushViewController(ip, animated: true)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func editImages(sender: UIButton!) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
    
    func solve(sender: UIButton!) {
        var doneFlag : Int = 0
        
        for x in 0...self.sides.count - 1 {
            if self.sides[x].text == "<select side>" {
                doneFlag = 1
                break
            }
        }
        
        if doneFlag == 0 {
            
        }
        
    }
    
}