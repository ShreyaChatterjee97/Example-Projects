//
//  AppDelegate.swift
//  Map Application
//
//  Created by Shreya Chatterjee on 21/07/22.
//

import UIKit
import GoogleMaps

// 1
let googleApiKey = "AIzaSyBmVHdzQuJOnF-Q8vKWQFdiRfmgfdrUZb8"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    //2
    GMSServices.provideAPIKey(googleApiKey)
    return true
  }
}


