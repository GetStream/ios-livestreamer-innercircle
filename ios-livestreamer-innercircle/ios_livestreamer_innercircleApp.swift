//
//  ios_livestreamer_innercircleApp.swift
//  ios-livestreamer-innercircle
//
//  Created by Jeroen Leenarts on 11/12/2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import RevenueCat

@main
struct ios_livestreamer_innercircleApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
               ContentView()
            }
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "", appUserID: nil)
        return true
    }
}
