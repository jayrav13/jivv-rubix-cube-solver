//
//  Solution.swift
//  JIVV-Rubix-Cube-Solver
//
//  Created by Jay Ravaliya on 9/27/15.
//  Copyright © 2015 JRav. All rights reserved.
//

import UIKit
import SwiftyJSON

class Solution : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView!
    var response : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Solution!"
        
        tableView = UITableView(frame: self.view.frame)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        cell.textLabel?.text = response[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response.count
        
    }
    
}
