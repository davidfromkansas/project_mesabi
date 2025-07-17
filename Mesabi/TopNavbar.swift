import SwiftUI

struct TopNavbar: View {
    let profileImageURL: URL?
    let onProfileTap: () -> Void
    
    private let barHeight: CGFloat = 45 // 40 image + 0pt top + 5pt bottom
    private let imageSize: CGFloat = 40 // Larger profile image
    
    var body: some View {
        ZStack(alignment: .top) {
            // Semi-transparent blur background
            Color.clear
                .background(.ultraThinMaterial)
                .opacity(0.1)
                .ignoresSafeArea(edges: .top)
                .frame(height: barHeight)
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button(action: onProfileTap) {
                        if let url = profileImageURL {
                            AsyncImage(url: url) { image in
                                image.resizable()
                            } placeholder: {
                                Circle().fill(Color.gray.opacity(0.3))
                            }
                            .frame(width: imageSize, height: imageSize)
                            .clipShape(Circle())
                        } else {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: imageSize, height: imageSize)
                                .overlay(
                                    Image(systemName: "person.crop.circle")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.gray)
                                        .padding(4)
                                )
                        }
                    }
                    .padding(.top, 0)
                    .padding(.bottom, 5)
                    .padding(.trailing, 12)
                    .contentShape(Rectangle())
                }
                .frame(height: barHeight) // Center image vertically
                Divider()
            }
        }
        .frame(height: barHeight)
    }
}

struct FloatingBottomNavbar: View {
    enum Tab {
        case home, bookmarks, mobius, notes, todo
    }
    @Binding var selectedTab: Tab
    var onTabSelected: ((Tab) -> Void)? = nil
    
    private let icons: [(Tab, String?)] = [
        (.home, "house"),
        (.bookmarks, "bookmark"),
        (.mobius, nil), // Center tab uses custom image
        (.notes, "note.text"),
        (.todo, "checkmark.circle")
    ]
    
    var body: some View {
        HStack {
            ForEach(icons, id: \.0) { tab, systemName in
                Button(action: {
                    selectedTab = tab
                    onTabSelected?(tab)
                }) {
                    if tab == .mobius {
                        Image("mobius_with_drop_shadow")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .opacity(selectedTab == tab ? 1.0 : 0.5)
                    } else if let systemName = systemName {
                        Image(systemName: systemName)
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(selectedTab == tab ? Color(red: 44/255, green: 44/255, blue: 44/255) : Color(red: 120/255, green: 125/255, blue: 136/255))
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 24)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .overlay(Color.white.opacity(0.9))
        )
        .opacity(1.0)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .shadow(color: Color.black.opacity(0.08), radius: 8, y: 2)
        .padding(.horizontal, 32)
        .padding(.bottom, 24)
    }
} 
