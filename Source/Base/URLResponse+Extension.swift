import Foundation

extension URLResponse {
    func headerField(forKey key: String) -> String? {
        (self as? HTTPURLResponse)?.allHeaderFields[key] as? String
    }
}
