//
//  CrownKings_SwiftUIApp.swift
//  CrownKings_SwiftUI
//
//  Created by Joel Carter on 5/8/24.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseStorage


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct CrownKings_SwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var loyalty = LoyaltyViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(loyalty)
                .environmentObject(AuthenticationViewModel())
        }
    }
}
