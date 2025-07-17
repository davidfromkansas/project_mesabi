import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import Firebase

@main
struct MesabiApp: App {
    init() {
        FirebaseApp.configure()
    }
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
} 