import Foundation

final class MainCoordinator {
    weak var router: PresentationRouter?
    
    func showErrorAlert(title: String, message: String) {
        router?.showErrorAlert(title: title, message: message)
    }
    
    func openDetails(currentIndex: Int, items: [MainPhotoViewItem], updatePhotos: Closure.Void?) {
        let controller = DetailsFactory.createDetailsController(
            currentIndex: currentIndex, items: items, updatePhotos: updatePhotos
        )
        
        router?.present(controller: controller, isAnimated: true, completion: nil)
    }
}
