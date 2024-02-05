import Foundation

struct SearchPhotosRequestModel: Codable, RequestParameters {
    let page: Int
    let perPage: Int
    let query: String
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case query
    }
    
    var parameters: [String: Any] {
        [
            "page": page,
            "per_page": perPage,
            "query": query
        ]
    }
}
