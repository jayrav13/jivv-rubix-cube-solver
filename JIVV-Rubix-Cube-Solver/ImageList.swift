//
//  ImageList.swift
//  JIVV-Rubix-Cube-Solver
//
//  Created by Jay Ravaliya on 9/26/15.
//  Copyright © 2015 JRav. All rights reserved.
//

import UIKit
import GPUImage
import Foundation
import Darwin

//On the top of your swift - found on StackOverflow
extension UIImage {
    func getPixelColor(pos: CGPoint) -> UIColor {
        let pixelData = CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage))
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

class ImageList : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView!
    
    var dismissVC : UIBarButtonItem!
    var submit : UIBarButtonItem!
    
    var images : [UIImageView] = []
    var sides : [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        for x in 0...images.count - 1 {
            print(sides[x].text)
            findEdges(images[x].image!)
        }
        
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
        
        cell.imageView?.image = images[indexPath.row].image
        
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
    
    // processed image
    func findEdges(image : UIImage) {
        
        var newSize : CGSize = CGSizeMake(244, 244.0)
        UIGraphicsBeginImageContext(newSize)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        var image : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let imageWidth = Int(image.size.width)
        let imageHeight = Int(image.size.height)
        
        var matrix : [[Double]] = [[0.0, 0.0, 0.0, 0.0, 0.0, 0.0]]
        var counts : [[Int]] = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
        
        for x in 1...imageHeight {
            for y in 1...imageWidth {
                var horQuad = floor(Double(x / (imageWidth / 3)))
                var verQuad = floor(Double(y / (imageHeight / 3)))
                
                if horQuad == 3.0 {
                    horQuad = horQuad - 1
                }
                
                if verQuad == 3.0 {
                    verQuad = verQuad - 1
                }
                
                let color : UIColor = image.getPixelColor(CGPoint(x: x, y: y))
                
                var r : CGFloat = 0
                var g : CGFloat = 0
                var b : CGFloat = 0
                var a : CGFloat = 0
                
                if color.getRed(&r, green: &g, blue: &b, alpha: &a) {
                    matrix.append([Double(r), Double(g), Double(b), Double(a), Double(horQuad), Double(verQuad)])
                    counts[Int(horQuad)][Int(verQuad)] += 1
                }
            }
        }
        
        var averages : [[[Double]]] = [[[0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0]], [[0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0]], [[0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0]]]
        
        for elem in matrix {
            for x in 0...3 {
                averages[Int(elem[4])][Int(elem[5])][x] += elem[x]
            }
        }
        
        for x in 0...2 {
            for y in 0...2 {
                for z in 0...3 {
                    averages[x][y][z] = averages[x][y][z] / Double(counts[x][y])
                }
                print(averages[x][y])
            }
        }
        
        for elem in averages {
            
        }
        
    }
    
}