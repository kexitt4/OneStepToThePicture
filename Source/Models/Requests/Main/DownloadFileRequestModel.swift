import Foundation

struct DownloadFileRequestModel {
    let url: URL
    let destination: URL
    
    init (url: URL, name: String?) {
        self.url = url
        self.destination = DownloadFileRequestModel.generateDestinationUrl(forFileUrl: url, name: name)
    }
    
    private static func generateDestinationUrl(forFileUrl url: URL, name: String?) -> URL {
        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).last!
        
        let fileExtension: String
        if !url.pathExtension.isEmpty {
            fileExtension = url.pathExtension
        } else if let nameExtension = name?.split(separator: ".").last {
            fileExtension = String(nameExtension)
        } else {
            fileExtension = ""
        }
        
        if let name = name, !name.isEmpty, !fileExtension.isEmpty {
            return directory.appendingPathComponent(name + "." + fileExtension)
        } else {
            return directory.appendingPathComponent(url.absoluteString)
        }
    }
}
