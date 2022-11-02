//
//  Created by Karina Lipnyagova on 22.04.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import UIKit

protocol StorePresenterCoordinatorProtocol: AnyObject {
    func storePresenterWillClose(_ storePresenter: StorePresenter)
}

class StorePresenter: NSObject {

    // MARK: - Public Properties

    public weak var coordinator: StorePresenterCoordinatorProtocol?

    // MARK: - Private Properties

    private var viewController: StoreViewController?
    private var source: String = ""

    // MARK: - Lifecycle
    
    override convenience init() {
        self.init()
    }
    
    init(for viewController: StoreViewController, from source: String) {
        super.init()
        
        self.source = source
        self.viewController = viewController
        self.viewController?.presenter = self
    }
    
    // MARK: - Public
    
    public func viewControllerDidAppear() {
        AnalyticsUser.didViewScreen(StoreAnalyticsConstants.Screen.store)
        AnalyticsUser.didViewStore(source: source)
    }

    public func viewControllerWillClose() {
        coordinator?.storePresenterWillClose(self)
    }
    
    public func viewControllerWillBuyProduct(productIndex: Int) {
        let productId = getProductId(by: productIndex)
        buyProduct(productId: productId)
    }
    
    // MARK: - Private
    
    private func getProductId(by index: Int) -> String {
        // get productId from products array
        
        return ""
    }
    
    private func buyProduct(productId: String) {
        AnalyticsUser.didStartPurchase(productId: productId, source: source)
    }
 
}
