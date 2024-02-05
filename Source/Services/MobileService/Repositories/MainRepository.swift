import Foundation
import Moya

final class MainRepository {
    private let mobileService = MobileService(provider: MoyaProvider<MobileApi>())
    
    func listPhotos(model: ListPhotosRequestModel) async throws -> [UnsplashPhotoModel] {
        let response = try await mobileService.listPhotos(model: model)
        return response
    }
    
    func searchPhotos(model: SearchPhotosRequestModel) async throws -> SearchPhotosResponse {
        let response = try await mobileService.searchPhotos(model: model)
        return response
    }
    
    func downlodFile(model: DownloadFileRequestModel) async throws -> URL {
        let response = try await mobileService.downlodFile(model: model)
        return response
    }
}
