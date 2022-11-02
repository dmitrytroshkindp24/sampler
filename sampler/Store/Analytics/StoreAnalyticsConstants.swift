//
//  Created by Karina Lipnyagova on 22.04.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import Foundation

enum StoreAnalyticsConstants {

    enum Screen {
        static let store = "Store"
    }
    
    enum Category {
        static let store = "Store"
        static let purchase = "Purchase"
    }
    
    enum Action {
        static let shown = "Shown"
        static let started = "Started"
    }
    
    enum Param {
        static let productId = "productId"
        static let source = "source"
    }
    
    enum Source {
        static let atAppLaunch = "At app launch"
    }
}
