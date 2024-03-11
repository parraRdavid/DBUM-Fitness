//
//  Dbum_FitnessApp.swift
//  Dbum-Fitness
//
//  Created by iMac on 11/3/23.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct Dbum_FitnessApp: App {
    @StateObject var viewModel = AuthViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    //init(){
     //   FirebaseApp.configure()
    //}
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
