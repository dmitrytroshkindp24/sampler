//
//  Created by Karina Lipnyagova on 14.04.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import UIKit

protocol OnboardingWelcomeViewControllerActionsDelegate: AnyObject {
    func onboardingWelcomeViewControllerDidAccept(
        _ onboardingWelcomeViewController: OnboardingWelcomeViewController)
    
    func onboardingWelcomeViewController(
        _ onboardingWelcomeViewController: OnboardingWelcomeViewController,
        willOpen URL: URL)
}

class OnboardingWelcomeViewController: UIViewController {

    // MARK: - Public Properties
    
    public weak var actionsDelegate: OnboardingWelcomeViewControllerActionsDelegate?

    // MARK: - Lifecycle
    
    override func loadView() {
        let view = OnboardingWelcomeView()
        view.actionsDelegate = self
        self.view = view
    }
}

extension OnboardingWelcomeViewController: OnboardingWelcomeViewActionsDelegate {
    
    func onboardingWelcomeView(
        _ onboardingWelcomeView: OnboardingWelcomeView,
        didTouchUpInsideAcceptButton button: UIButton
    ) {
        actionsDelegate?.onboardingWelcomeViewControllerDidAccept(self)
    }
    
    func onboardingWelcomeView(
        _ onboardingWelcomeView: OnboardingWelcomeView,
        willOpen URL: URL
    ) {
        actionsDelegate?.onboardingWelcomeViewController(self, willOpen: URL)
    }
}
