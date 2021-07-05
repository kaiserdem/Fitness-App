//
//  Fitness_AppApp.swift
//  Fitness App
//
//  Created by Kaiserdem on 16.06.2021.
//

import SwiftUI
import Firebase

@main
struct Fitness_AppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                TabView {
                    Text("Log")
                        .tabItem {
                            Image(systemName: "book")
                        }
                }.accentColor(.primary)
            } else {
               LandingView()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        print("Setting up firebase")
        FirebaseApp.configure()
        return true
    }
}

class AppState: ObservableObject {
    
    @Published private(set) var isLoggedIn = false
    private let userService: UserServicesProtocol
    
    init(userService: UserServicesProtocol = UserService()) {
        self.userService = userService
        try? Auth.auth().signOut()
        userService
            .observeAuthChanges()
            .map { $0 != nil }
            .assign(to: &$isLoggedIn)
    }
}
