//
//  CustomTransition.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/11/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class CustomTransition : NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration: TimeInterval
    
    init(duration: TimeInterval = 1.0) {
        self.duration = duration
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(toViewController.view)
        
        toViewController.view.alpha = 0.0
        
        UIView.animate(withDuration: self.duration, animations: {
            toViewController.view.alpha = 1.0
        }) { (finished) in
            transitionContext.completeTransition(true)
        }
        
    }

}
