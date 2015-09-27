//
//  ImageProcessing.swift
//  JIVV-Rubix-Cube-Solver
//
//  Created by Jay Ravaliya on 9/26/15.
//  Copyright © 2015 JRav. All rights reserved.
//

import UIKit
import GPUImage

class ImageProcessing : UIViewController {
    
    var imageView : UIImageView!
    var image : UIImage!
    
    var dVC : UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
    
        var modifiedImage : GPUImagePicture = GPUImagePicture(image: image, smoothlyScaleOutput: true)
        var modifiedFilter : GPUImageSobelEdgeDetectionFilter = GPUImageSobelEdgeDetectionFilter()
        
        modifiedImage.addTarget(modifiedFilter)
        modifiedFilter.useNextFrameForImageCapture()
        modifiedImage.processImage()
        
        var finishedImage : UIImage = modifiedFilter.imageFromCurrentFramebuffer()
        
        imageView = UIImageView(image: finishedImage)
        imageView.frame = self.view.frame
        self.view.addSubview(imageView)
        
        dVC = UIBarButtonItem(title: "Dismiss", style: UIBarButtonItemStyle.Plain, target: self, action: "dismissMe:")
        self.navigationItem.rightBarButtonItem = dVC
        
        self.view.addSubview(imageView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismissMe(sender: UIButton!) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
}
