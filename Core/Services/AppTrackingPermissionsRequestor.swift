//
//  Created by Karina Lipnyagova on 22.04.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import AppTrackingTransparency

class AppTrackingPermissionRequestor: NSObject {
    
    @available(iOS 14, *)
    func requestPermission(completion: ((_ isGranted: Bool) -> ())? = nil) {
        ATTrackingManager.requestTrackingAuthorization { (status) in
            let isGranted = status == .authorized
            
            if let completion = completion {
                DispatchQueue.main.async {
                    completion(isGranted)
                }
            }
        }
    }
    
    @available(iOS 14, *)
    func isPermissionRequestedEarlier() -> Bool {
        var isRequested = false
        let status = ATTrackingManager.trackingAuthorizationStatus
        switch status {
        case .authorized, .denied:
            isRequested = true
        default:
            isRequested = false
        }
        
        return isRequested
    }
}
