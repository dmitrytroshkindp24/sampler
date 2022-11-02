//
//  Created by Karina Lipnyagova on 21.04.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import UIKit

class TabBarControllerAnimator:
    NSObject,
    UIViewControllerAnimatedTransitioning
{
    public static let duration: TimeInterval = 0.3

    public func animateTransition(
        using transitionContext: UIViewControllerContextTransitioning
    ) {
        let srcKey = UITransitionContextViewControllerKey.from
        let destKey = UITransitionContextViewControllerKey.to
        guard
            let srcViewController = transitionContext.viewController(forKey: srcKey),
            let destViewController = transitionContext.viewController(forKey: destKey)
        else { return }
        
        var srcFrame = transitionContext.initialFrame(for: srcViewController)
        var destFrame = transitionContext.finalFrame(for: destViewController)

        if let destParentTabBarController = destViewController.parent as? UITabBarController,
           let srcParentTabBarController = srcViewController.parent as? UITabBarController,
           srcParentTabBarController == destParentTabBarController,
           let viewControllers = destParentTabBarController.viewControllers,
           viewControllers.count > 1,
           let srcIndex = getIndex(of: srcViewController, in: viewControllers),
           let destIndex = getIndex(of: destViewController, in: viewControllers),
           destIndex < srcIndex {
            
            // If the transition is between tabs of the tab bar controller
            // and the selected tab is to the left of the current tab,
            // then view controllers are animated from left to right.
            srcFrame = srcFrame.offsetBy(dx: srcFrame.width, dy: 0)

            destFrame = destFrame.offsetBy(dx: -destFrame.width, dy: 0)
            destViewController.view.frame = destFrame
            destFrame = transitionContext.finalFrame(for: destViewController)
                        
        } else {
            
            // If the transition is between root view controllers of the tab bar controller,
            // or the selected tab is to the right of the current tab,
            // then view controllers are animated from right to left.
            srcFrame = srcFrame.offsetBy(dx: -srcFrame.width, dy: 0)

            destFrame = destFrame.offsetBy(dx: destFrame.width, dy: 0)
            destViewController.view.frame = destFrame
            destFrame = transitionContext.finalFrame(for: destViewController)
        }

        transitionContext.containerView.addSubview(destViewController.view)

        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            srcViewController.view.frame = srcFrame
            destViewController.view.frame = destFrame
        }, completion: {
            transitionContext.completeTransition($0)
        })
    }

    public func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?
    ) -> TimeInterval {
        
        return TabBarControllerAnimator.duration
    }
    
    // MARK: - Private

    private func getIndex(
        of viewControllerToFind: UIViewController,
        in viewControllers: [UIViewController]
    ) -> Int? {
        for (index, viewController) in viewControllers.enumerated() {
            if viewController == viewControllerToFind {
                
                return index
            }
        }
        
        return nil
    }

}
