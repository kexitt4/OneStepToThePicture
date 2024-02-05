import UIKit

enum MainFactory {
    static func createMainController() -> MainViewController {
        let coordinator = MainCoordinator()
        let viewModel = MainViewModel(coordinator: coordinator)
        let controller = MainViewController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
