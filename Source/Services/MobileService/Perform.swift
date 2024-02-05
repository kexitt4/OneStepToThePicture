//
//  Perform.swift
//  OneStepToThePicture
//
//  Created by Ilya Hryshuk on 4.02.24.
//

import Foundation

struct Perform {
    @discardableResult
    init(
        operation: @escaping () async throws -> Void,
        onError: Closure.Generic<ServerError>? = nil
    ) {
        Task {
            do {
                try await operation()
            } catch let error {
                let serverError = error as? ServerError ?? .unknown(details: ErrorDetails(error: error))
                Perform.log(serverError)
                
                onMain { onError?(serverError) }
            }
        }
    }
   
    private static func log(_ serverError: ServerError) {
        let msg = """
        <--
        Error: \(serverError)
        Status code: \(serverError.details.statusCode as Any)
        <--
        """
        
        print(msg)
    }
}
