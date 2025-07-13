//
//  ContentView.swift
//  Mesabi
//
//  Created by David Lietjauw on 7/13/25.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct ContentView: View {
    @State private var isSigningIn = false
    @State private var signInError: Error?
    @State private var isAuthenticated = false
    @State private var userInfo: String = ""
    
    init() {
        // Removed custom font registration to fix errors
    }
    
    func restoreSignIn() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let user = user {
                var info = ""
                info += "Name: \(user.profile?.name ?? "N/A")\n"
                info += "Email: \(user.profile?.email ?? "N/A")\n"
                info += "User ID: \(user.userID ?? "N/A")\n"
                info += "ID Token: \(user.idToken?.tokenString ?? "N/A")\n"
                info += "Access Token: \(user.accessToken.tokenString ?? "N/A")\n"
                if let profile = user.profile {
                    info += "Given Name: \(profile.givenName ?? "N/A")\n"
                    info += "Family Name: \(profile.familyName ?? "N/A")\n"
                    info += "Has Image: \(profile.hasImage ? "Yes" : "No")\n"
                }
                userInfo = info
                isAuthenticated = true
            } else {
                isAuthenticated = false
                userInfo = ""
            }
        }
    }
    
    func handleSignInTap() {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            return
        }
        isSigningIn = true
        signInError = nil
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
            isSigningIn = false
            if let error = error {
                signInError = error
                return
            }
            guard let user = signInResult?.user else {
                return
            }
            var info = ""
            info += "Name: \(user.profile?.name ?? "N/A")\n"
            info += "Email: \(user.profile?.email ?? "N/A")\n"
            info += "User ID: \(user.userID ?? "N/A")\n"
            info += "ID Token: \(user.idToken?.tokenString ?? "N/A")\n"
            info += "Access Token: \(user.accessToken.tokenString ?? "N/A")\n"
            if let profile = user.profile {
                info += "Given Name: \(profile.givenName ?? "N/A")\n"
                info += "Family Name: \(profile.familyName ?? "N/A")\n"
                info += "Has Image: \(profile.hasImage ? "Yes" : "No")\n"
            }
            userInfo = info
            isAuthenticated = true
        }
    }
    
    func handleSignOut() {
        GIDSignIn.sharedInstance.signOut()
        isAuthenticated = false
        userInfo = ""
    }
    
    var body: some View {
        Group {
            if isAuthenticated {
                AuthenticatedView(userInfo: userInfo, onSignOut: handleSignOut)
                    .onAppear(perform: restoreSignIn)
            } else {
                LoginView(
                    isSigningIn: $isSigningIn,
                    signInError: $signInError,
                    onSignInTap: handleSignInTap
                )
                .onAppear(perform: restoreSignIn)
            }
        }
    }
}
