//
//  SceneDelegate.swift
//  App
//
//  Created by vasantha_m on 05/05/26.
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var compositionRoot: CompositionRoot?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }
        
        self.window = UIWindow(windowScene: windowScene)
        self.compositionRoot = CompositionRoot()
        
        window?.rootViewController = compositionRoot?.getNavVC()
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
        func sceneWillEnterForeground(_ scene: UIScene) {
        }
        
        func sceneDidEnterBackground(_ scene: UIScene) {
        }
    
}
