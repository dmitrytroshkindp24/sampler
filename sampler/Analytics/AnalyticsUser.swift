//
//  Created by Karina Lipnyagova on 22.04.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import Foundation
import DrumPads24AnalyticsTracker

class AnalyticsUser {

    // MARK: - App

    class func didLaunchApp() {
        AnalyticsTracker.tracker.trackAppLaunch()
    }
    
    class func didFirstLaunchApp() {
        AnalyticsTracker.tracker.trackEvent(
            category: AppAnalyticsConstants.Category.app,
            action: AppAnalyticsConstants.Action.firstLaunch)
    }
    
    class func didRegisterUninstall(deviceToken: Data) {
        AnalyticsTracker.tracker.registerUninstall(deviceToken)
    }
    
    // MARK: - App Tracking
    
    class func didAskAppTrackingPermissions() {
        AnalyticsTracker.tracker.trackEvent(
            category: AppAnalyticsConstants.Category.appTracking,
            action: AppAnalyticsConstants.Action.permissionsAsked)
    }

    class func didGiveAppTrackingPermissions() {
        AnalyticsTracker.tracker.trackEvent(
            category: AppAnalyticsConstants.Category.appTracking,
            action: AppAnalyticsConstants.Action.permissionsGiven)
    }

    // MARK: - Screens

    class func didViewScreen(_ screenName: String) {
        AnalyticsTracker.tracker.trackScreen(screenName)
    }
        
    // MARK: - Store
    
    class func didViewStore(source: String) {
        AnalyticsTracker.tracker.trackEvent(
            category: StoreAnalyticsConstants.Category.store,
            action: StoreAnalyticsConstants.Action.shown,
            params: [StoreAnalyticsConstants.Param.source: source])
    }
    
    class func didStartPurchase(productId: String, source: String) {
        let params = [StoreAnalyticsConstants.Param.productId: productId,
                      StoreAnalyticsConstants.Param.source: source]
        AnalyticsTracker.tracker.trackEvent(
            category: StoreAnalyticsConstants.Category.purchase,
            action: StoreAnalyticsConstants.Action.started,
            params: params)
    }
    
    // MARK: - User Properties
    
}
