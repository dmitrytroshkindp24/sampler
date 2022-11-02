//
//  Created by Karina Lipnyagova on 20.04.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import UIKit

class StoreCoordinator: Coordinator {

    // MARK: - Public Properties

    public var rootNavigationController = UINavigationController()

    // MARK: - Private Properties
    
    private var finishCompletion: CoordinatorFinishCompletion?

    // MARK: - Lifecycle
    
    override init() {
        super.init()
        
        configureRootNavigationController()
    }

    // MARK: - Public

    public func start(from source: String, with finishCompletion: @escaping CoordinatorFinishCompletion) {
        self.finishCompletion = finishCompletion
        
        let storeViewController = makeStoreViewController(from: source)
        rootNavigationController.viewControllers = [storeViewController]
    }
    
    // MARK: - Private
    
    private func makeStoreViewController(from source: String) -> UIViewController {
        let viewController = StoreViewController()
        let presenter = StorePresenter(for: viewController, from: source)
        presenter.coordinator = self
        
        return viewController
    }

    private func configureRootNavigationController() {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithTransparentBackground()
        rootNavigationController.navigationBar.standardAppearance = standardAppearance
    }
}

extension StoreCoordinator: StorePresenterCoordinatorProtocol {

    func storePresenterWillClose(_ storePresenter: StorePresenter) {
        guard let finishCompletion = self.finishCompletion else { return }
        
        finishCompletion(self)
        self.finishCompletion = nil
    }
    
}
