import SwiftUI
import GoogleSignIn

struct AuthenticatedView: View {
    let userInfo: String
    let onSignOut: () -> Void
    var body: some View {
        VStack {
            Text("Authenticated!")
                .font(.title)
                .padding()
            ScrollView {
                Text(userInfo)
                    .font(.system(.body, design: .monospaced))
                    .padding()
            }
            Button(action: onSignOut) {
                Text("Sign Out")
                    .foregroundColor(.red)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            .padding(.bottom, 20)
            Spacer()
        }
    }
} 