import Foundation
import Moya

final class MobileService {
    private let provider: MoyaProvider<MobileApi>

    init(provider: MoyaProvider<MobileApi>) {
        self.provider = provider
    }
    
    func listPhotos(model: ListPhotosRequestModel) async throws -> [UnsplashPhotoModel] {
        return try await provider.async.request(.listPhotos(model: model))
    }
    
    func searchPhotos(model: SearchPhotosRequestModel) async throws -> SearchPhotosResponse {
        return try await provider.async.request(.searchPhotos(model: model))
    }
    
    func downlodFile(model: DownloadFileRequestModel) async throws -> URL {
        return try await provider.async.requestDownload(.downloadFile(model: model), destination: model.destination)
    }
}
