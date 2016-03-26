//
//  TransitionPresentationAnimator.swift
//  TransitionDemoSwift
//
//  Created by Beomseok Seo on 3/26/16.
//  Copyright © 2016 Predle. All rights reserved.
//

import UIKit

class TransitionPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var frame: CGRect?
    var imageName: String?
    
    convenience init(frame: CGRect, imageName: String) {
        self.init()
        self.frame = frame
        self.imageName = imageName
    }
    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()
        
        let animationDuration = self.transitionDuration(transitionContext)
        
        let detailViewController = toViewController as! DetailViewController
        detailViewController.setOriginalImageFrame(self.frame!)
        
        toViewController.view.alpha = 0.0
        containerView!.addSubview(toViewController.view)
        
        let imageView: UIImageView = UIImageView(frame: self.frame!)
        let image: UIImage = UIImage(named: self.imageName!)!
        imageView.image = image
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.autoresizesSubviews = true
        containerView!.addSubview(imageView)
        
        let ratio = image.size.width/image.size.height
        let viewHeight = UIScreen.mainScreen().bounds.size.width / ratio
        let viewFrame  = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, viewHeight)
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [],
                                   animations: { () -> Void in
                                    imageView.frame = viewFrame
                                    imageView.center = containerView!.center
                                    toViewController.view.alpha = 1.0
                                    
            }, completion: { (finished) -> Void in
                imageView.contentMode = .ScaleAspectFit
                
                detailViewController.setImageView(imageView)
                transitionContext.completeTransition(finished)
        })
    }
}
