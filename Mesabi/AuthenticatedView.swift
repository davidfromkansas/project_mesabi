import SwiftUI
import GoogleSignIn
import FirebaseAuth

struct AuthenticatedView: View {
    let userInfo: String
    let onSignOut: () -> Void
    @State private var showProfileSheet = false
    @State private var selectedTab: FloatingBottomNavbar.Tab = .home
    @State private var previousTabIndex: Int = 0
    @State private var transitionEdge: Edge = .trailing
    var profileImageURL: URL? {
        GIDSignIn.sharedInstance.currentUser?.profile?.imageURL(withDimension: 64)
    }
    var body: some View {
        ZStack(alignment: .top) {
            Group {
                tabView(for: selectedTab, userInfo: userInfo)
            }
            .background(Color(red: 245/255, green: 249/255, blue: 252/255))
            TopNavbar(
                profileImageURL: profileImageURL,
                onProfileTap: { showProfileSheet = true }
            )
            VStack {
                Spacer()
                FloatingBottomNavbar(selectedTab: $selectedTab, onTabSelected: { newTab in
                    let tabOrder: [FloatingBottomNavbar.Tab] = [.home, .bookmarks, .mobius, .notes, .todo]
                    let newIndex = tabOrder.firstIndex(of: newTab) ?? 0
                    if newIndex > previousTabIndex {
                        transitionEdge = .trailing
                    } else if newIndex < previousTabIndex {
                        transitionEdge = .leading
                    }
                    previousTabIndex = newIndex
                    selectedTab = newTab
                    // // Save bookmark when bookmarks tab is tapped
                    // if newTab == .bookmarks {
                    //     if let userId = Auth.auth().currentUser?.uid {
                    //         UserService.saveBookmarkToUserProfile(userId: userId, bookmark: "https://www.techmeme.com")
                    //     } else {
                    //         print("No user is currently signed in.")
                    //     }
                    // }
                })
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .onAppear {
            selectedTab = .home
        }
        .sheet(isPresented: $showProfileSheet) {
            VStack {
                Capsule()
                    .frame(width: 40, height: 6)
                    .foregroundColor(.gray.opacity(0.3))
                    .padding(.top, 8)
                Spacer()
                Button(action: onSignOut) {
                    Text("Sign Out")
                        .foregroundColor(.red)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
                .padding(.bottom, 40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .presentationDetents([.fraction(1.0)]) // Full screen
        }
        .edgesIgnoringSafeArea(.bottom)
    }

    @ViewBuilder
    private func tabView(for tab: FloatingBottomNavbar.Tab, userInfo: String) -> some View {
        switch tab {
        case .home:
            HomeTabView(userInfo: userInfo)
        case .bookmarks:
            BookmarksView()
        case .mobius:
            MobiusView()
        case .notes:
            NotesView()
        case .todo:
            TodoView()
        }
    }
}

// Placeholder views for each tab
struct HomeTabView: View {
    let userInfo: String
    var body: some View {
        VStack {
            ScrollView {
                Text(userInfo)
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(Color(red: 44/255, green: 44/255, blue: 44/255))
                    .padding()
            }
            .padding(.top, 45)
            Spacer()
        }
    }
}

struct BookmarksView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Bookmarks")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                ForEach(0..<20) { i in
                    Text("Saved Article #\(i + 1)")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 1)
                        .padding(.horizontal)
                }
            }
            .padding(.top, 45)
        }
    }
}

struct MobiusView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Mobius")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                ForEach(0..<20) { i in
                    Text("Mobius Example #\(i + 1): Infinity Loop")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 1)
                        .padding(.horizontal)
                }
            }
            .padding(.top, 45)
        }
    }
}

struct NotesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Notes")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                ForEach(0..<20) { i in
                    Text("Meeting Note #\(i + 1): Project Update")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 1)
                        .padding(.horizontal)
                }
            }
            .padding(.top, 45)
        }
    }
}

struct TodoView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Todo")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                ForEach(0..<20) { i in
                    Text("Task #\(i + 1): Complete SwiftUI Assignment")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 1)
                        .padding(.horizontal)
                }
            }
            .padding(.top, 45)
        }
    }
} 
