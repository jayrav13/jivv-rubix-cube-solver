//
//  SelectSide.swift
//  JIVV-Rubix-Cube-Solver
//
//  Created by Jay Ravaliya on 9/26/15.
//  Copyright © 2015 JRav. All rights reserved.
//

import UIKit

protocol SelectSideDelegate {
    func controller(controller: SelectSide, selectedElement : String)
}

class SelectSide : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView!
    var sides = ["Top", "Bottom", "Left", "Right", "Front", "Back"]
    
    var dismiss : UIBarButtonItem!
    
    var delegate : SelectSideDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Select Side"
        
        dismiss = UIBarButtonItem(title: "Dismiss", style: UIBarButtonItemStyle.Plain, target: self, action: "dismissVC:")
        self.navigationItem.rightBarButtonItem = dismiss
        
        tableView = UITableView(frame: self.view.frame)
        
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
        cell.textLabel!.text = sides[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let delegate = self.delegate {
            delegate.controller(self, selectedElement: sides[indexPath.row])
        }
        else {
            delegate?.controller(self, selectedElement: "Something went wrong!")
        }
        
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func dismissVC(sender: UIButton!) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    
    
}
