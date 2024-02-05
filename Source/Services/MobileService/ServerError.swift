import Foundation

struct ErrorDetails {
    var statusCode: Int?
    var title = "Erorr"
    var message = "Something was wrang"
    var error: Error?
}

enum ServerError: Error {
    /// statusCode: 401
    case unauthorized(details: ErrorDetails)
    
    /// statusCode: 504
    case gatewayTimeOut(details: ErrorDetails)
    
    case unknown(details: ErrorDetails)
    case systemError(details: ErrorDetails)
    
    var details: ErrorDetails {
        switch self {
        case let .unauthorized(details):
            return details
        case let .gatewayTimeOut(details):
            return details
        case let .unknown(details):
            return details
        case let .systemError(details):
            return details
        }
    }
    
    static func handle(with responceCode: Int, errorResponse: ErrorResponse?, error: Error) -> ServerError {
        var errorDetails = ErrorDetails()
        errorDetails.statusCode = responceCode
        
        if let errorMessage = getErrorMessage(for: errorResponse) {
            errorDetails.message = errorMessage
        }
        
        let serverError: ServerError
        switch responceCode {
        case 200:
            errorDetails.message = "Decoding Error"
            errorDetails.error = error
            serverError = .systemError(details: errorDetails)
        case 401:
            serverError = .unauthorized(details: errorDetails)
        case 504:
            errorDetails.message = "Gateway Time-out"
            errorDetails.error = error
            serverError = .gatewayTimeOut(details: errorDetails)
        default:
            errorDetails.error = error
            serverError = .unknown(details: errorDetails)
        }
        
        return serverError
    }
    
    private static func getErrorMessage(for errorResponse: ErrorResponse?) -> String? {
        guard let errorResponse, let errors = errorResponse.errors, !errors.isEmpty else {
            return nil
        }
        
        var errorMessage = ""
        for (index, message) in errors.enumerated() {
            if !message.isEmpty {
                errorMessage += message
            }
            
            if !errorMessage.isEmpty, index < errors.count - 1 {
                errorMessage += "\n"
            }
        }
        
        return errorMessage.isEmpty ? nil : errorMessage
    }
}
