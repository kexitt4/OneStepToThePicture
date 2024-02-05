import Foundation

struct ListPhotosRequestModel: Codable, RequestParameters {
    let page: Int
    let perPage: Int
    var orderBy: String
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case orderBy = "order_by"
    }
    
    init(page: Int, perPage: Int, orderBy: ListPhotosOrderBy = .latest) {
        self.page = page
        self.perPage = perPage
        self.orderBy = orderBy.rawValue
    }
    
    var parameters: [String: Any] {
        [
            "page": page,
            "per_page": perPage,
            "order_by": orderBy
        ]
    }
}

enum ListPhotosOrderBy: String, Codable {
    case latest
    case oldest
    case popular
}
