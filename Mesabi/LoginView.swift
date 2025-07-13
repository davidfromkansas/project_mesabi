import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
    @Binding var isSigningIn: Bool
    @Binding var signInError: Error?
    let onSignInTap: () -> Void
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
                VStack(spacing: 32) {
                    Text("Access your second brain.")
                        .font(.custom("NunitoSans-Bold", size: 18))
                        .foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.35))
                        .multilineTextAlignment(.center)
                    Button(action: onSignInTap) {
                        HStack(spacing: 12) {
                            Image("google_g")
                                .resizable()
                                .frame(width: 28, height: 28)
                            Text("Continue with Google")
                                .font(.system(size: 18, weight: .medium))
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
                    .disabled(isSigningIn)
                    if isSigningIn {
                        ProgressView("Signing in...")
                    }
                    if let error = signInError {
                        Text("Sign-in failed: \(error.localizedDescription)")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                Spacer()
            }
        }
    }
} 