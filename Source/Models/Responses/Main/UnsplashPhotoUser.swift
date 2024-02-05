import Foundation

struct UnsplashPhotoUser: Codable {
    let id: String
    let username: String?
    let name: String?
}

extension UnsplashPhotoUser {
    var titleName: String {
        if let name {
            return name
        }
        
        if let username {
            return username
        }
        
        return id
    }
}
