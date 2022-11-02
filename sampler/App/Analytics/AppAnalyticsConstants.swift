//
//  Created by Karina Lipnyagova on 22.04.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

enum AppAnalyticsConstants {
    
    enum Category {
        static let app = "App"
        static let appTracking = "App Tracking"
    }
    
    enum Action {
        static let firstLaunch = "First launch"
        static let permissionsAsked = "Permissions asked"
        static let permissionsGiven = "Permissions given"
    }
}
