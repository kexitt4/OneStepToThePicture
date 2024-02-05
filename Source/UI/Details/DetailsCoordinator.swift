import UIKit

final class DetailsCoordinator {
    weak var router: PresentationRouter?
    
    func dissmiss(title: String, message: String) {
        router?.dismiss(isAnimated: true, completion: nil)
    }
    
    func share(items: [Any]) {
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        router?.present(controller: activityController, isAnimated: true, completion: nil)
    }
    
    func showErrorAlert(title: String, message: String) {
        router?.showErrorAlert(title: title, message: message)
    }
}
