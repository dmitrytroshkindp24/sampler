//
//  Created by Karina Lipnyagova on 22.04.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import Foundation
import DrumPads24AnalyticsTracker

class AnayticsConfigurator {
    
    private enum Constants {
        static let needsPrintLog = false
        
        enum Amplitude {
            static let apiKeyLive = ""
            static let apiKeyDebug = ""
        }
        
        enum AppsFlyer {
            static let apiKeyLive = ""
        }
    }
    
    // MARK: - Public
    
    public func configureAnalytics(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        AnalyticsTrackerConfig.sharedConfig.needsPrintLog = Constants.needsPrintLog

        configureAppsFlyer()
        configureAmplitude()
        configureFirebase()
        configureFacebook(application: application, launchOptions: launchOptions)
    }
    
    // MARK: - Private
    
    private func configureAppsFlyer() {
        #if DEBUG
        AnalyticsTrackerConfig.sharedConfig.isAppsFlyerInDebugMode = true
        #endif
        //AnalyticsTrackerConfig.sharedConfig.appsFlyerAppleAppId = App.appId
        AnalyticsTrackerConfig.sharedConfig.appsFlyerApiKey = appsFlyerApiKey()
        
    }
    
    private func configureAmplitude() {
        AnalyticsTrackerConfig.sharedConfig.amplitudeApiKey = amplitudeApiKey()
    }
    
    private func configureFirebase() {
        AnalyticsTrackerConfig.sharedConfig.configureFirebase()
    }
    
    private func configureFacebook(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        AnalyticsTrackerConfig.sharedConfig.configureFacebook(application: application, launchOptions: launchOptions)
        #if DEBUG
        AnalyticsTrackerConfig.sharedConfig.isFacebookInDebugMode = true
        #endif
    }
    
    private func appsFlyerApiKey() -> String {

        return Constants.AppsFlyer.apiKeyLive
    }
    
    private func amplitudeApiKey() -> String {
        var apiKey = Constants.Amplitude.apiKeyLive
        #if DEBUG
        apiKey = Constants.Amplitude.apiKeyDebug
        #endif
        
        return apiKey
    }
}
