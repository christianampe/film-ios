//
//  SceneDelegate.swift
//  Film
//
//  Created by Christian Ampe on 3/3/20.
//  Copyright © 2020 Christian Ampe. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
}

extension SceneDelegate {
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else {
            return
        }
        
        switch windowScene.screen.traitCollection.userInterfaceIdiom {
        case .phone:
            let discoverViewController = DiscoverViewController()
            let navigationController = UINavigationController(rootViewController: discoverViewController)
            
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            
            self.window = window
            
        default:
            break
            
        }
    }   
}
