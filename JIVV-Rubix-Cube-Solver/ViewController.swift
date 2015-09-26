//
//  ViewController.swift
//  JIVV-Rubix-Cube-Solver
//
//  Created by Jay Ravaliya on 9/26/15.
//  Copyright © 2015 JRav. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    var scrollView : UIScrollView!
    var pageControl : UIPageControl!
    
    var next : UIButton!
    var previous : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set up scroll view
        self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: width, height: height-200))
        self.scrollView.delegate = self
        self.scrollView.pagingEnabled = true
        self.scrollView.contentSize = CGSize(width: width * 3, height: height - 200)
        self.scrollView.scrollEnabled = true
        
        // set up page control
        self.pageControl = UIPageControl(frame: CGRect(x: 0, y: height-100, width: width, height: 50))
        self.pageControl.backgroundColor = UIColor.whiteColor()
        self.pageControl.numberOfPages = 3
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.redColor()
        self.pageControl.pageIndicatorTintColor = UIColor.grayColor()
        self.pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        
        // set up next, previous buttons
        next = UIButton(type: UIButtonType.System)
        previous = UIButton(type: UIButtonType.System)
        
        next.frame = CGRect(x: width/2, y: height - 150, width: width/2, height: 50)
        previous.frame = CGRect(x: 0, y: height - 150, width: width/2, height: 50)
        
        next.addTarget(self, action: "scrollViewNext:", forControlEvents: UIControlEvents.TouchUpInside)
        previous.addTarget(self, action: "scrollViewPrevious:", forControlEvents: UIControlEvents.TouchUpInside)
        
        next.setTitle("Next", forState: UIControlState.Normal)
        previous.setTitle("Previous", forState: UIControlState.Normal)
        
        view.addSubview(next)
        view.addSubview(previous)
        
        view.addSubview(scrollView)
        view.addSubview(pageControl)
        
        var view1 : UIView = UIView(frame: view.frame)
        view1.backgroundColor = UIColor.redColor()
        var view2 : UIView = UIView(frame: CGRect(x: width, y: 0, width: width, height: height))
        view2.backgroundColor = UIColor.greenColor()
        var view3 : UIView = UIView(frame: CGRect(x: width * 2, y: 0, width: width, height: height))
        view3.backgroundColor = UIColor.blueColor()
        
        scrollView.addSubview(view1)
        scrollView.addSubview(view2)
        scrollView.addSubview(view3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func scrollViewNext(sender: UIButton!) {
        print(pageControl.currentPage)
        if pageControl.currentPage < 2 {
            pageControl.currentPage = pageControl.currentPage + 1
            scrollView.setContentOffset(CGPoint(x: pageControl.currentPage * Int(width), y: 0), animated: true)
        }
    }
    
    func scrollViewPrevious(sender: UIButton!) {
        print(pageControl.currentPage)
        if pageControl.currentPage > 0 {
            pageControl.currentPage = pageControl.currentPage  - 1
            scrollView.setContentOffset(CGPoint(x: pageControl.currentPage * Int(width), y: 0), animated: true)
        }
    }

}

