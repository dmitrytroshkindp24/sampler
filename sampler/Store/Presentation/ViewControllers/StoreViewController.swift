//
//  Created by Karina Lipnyagova on 20.04.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import UIKit
import DrumPads24UICore

class StoreViewController: UIViewController {

    // MARK: - Public Properties
    
    var presenter: StorePresenter?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBarButtonsIFNeeded()            
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.viewControllerDidAppear()
    }
    
    override func loadView() {
        let view = StoreView()
        view.actionsDelegate = self
        self.view = view
    }
    
    // MARK: - Actions
    
    @objc private func didTouchUpInsideCloseButton(_ button: UIButton) {
        presenter?.viewControllerWillClose()
    }
    
    // MARK: - Private
    
    private func addBarButtonsIFNeeded() {
        guard let _ = navigationController else { return }
        
        navigationItem.leftBarButtonItem = closeButtonItem()
    }
    
    private func closeButtonItem() -> UIBarButtonItem {
        let closeButton = CloseButton()
        closeButton.sizeToFit()
        closeButton.addTarget(
            self,
            action: #selector(didTouchUpInsideCloseButton),
            for: .touchUpInside)
        
        return UIBarButtonItem(customView: closeButton)
    }
}

extension StoreViewController: StoreViewActionsDelegate {
    func storeView(
        _ storeView: StoreView,
        didTouchUpInsideBuyButton button: UIButton
    ) {
        // get index of clicked product
        let productIndex: Int = 0
        presenter?.viewControllerWillBuyProduct(productIndex: productIndex)
    }
}
