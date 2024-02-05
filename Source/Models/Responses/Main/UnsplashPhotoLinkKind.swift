import Foundation

struct UnsplashPhotoLinkKind: Codable {
    let own: String?
    let html: String?
    let download: String?
    let downloadLocation: String?
    
    private enum CodingKeys: String, CodingKey {
        case own = "self"
        case html
        case download
        case downloadLocation = "download_location"
    }
}
