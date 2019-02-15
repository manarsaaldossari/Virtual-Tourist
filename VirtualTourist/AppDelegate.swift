//
//  AppDelegate.swift
//  VirtualTourist
//
//  Created by manar Aldossari on 07/06/1440 AH.
//  Copyright © 1440 MacBook Pro. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let dataController = DataController(modelName: "VirtualTourist") 

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        dataController.load()
        let navigationVC = window?.rootViewController as! UINavigationController
        let mapVC = navigationVC.topViewController as! MapViewController
        mapVC.dataController = dataController
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        saveViewContext()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        saveViewContext()
    }
    //save function
    func saveViewContext(){
        do {
            try dataController.viewContext.save()
        }catch{
            print("viewContext did not save")
        }
    }


}

