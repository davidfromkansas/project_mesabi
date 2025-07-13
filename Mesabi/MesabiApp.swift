//
//  MesabiApp.swift
//  Mesabi
//
//  Created by David Lietjauw on 7/13/25.
//

import SwiftUI

@main
struct MesabiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
