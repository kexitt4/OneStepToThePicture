import Foundation

final class MainViewModel {
    private enum Constants {
        static var perPage = 30
    }
    
    var datasource = [MainPhotoViewItem]()
    var updateCollectionView: Closure.Void?
    
    private let coordinator: MainCoordinator
    private let mainRepository = MainRepository()
    private var page = 0
    private var hasMore = true
    private var isLoading = false
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        
        loadPhotos()
    }
    
    func handleCardCellTap(index: Int) {
        coordinator.openDetails(
            currentIndex: index,
            items: datasource,
            updatePhotos: { [weak self] in self?.updateCollectionView?() }
        )
    }
    
    func loadNext() {
        guard hasMore, isLoading == false else {
            return
        }
        
        loadPhotos()
    }
    
    private func loadPhotos() {
        Perform { [weak self] in
            guard let self else {
                return
            }
            self.isLoading = true
            let model = ListPhotosRequestModel(
                page: self.page, perPage: Constants.perPage
            )
            let responce = try await mainRepository.listPhotos(model: model)
            self.hasMore = responce.count <= Constants.perPage
            if self.hasMore {
                self.page += 1
            }
            
            self.datasource.append(contentsOf: responce.compactMap { $0.asViewItem } )
            self.isLoading = false
            onMain { self.updateCollectionView?() }
        } onError: { [weak self] serverError in
            self?.isLoading = false
            onMain {
                self?.coordinator.showErrorAlert(
                    title: serverError.details.title,
                    message: serverError.details.message
                )
            }
        }
    }
}
