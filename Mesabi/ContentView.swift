//
//  ContentView.swift
//  Mesabi
//
//  Created by David Lietjauw on 7/13/25.
//

import SwiftUI

struct ContentView: View {
    init() {
        // Register Nunito Sans font if needed
        UIFont.registerFont(withFilenameString: "NunitoSans-Regular.ttf", bundle: .main)
        UIFont.registerFont(withFilenameString: "NunitoSans-Bold.ttf", bundle: .main)
    }
    var body: some View {
        ZStack {
            Color(red: 245/255, green: 250/255, blue: 254/255)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 40) {
                Spacer()
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 320, height: 320)
                    .padding(.top, 40)
                Spacer()
                // Move the text lower, just above the sign in button
                VStack(spacing: 32) {
                    Text("Access your second brain.")
                        .font(.custom("NunitoSans-Bold", size: 18))
                        .foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.35))
                        .multilineTextAlignment(.center)
                    Button(action: {
                        // Google Sign-In action will go here
                    }) {
                        HStack(spacing: 12) {
                            Image("google_g")
                                .resizable()
                                .frame(width: 28, height: 28)
                            Text("Continue with Google")
                                .font(.system(size: 18, weight: .medium)) // Roboto Medium fallback
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color(.systemGray4), lineWidth: 2)
                        )
                        .cornerRadius(40)
                    }
                    .padding(.bottom, 60)
                }
                Spacer()
            }
        }
    }
}

// Helper to register custom fonts
import UIKit
extension UIFont {
    static func registerFont(withFilenameString filenameString: String, bundle: Bundle) {
        guard let pathForResourceString = bundle.path(forResource: filenameString, ofType: nil) else {
            return
        }
        guard let fontData = NSData(contentsOfFile: pathForResourceString) else {
            return
        }
        guard let dataProvider = CGDataProvider(data: fontData) else {
            return
        }
        guard let fontRef = CGFont(dataProvider) else {
            return
        }
        var errorRef: Unmanaged<CFError>? = nil
        if (CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) == false) {
            // print("Failed to register font: \(filenameString)")
        }
    }
}

#Preview {
    ContentView()
}
