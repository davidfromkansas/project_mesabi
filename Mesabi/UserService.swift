import Foundation
import FirebaseFirestore

/// Service for user-related Firestore operations
struct UserService {
    /// Creates a user profile in Firestore if it does not already exist.
    /// - Parameters:
    ///   - userId: The user's unique ID
    ///   - name: The user's name
    ///   - email: The user's email
    ///   - completion: Optional completion handler with error if any
    static func createUserProfileIfNeeded(userId: String, name: String, email: String, completion: ((Error?) -> Void)? = nil) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userId)
        userRef.getDocument { (document, error) in
            if let error = error {
                print("Error checking user profile: \(error)")
                completion?(error)
                return
            }
            if let document = document, document.exists {
                // User already exists, do nothing
                completion?(nil)
            } else {
                // Create new user profile
                userRef.setData([
                    "name": name,
                    "email": email,
                    "createdAt": Timestamp()
                ]) { error in
                    if let error = error {
                        print("Error creating user profile: \(error)")
                    } else {
                        print("User profile created!")
                    }
                    completion?(error)
                }
            }
        }
    }

    /// Returns the content type for a given URL string.
    /// - Parameter urlString: The URL string to classify
    /// - Returns: "Video", "Social Media", or "Articles"
    static func contentType(for urlString: String) -> String {
        guard let url = URL(string: urlString), let host = url.host?.lowercased() else {
            return "Articles" // Default fallback
        }
        // Video: Youtube and similar
        let videoDomains = ["youtube.com", "youtu.be"]
        if videoDomains.contains(where: { host.contains($0) }) {
            return "Video"
        }
        // Social Media: x.com, twitter.com, instagram.com, facebook.com, linkedin.com, tiktok.com, etc.
        let socialMediaDomains = [
            "x.com", "twitter.com", "instagram.com", "facebook.com", "linkedin.com", "tiktok.com", "snapchat.com", "reddit.com", "pinterest.com", "threads.net"
        ]
        if socialMediaDomains.contains(where: { host.contains($0) }) {
            return "Social Media"
        }
        // Default to Articles
        return "Articles"
    }

    /// Saves a URL to the user's profile in Firestore under a 'bookmarks' array.
    /// - Parameters:
    ///   - userId: The user's unique ID
    ///   - bookmark: The URL to save
    ///   - completion: Optional completion handler with error if any
    static func saveBookmarkToUserProfile(userId: String, bookmark: String, completion: ((Error?) -> Void)? = nil) {
        // Validate the bookmark string is a valid URL
        guard let url = URL(string: bookmark), url.scheme != nil, url.host != nil else {
            let error = NSError(domain: "UserService", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL string"])
            print("Invalid bookmark URL: \(bookmark)")
            completion?(error)
            return
        }
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userId)
        let contentType = contentType(for: bookmark)
        let bookmarkObject: [String: Any] = [
            "url": bookmark,
            "savedAt": Timestamp(),
            "contentType": contentType
        ]
        userRef.updateData([
            "bookmarks": FieldValue.arrayUnion([bookmarkObject])
        ]) { error in
            if let error = error {
                print("Error saving bookmark to user profile: \(error)")
            } else {
                print("Bookmark saved to user profile!")
            }
            completion?(error)
        }
    }
} 