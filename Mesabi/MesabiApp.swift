//
//  MesabiApp.swift
//  Mesabi
//
//  Created by David Lietjauw on 7/13/25.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

@main
struct MesabiApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let persistenceController = PersistenceController.shared

    // Removed manual GoogleSignIn configuration

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
