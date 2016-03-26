//
//  TransitionDismissAnimator.swift
//  TransitionDemoSwift
//
//  Created by Beomseok Seo on 3/26/16.
//  Copyright © 2016 Predle. All rights reserved.
//

import UIKit


class TransitionDismissalAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()
        
        let viewController = toViewController as? CollectionViewController
        let detailViewController = fromViewController as? DetailViewController
        
        let originalFrame = detailViewController?.getOriginalImageFrame()
        
        let imageView = (detailViewController?.getImageView())!
        imageView.contentMode = .ScaleAspectFill
        containerView?.addSubview(imageView)
        
        let animationDuration = self .transitionDuration(transitionContext)
        
        containerView!.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: [],
                                   animations: { () -> Void in
                                    
                                    imageView.frame = originalFrame!
                                    fromViewController.view.alpha = 0.0
                                    
            }, completion: { (finished) -> Void in

                viewController?.showSelectedImageView(originalFrame!)
                imageView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                
        })
        
    }
}

