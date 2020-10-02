//
//  AppDelegate.swift
//  iOS_Rekognition_Uploader
//
//  Created by Roger Navarro on 9/28/20.
//

import Foundation
import UIKit
import Amplify
import AmplifyPlugins

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    do {
//      Amplify.Logging.logLevel = .verbose
      try Amplify.add(plugin: AWSCognitoAuthPlugin())
      try Amplify.add(plugin: AWSS3StoragePlugin())
      try Amplify.configure()
      print("🟢 Amplify configured")
    } catch {
      print("An error occurred setting up Amplify: \(error)")
    }
    return true
    
  }
}
