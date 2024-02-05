import Foundation

func onMain(execute: @escaping Closure.Void) {
    DispatchQueue.main.async(execute: execute)
}
