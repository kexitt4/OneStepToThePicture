import Foundation

struct SearchPhotosResponse: Codable {
    let total: Int
    let totalPages: Int
    let results: [UnsplashPhotoModel]
    
    private enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}
