//
//  DetailViewController.swift
//  TransitionDemoSwift
//
//  Created by Beomseok Seo on 3/26/16.
//  Copyright © 2016 Predle. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var imageView: UIImageView?
    
    //
    func setImageView(imageView: UIImageView?) {
        if let imgView = imageView {
            self.imageView = imgView
            self.view.addSubview(imgView)
        }
    }
    func getImageView() -> UIImageView? {
        return self.imageView
    }
    
    // set original image frame
    private var originalFrame: CGRect?
    func setOriginalImageFrame(frame: CGRect) {
        self.originalFrame = frame
    }
    func getOriginalImageFrame() -> CGRect? {
        return self.originalFrame
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    deinit {
        print("DetailViewController deinitialized")
    }
}

