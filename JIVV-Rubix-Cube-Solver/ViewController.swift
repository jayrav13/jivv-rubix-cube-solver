//
//  ViewController.swift
//  JIVV-Rubix-Cube-Solver
//
//  Created by Jay Ravaliya on 9/26/15.
//  Copyright © 2015 JRav. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, SelectSideDelegate {

    var scrollView : UIScrollView!
    var pageControl : UIPageControl!
    
    var next : UIButton!
    var previous : UIButton!
    var takePicture : UIButton!
    
    var views : [UIImageView] = []
    
    var imagePicker : UIImagePickerController!
    
    var images : [UIImage] = [UIImage(), UIImage(), UIImage(), UIImage(), UIImage(), UIImage()]
    
    var doneMessage : Bool = false
    
    var sideLabel : [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set up scroll view
        self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: width, height: height-200))
        self.scrollView.delegate = self
        self.scrollView.pagingEnabled = true
        self.scrollView.contentSize = CGSize(width: width * 6, height: height - 200)
        self.scrollView.scrollEnabled = false
        self.scrollView.backgroundColor = UIColor.whiteColor()
        
        // set up page control
        self.pageControl = UIPageControl(frame: CGRect(x: 0, y: height-50, width: width, height: 25))
        self.pageControl.backgroundColor = UIColor.whiteColor()
        self.pageControl.numberOfPages = 6
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.redColor()
        self.pageControl.pageIndicatorTintColor = UIColor.grayColor()
        self.pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        
        // set up next, previous buttons
        next = UIButton(type: UIButtonType.System)
        previous = UIButton(type: UIButtonType.System)
        
        next.frame = CGRect(x: width/2, y: height - 100, width: width/2, height: 50)
        previous.frame = CGRect(x: 0, y: height - 100, width: width/2, height: 50)
        
        next.addTarget(self, action: "scrollViewNext:", forControlEvents: UIControlEvents.TouchUpInside)
        previous.addTarget(self, action: "scrollViewPrevious:", forControlEvents: UIControlEvents.TouchUpInside)
        
        next.setTitle("Next", forState: UIControlState.Normal)
        previous.setTitle("Previous", forState: UIControlState.Normal)
        
        // set up picture button
        takePicture = UIButton(type: UIButtonType.System)
        takePicture.frame = CGRect(x: 0, y: height - 150, width: width, height: 50)
        takePicture.setTitle("Take Picture", forState: UIControlState.Normal)
        takePicture.addTarget(self, action: "primaryActionSheet:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // image picker
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker.cameraDevice = UIImagePickerControllerCameraDevice.Rear
        imagePicker.showsCameraControls = true
        
        for x in 0...5 {
            views.append(UIImageView())
            views[x].contentMode = UIViewContentMode.ScaleAspectFit
            views[x].frame = CGRect(x: width * CGFloat(x), y: 0, width: width, height: height-200)
            views[x].backgroundColor = UIColor.grayColor()
            scrollView.addSubview(views[x])
            
            sideLabel.append(UILabel())
            sideLabel[x].frame = CGRect(x: width * CGFloat(x), y: height-225, width: width, height: 25)
            sideLabel[x].backgroundColor = UIColor.blackColor()
            sideLabel[x].textColor = UIColor.whiteColor()
            sideLabel[x].textAlignment = NSTextAlignment.Center
            sideLabel[x].text = "<select side>"
            scrollView.addSubview(sideLabel[x])
        }
        
        view.addSubview(next)
        view.addSubview(previous)
        view.addSubview(takePicture)
        
        view.addSubview(scrollView)
        view.addSubview(pageControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func scrollViewNext(sender: UIButton!) {
        if pageControl.currentPage < 5 {
            pageControl.currentPage = pageControl.currentPage + 1
            scrollView.setContentOffset(CGPoint(x: pageControl.currentPage * Int(width), y: 0), animated: true)
        }
    }
    
    func scrollViewPrevious(sender: UIButton!) {
        if pageControl.currentPage > 0 {
            pageControl.currentPage = pageControl.currentPage  - 1
            scrollView.setContentOffset(CGPoint(x: pageControl.currentPage * Int(width), y: 0), animated: true)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        views[pageControl.currentPage].image = image
        imagePicker.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    func primaryActionSheet(sender: UIButton!) {
        
        // alertController
        let alertController : UIAlertController = UIAlertController(title: "Actions", message: "Select an action for this image.", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let takePicture : UIAlertAction = UIAlertAction(title: "Take Image", style: UIAlertActionStyle.Default, handler: { (action : UIAlertAction) -> Void in
            self.presentViewController(self.imagePicker, animated: true) { () -> Void in
                    
            }
        })
        
        alertController.addAction(takePicture)
        
        let setSide : UIAlertAction = UIAlertAction(title: "Set Image Side", style: UIAlertActionStyle.Default) { (action : UIAlertAction) -> Void in
            
            let selectSide = SelectSide()
            selectSide.delegate = self
            let sSVC = UINavigationController(rootViewController: selectSide)
            self.presentViewController(sSVC, animated: true, completion: { () -> Void in
                
            })
            
        }
        
        alertController.addAction(setSide)
        
        if pageControl.currentPage == 5 {
            let done : UIAlertAction = UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler: { (action : UIAlertAction) -> Void in
                
                self.checkImageStates()
                
            })
            
            alertController.addAction(done)
            
        }
        
        let cancel : UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action : UIAlertAction) -> Void in
            
        }
        
        alertController.addAction(cancel)
        
        presentViewController(alertController, animated: true) { () -> Void in
            
        }

    }

    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        if pageControl.currentPage == 5 && !doneMessage {
            
            let alert : UIAlertController = UIAlertController(title: "Done", message: "When you are done, click the Done button into Actions menu.", preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancel : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action : UIAlertAction) -> Void in
                alert.dismissViewControllerAnimated(true, completion: { () -> Void in
                    
                })
            })
            
            alert.addAction(cancel)
            
            presentViewController(alert, animated: true, completion: { () -> Void in
                
            })
            
            doneMessage = !doneMessage
        
        }
    }
    
    func checkImageStates() {
        
        var okFlag = 0
        
        for x in 0...self.views.count - 1 {
            if self.views[x].image == nil {
                okFlag = okFlag + 1
                break
            }
        }
        
        
        if okFlag == 1 && okFlag == 0 {
            let alert : UIAlertController = UIAlertController(title: "Error", message: "Be sure to take all 6 images!.", preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancel : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action : UIAlertAction) -> Void in
                alert.dismissViewControllerAnimated(true, completion: { () -> Void in
                    
                })
            })
            
            alert.addAction(cancel)
            
            self.presentViewController(alert, animated: true, completion: { () -> Void in
                
            })
            
        }
        else {
            // GO TO NEXT NAV CONTROLLER
            
            let iList = ImageList()
            iList.images = self.views
            iList.sides = self.sideLabel
            
            let navController : UINavigationController = UINavigationController(rootViewController: iList)
            
            self.presentViewController(navController, animated: true, completion: { () -> Void in
                
            })
            
        }
    }
    
    func controller(controller: SelectSide, selectedElement: String) {
        sideLabel[pageControl.currentPage].text = selectedElement
    }
    
}

