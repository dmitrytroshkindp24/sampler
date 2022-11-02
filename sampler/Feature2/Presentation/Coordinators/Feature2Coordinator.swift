//
//  Created by Karina Lipnyagova on 20.04.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import UIKit

class Feature2Coordinator: Coordinator {
    
    public var finishCompletion: CoordinatorFinishCompletion?
    public var rootNavigationController = UINavigationController()
    
    override init() {
        super.init()
        
        let viewController = makeFeature2ViewController()
        rootNavigationController.viewControllers = [viewController]
        
        let title = viewController.title ?? ""
        configureNavigationController(with: title)
    }

    public func start() {
    }
    
    // MARK: - Private
    
    private func configureNavigationController(with title: String) {
        rootNavigationController.navigationBar.prefersLargeTitles = true
        rootNavigationController.tabBarItem = makeTabBarItem(with: title)
    }
    
    private func makeTabBarItem(with title: String) -> UITabBarItem {
        let tabBarItem = UITabBarItem.init(
            title: title,
            image: nil,
            tag: 0)
        
        return tabBarItem
    }
    
    private func makeFeature2ViewController() -> UIViewController {
        let viewController = Feature2ViewController()
        
        return viewController
    }
    
}
