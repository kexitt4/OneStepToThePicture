import Foundation

enum DetailsFactory {
    static func createDetailsController(
        currentIndex: Int, items: [MainPhotoViewItem], updatePhotos: Closure.Void?
    ) ->DetailsViewController {
        let coordinator = DetailsCoordinator()
        let viewModel = DetailsViewModel(
            coordinator: coordinator,
            currentIndex: currentIndex,
            items: items,
            updatePhotos: updatePhotos
        )
        let controller = DetailsViewController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
