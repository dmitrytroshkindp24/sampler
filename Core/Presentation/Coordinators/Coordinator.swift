//
//  Created by Karina Lipnyagova on 15.04.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import UIKit

typealias CoordinatorFinishCompletion = (Coordinator) -> Void

class Coordinator: NSObject {

    // MARK: - Public Properties
    
    public var childCoordinators: [Coordinator] = []

    // MARK: - Public
    
    public func addChildCoordinator(_ childCoordinator: Coordinator) {
        childCoordinators.append(childCoordinator)
    }
    
    public func removeChildCoordinator(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(of: childCoordinator) {
            childCoordinators.remove(at: index)
        }
    }
}
