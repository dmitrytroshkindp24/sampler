//
//  Created by Karina Lipnyagova on 14.04.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
        
        window = makeWindow(for: scene)
        
        if let window = window {
            appCoordinator = AppCoordinator()
            window.rootViewController = appCoordinator.rootTabBarController
            window.makeKeyAndVisible()
            appCoordinator.start()
        }
    }
    
    // MARK: - Private
    
    private func makeWindow(for scene: UIScene) -> UIWindow? {
        guard let windowScene = (scene as? UIWindowScene) else { return nil }

        let window = UIWindow(windowScene: windowScene)
        
        return window
    }

}
