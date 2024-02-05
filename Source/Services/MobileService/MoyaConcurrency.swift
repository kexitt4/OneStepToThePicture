import Foundation
import Moya

extension MoyaProvider {
    var async: MoyaConcurrency {
        MoyaConcurrency(provider: self)
    }
    
    class MoyaConcurrency {
        private let provider: MoyaProvider
        
        init(provider: MoyaProvider) {
            self.provider = provider
        }
        
        func request<T: Decodable>(_ target: Target) async throws -> T {
            return try await withCheckedThrowingContinuation { continuation in
                provider.request(target) { [weak self] result in
                    switch result {
                    case .success(let response):
                        self?.handleRequestSuccess(
                            response: response,
                            continuation: continuation
                        )
                    case .failure(let error):
                        let details = ErrorDetails(error: error)
                        let serverError = ServerError.unknown(details: details)
                        continuation.resume(throwing: serverError)
                    }
                }
            }
        }
        
        func requestDownload(_ target: Target, destination: URL) async throws -> URL {
            return try await withCheckedThrowingContinuation { continuation in
                provider.request(target) { [weak self] result in
                    switch result {
                    case .success(let response):
                        self?.handleFileRequestSuccess(
                            response: response,
                            destination: destination,
                            continuation: continuation
                        )
                    case .failure(let error):
                        let details = ErrorDetails(error: error)
                        let serverError = ServerError.unknown(details: details)
                        continuation.resume(throwing: serverError)
                    }
                }
            }
        }
        
        private func handleRequestSuccess<T: Decodable>(
            response: Response,
            continuation: CheckedContinuation<T, Error>
        ) {
            do {
                let filteredResponse = try response.filterSuccessfulStatusCodes()
                let decodedResponse = try filteredResponse.map(T.self)
                
                continuation.resume(returning: decodedResponse)
            } catch let error {
                let errorResponse = try? response.map(ErrorResponse.self)
                let serverError = ServerError.handle(
                    with: response.statusCode,
                    errorResponse: errorResponse,
                    error: error
                )
                continuation.resume(throwing: serverError)
            }
        }
        
        private func handleFileRequestSuccess(
            response: Response,
            destination: URL,
            continuation: CheckedContinuation<URL, Error>
        ) {
            do {
                let filteredResponse = try response.filterSuccessfulStatusCodes()
                let destinationDecodable = getDestination(response: filteredResponse, destination: destination)
                continuation.resume(returning: destinationDecodable)
            } catch let error {
                let errorResponse = try? response.map(ErrorResponse.self)
                let serverError = ServerError.handle(
                    with: response.statusCode,
                    errorResponse: errorResponse,
                    error: error
                )
                continuation.resume(throwing: serverError)
            }
        }
    }
}

// MARK: Private

fileprivate extension MoyaProvider {
    static func getDestination(response: Response, destination: URL) -> URL {
        guard let contentType = response.response?.headerField(forKey: "Content-Type"),
              contentType.contains("application/json") == false else {
            return destination
        }
        
        guard let fileExtention = getFileExtention(for: contentType) else {
            return destination
        }
        
        let newDestination = destination
            .deletingPathExtension()
            .appendingPathExtension(fileExtention)
        
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: newDestination.path) {
            do {
                try? fileManager.removeItem(at: newDestination)
            }
        }
        
        do {
            try fileManager.moveItem(at: destination, to: newDestination)
            return newDestination
        } catch {
            return destination
        }
    }
    
    static func getFileExtention(for contentType: String) -> String? {
        var fileExtention: String?
        
        if contentType.contains("image/jpeg") {
            fileExtention = "jpg"
        }
        
        if contentType.contains("text/plain") {
            fileExtention = "txt"
        }
        
        if contentType.contains("application/pdf") {
            fileExtention = "pdf"
        }
        
        if contentType.contains("application/rtf") {
            fileExtention = "rtf"
        }
        
        // Microsoft
        
        if contentType.contains("application/msword") {
            fileExtention = "doc"
        }
        
        if contentType.contains("application/vnd.openxmlformats-officedocument.wordprocessingml.document") {
            fileExtention = "docx"
        }
        
        if contentType.contains("application/vnd.ms-powerpoint") {
            fileExtention = "ppt"
        }
        
        if contentType.contains("application/vnd.openxmlformats-officedocument.presentationml.presentation") {
            fileExtention = "pptx"
        }
        
        if contentType.contains("application/vnd.ms-excel") {
            if #available(iOS 16.5.1, *) {
                fileExtention = "xlsx"
            } else {
                fileExtention = "xls"
            }
        }
        
        if contentType.contains("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") {
            fileExtention = "xlsx"
        }
        
        // Archive
        
        if contentType.contains("application/zip") {
            fileExtention = "zip"
        }
        
        if contentType.contains("application/x-7z-compressed") {
            fileExtention = "7z"
        }
        
        if contentType.contains("application/x-tar") {
            fileExtention = "tar"
        }
        
        if contentType.contains("application/vnd.rar") {
            fileExtention = "rar"
        }
        
        return fileExtention
    }
}
