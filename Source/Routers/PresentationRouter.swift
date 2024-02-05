import UIKit

protocol PresentationRouter: AnyObject {
    func present(controller: UIViewController, isAnimated: Bool, completion: Closure.Void?)
    func dismiss(isAnimated: Bool, completion: Closure.Void?)
    func showErrorAlert(title: String, message: String)
}

extension UIViewController: PresentationRouter {
    func present(controller: UIViewController, isAnimated: Bool = true, completion: Closure.Void? = nil) {
        present(controller, animated: isAnimated, completion: completion)
    }
    
    func dismiss(isAnimated: Bool = true, completion: Closure.Void? = nil) {
        dismiss(animated: isAnimated, completion: completion)
    }
    
    func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))

        present(controller: alert, isAnimated: true, completion: nil)
    }
}
