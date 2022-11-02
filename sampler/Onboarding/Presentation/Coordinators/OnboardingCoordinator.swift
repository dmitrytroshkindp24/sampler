//
//  Created by Karina Lipnyagova on 14.04.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import Foundation
import SafariServices

class OnboardingCoordinator: Coordinator {

    // MARK: - Public Properties

    public var rootNavigationController = UINavigationController()

    // MARK: - Private Properties
    
    private var finishCompletion: CoordinatorFinishCompletion?
    private var navigationController = UINavigationController()

    // MARK: - Lifecycle
    
    override init() {
        super.init()
        
        configureRootNavigationController()
        
        let welcomeViewController = makeWelcomeViewController()
        rootNavigationController.viewControllers = [welcomeViewController]
    }

    // MARK: - Public
    
    public func start(with finishCompletion: @escaping CoordinatorFinishCompletion) {
        self.finishCompletion = finishCompletion
    }
    
    // MARK: - Private

    private func configureRootNavigationController() {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithTransparentBackground()
        rootNavigationController.navigationBar.standardAppearance = standardAppearance
    }
    
    private func makeWelcomeViewController() -> UIViewController {
        let welcomeViewController = OnboardingWelcomeViewController()
        welcomeViewController.actionsDelegate = self
        
        return welcomeViewController
    }
    
    private func requestAppTrackingPermission(completion: @escaping () ->  Void) {
        if #available(iOS 14, *) {
            let requestor = AppTrackingPermissionRequestor()
            if (requestor.isPermissionRequestedEarlier()) {
                completion()
            } else {
                AnalyticsUser.didAskAppTrackingPermissions()
                requestor.requestPermission { (isGranted) in
                    if isGranted {
                        AnalyticsUser.didGiveAppTrackingPermissions()
                    }
                    completion()
                }
            }
        } else {
            completion()
        }
    }
}

extension OnboardingCoordinator: OnboardingWelcomeViewControllerActionsDelegate {
    
    func onboardingWelcomeViewControllerDidAccept(
        _ onboardingWelcomeViewController: OnboardingWelcomeViewController
    ) {
        requestAppTrackingPermission {
            guard let finishCompletion = self.finishCompletion else { return }
            
            finishCompletion(self)
            self.finishCompletion = nil
        }
    }
    
    func onboardingWelcomeViewController(
        _ onboardingWelcomeViewController: OnboardingWelcomeViewController,
        willOpen URL: URL
    ) {
        let safariViewController = SFSafariViewController(url: URL)
        onboardingWelcomeViewController.present(
            safariViewController,
            animated: true,
            completion: nil)
    }
}
