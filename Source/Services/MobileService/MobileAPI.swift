import Foundation
import Moya

protocol RequestParameters {
    var parameters: [String: Any] { get }
}

enum MobileApi {
    enum Constant {
        enum Unsplash {
            static var accessKey = "MgfhMfy8uAy0bTFNQnxjRaktswXst8ed_OLvM1E6Bxo"
            static var secretKey = "Vs8A-_OWCBBF9OI4NMQFf7YIiAurvq5zHA0VnCasdTM"
        }
        
        enum Base {
            static var baseURL = URL(fileURLWithPath: "https://api.unsplash.com")
            static var headerClient = "Client-ID \(Unsplash.accessKey)"
        }
    }
    
    case listPhotos(model: ListPhotosRequestModel)
    case searchPhotos(model: SearchPhotosRequestModel)
    case downloadFile(model: DownloadFileRequestModel)
}

extension MobileApi: TargetType {
    var baseURL: URL { getBaseURL() }
    var path: String { getPath() }
    var method: Moya.Method { getMethod() }
    var task: Moya.Task { getTask() }
    var headers: [String : String]? { getHeaders() }
    
    private func getBaseURL() -> URL {
        guard case let .downloadFile(model) = self else {
            return Constant.Base.baseURL
        }
        
        return model.url
    }
    
    private func getPath() -> String {
        switch self {
        case .listPhotos:
            return "/photos"
        case .searchPhotos:
            return "/search/photos"
        case .downloadFile:
            return ""
        }
    }
    
    private func getMethod() -> Moya.Method {
        switch self {
        case .listPhotos, .searchPhotos, .downloadFile:
            return .get
        }
    }
    
    private func getTask() -> Task {
        switch self {
        case let .downloadFile(model):
            let destination: DownloadDestination = { _, _ in
                (model.destination, [.removePreviousFile, .createIntermediateDirectories])
            }
            
            return .downloadDestination(destination)
        case let .listPhotos(model):
            return .requestParameters(
                parameters: model.parameters,
                encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets, boolEncoding: .literal)
            )
        case let .searchPhotos(model):
            return .requestParameters(
                parameters: model.parameters,
                encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets, boolEncoding: .literal)
            )
        }
    }
    
    private func getHeaders() -> [String: String]? {
        switch self {
        case .downloadFile:
            return [:]
        default: 
            return [
                "Content-Type": "application/json",
                "Authorization": Constant.Base.headerClient,
                "Accept-Language": "en-US,en;q=0.9",
            ]
        }
    }
}
