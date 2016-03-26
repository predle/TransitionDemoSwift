//
//  CollectionViewController.swift
//  TransitionDemoSwift
//
//  Created by Beomseok Seo on 3/26/16.
//  Copyright © 2016 Predle. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController, UINavigationControllerDelegate {

    class CollectionViewFlowLayout: UICollectionViewFlowLayout {
        
    }
    
    var layout : CollectionViewFlowLayout {
        let layout = CollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width/4 - 4, UIScreen.mainScreen().bounds.size.width/4 - 4)
        layout.minimumInteritemSpacing = 4.0
        layout.minimumLineSpacing = 4.0
        return layout
    }
    
    var images: [String] = [
        "cherry-blossom-1260646_640",
        "crocus-1261310_960_720",
        "frog-897418_960_720",
        "japanese-cherry-trees-324175_960_720",
        "meerkat-1097581_960_720",
        "road-1226873_960_720"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        self.collectionView?.collectionViewLayout = self.layout
        self.navigationController?.delegate = self
    }
    
    ///
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell
        
        // Configure the cell
        cell.imageView.image = UIImage(named: images[indexPath.row])
        return cell
    }
    
    ///
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        let collectionViewCell = self.collectionView?.cellForItemAtIndexPath(indexPath)
        let imageView = (collectionViewCell as! CollectionViewCell).imageView
        
        let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DetailViewController") as? DetailViewController
        self.navigationController?.pushViewController(viewController!, animated: true)
        
    }
    
    ///
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .Push {
            let selectedIndexPaths = self.collectionView?.indexPathsForSelectedItems()
            let indexPath: NSIndexPath = selectedIndexPaths![0]
            let collectionViewCell = self.collectionView?.cellForItemAtIndexPath(indexPath)
            let imageView = (collectionViewCell as! CollectionViewCell).imageView
            imageView.hidden = true
            let imageName = images[indexPath.row]
            
            var cellRect = collectionViewCell!.frame
            cellRect.origin.y += (self.collectionView?.contentInset.top)!
            return TransitionPresentationAnimator(frame: cellRect, imageName: imageName)
        }
        
        if operation == .Pop {
            return TransitionDismissalAnimator()
        }
        
        return nil
    }
    
    ///
    
    func showSelectedImageView(frame: CGRect){

        let indexPath: NSIndexPath = (self.collectionView?.indexPathForItemAtPoint(frame.origin))!
        let collectionViewCell = self.collectionView?.cellForItemAtIndexPath(indexPath)
        let imageView = (collectionViewCell as! CollectionViewCell).imageView
        imageView.hidden = false
        
    }
}
