import Foundation

struct UnsplashPhotoModel: Codable {

    let id: String
    let height: Int
    let width: Int
    let color: String?
    let user: UnsplashPhotoUser?
    let description: String?
    let altDescription: String?
    let urls: UnsplashPhotoUrlKind?
    let links: UnsplashPhotoLinkKind?
    let likesCount: Int?
    let downloadsCount: Int?
    let viewsCount: Int?

    private enum CodingKeys: String, CodingKey {
        case id
        case height
        case width
        case color
        case user
        case description
        case altDescription = "alt_description"
        case urls
        case links
        case likesCount = "likes"
        case downloadsCount = "downloads"
        case viewsCount = "views"
    }
    
}

extension UnsplashPhotoModel {
    var asViewItem: MainPhotoViewItem? {
        guard let smallUrl = urls?.small, let previewUrl = URL(string: smallUrl),
              let fullUrl = urls?.full, let url = URL(string: fullUrl) else {
            return nil
        }
        
        return MainPhotoViewItem(
            id: id,
            width: width,
            height: height,
            titleName: user?.titleName,
            description: description ?? altDescription,
            previewUrl: previewUrl,
            url: url
        )
    }
}
