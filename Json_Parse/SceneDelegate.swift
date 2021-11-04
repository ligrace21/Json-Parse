//
//  SceneDelegate.swift
//  Json_Parse
//
//  Created by user on 10/5/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
         if let splitViewController = window?.rootViewController as? UISplitViewController,
            let navController = splitViewController.viewControllers.first as? UINavigationController,
            let patientListViewController = navController.viewControllers.first as? PatientListViewController,
            splitViewController.viewControllers.count > 1,
            let patientDetailsViewController = (splitViewController.viewControllers.last as? UINavigationController)?.topViewController as? PatientDetailsViewController
        {
            patientListViewController.delegate = patientDetailsViewController
            
            //make master view always show up when launch
            splitViewController.preferredDisplayMode = .allVisible
            if #available(iOS 14.0, *) {
                splitViewController.preferredSplitBehavior = .displace
                splitViewController.preferredPrimaryColumnWidthFraction = 0.5
                splitViewController.maximumPrimaryColumnWidth = splitViewController.view.bounds.size.width;
            }
        }
    }
}

