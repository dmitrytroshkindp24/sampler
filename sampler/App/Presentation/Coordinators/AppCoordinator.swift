//
//  Created by Karina Lipnyagova on 14.04.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import UIKit
import DrumPads24Core

class AppCoordinator: Coordinator {

    // MARK: - Public Properties
    
    public var rootTabBarController = UITabBarController()
    
    // MARK: - Lifecycle

    override init() {
        super.init()
        configureTabBarController(rootTabBarController)
    }
    
    // MARK: - Public
    
    public func start() {
        AppLaunchesCounter.increment()
        if AppLaunchesCounter.isFirstLaunch {
            makeAndStartOnboardingCoordinator()
        } else {
            makeAndStartCoordinatorsAfterOnboarding(animated: false)
        }
    }
    
    // MARK: - Private
    
    private func configureTabBarController(_ tabBarController: UITabBarController) {
        tabBarController.delegate = self
        tabBarController.tabBar.isHidden = true
    }

    private func makeOnboardingCoordinator() -> OnboardingCoordinator {
        let coordinator = OnboardingCoordinator();
        
        return coordinator
    }
    
    private func makeStoreCoordinator() -> StoreCoordinator {
        let coordinator = StoreCoordinator();
        
        return coordinator
    }
    
    private func makeFeature1Coordinator() -> Feature1Coordinator {
        let coordinator = Feature1Coordinator();
        
        return coordinator
    }
    
    private func makeFeature2Coordinator() -> Feature2Coordinator {
        let coordinator = Feature2Coordinator();
        
        return coordinator
    }
        
    private func makeAndStartOnboardingCoordinator() {
        let onboardingCoordinator = makeOnboardingCoordinator()
        addChildCoordinator(onboardingCoordinator)
        
        let finishCompletion: CoordinatorFinishCompletion = {
            [weak self] coordinator in
            guard let self = self else { return }

            self.makeAndStartCoordinatorsAfterOnboarding(animated: true)
            self.removeChildCoordinator(
                coordinator,
                after: TabBarControllerAnimator.duration)
        }
        
        let viewControllers = [onboardingCoordinator.rootNavigationController]
        rootTabBarController.setViewControllers(viewControllers, animated: false)
                
        onboardingCoordinator.start(with: finishCompletion)
    }
    
    private func makeAndStartStoreCoordinator(animated: Bool) {
        let storeCoordinator = makeStoreCoordinator()
        addChildCoordinator(storeCoordinator)
        
        let finishCompletion: CoordinatorFinishCompletion = { [weak self] coordinator in
            guard let self = self else { return }

            self.makeAndStartCoordinatorsAfterStore(animated: true)
            self.removeChildCoordinator(
                coordinator,
                after: TabBarControllerAnimator.duration)
        }
                
        let viewControllers = [storeCoordinator.rootNavigationController]
        rootTabBarController.setViewControllers(viewControllers, animated: animated)
        storeCoordinator.start(
            from: StoreAnalyticsConstants.Source.atAppLaunch,
            with: finishCompletion)
    }
    
    private func makeAndStartFeaturesCoordinators(animated: Bool) {
        rootTabBarController.tabBar.isHidden = false
        
        let feature1Coordinator = makeFeature1Coordinator()
        addChildCoordinator(feature1Coordinator)
        
        let feature2Coordinator = makeFeature2Coordinator()
        addChildCoordinator(feature2Coordinator)
        
        let viewControllers = [
            feature1Coordinator.rootNavigationController,
            feature2Coordinator.rootNavigationController
        ]
        
        rootTabBarController.setViewControllers(viewControllers, animated: animated)
    }
    
    private func makeAndStartCoordinatorsAfterOnboarding(animated: Bool) {
        if needsDisplayStore() {
            makeAndStartStoreCoordinator(animated: animated)
        } else {
            makeAndStartCoordinatorsAfterStore(animated: animated)
        }
    }
    
    private func makeAndStartCoordinatorsAfterStore(animated: Bool) {
        makeAndStartFeaturesCoordinators(animated: animated)
    }
    
    private func removeChildCoordinator(
        _ coordinator: Coordinator,
        after delay: TimeInterval
    ) {
        let deadline: DispatchTime = .now() + delay
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.removeChildCoordinator(coordinator)
        }
    }
    
    private func needsDisplayStore() -> Bool {
        
        // just for testing purposes
        return true
    }
}

// MARK: - UITabBarControllerDelegate

typealias TabBarControllerAnimatedTransitionDelegate = AppCoordinator

extension TabBarControllerAnimatedTransitionDelegate: UITabBarControllerDelegate {

    func tabBarController(
        _ tabBarController: UITabBarController,
        animationControllerForTransitionFrom fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        
        return TabBarControllerAnimator()
    }
}
