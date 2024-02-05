import Foundation

final class DetailsViewModel {
    var updateItem: Closure.Generic<MainPhotoViewItem>?
    
    private let coordinator: DetailsCoordinator
    private let mainRepository = MainRepository()
    private var currentIndex: Int
    private var items: [MainPhotoViewItem]
    private var updatePhotos: Closure.Void?
    
    init(coordinator: DetailsCoordinator, currentIndex: Int, items: [MainPhotoViewItem], updatePhotos: Closure.Void?) {
        self.coordinator = coordinator
        self.currentIndex = currentIndex
        self.items = items
        self.updatePhotos = updatePhotos
        
        updateData()
    }
    
    func swipeItem(on value: Int) {
        var newIndex: Int? {
            let tempIndex = currentIndex + value
            if value > 0, tempIndex < items.count {
                return tempIndex
            }
            
            if value < 0, tempIndex > 0 {
                return tempIndex
            }
            
            return nil
        }
        
        guard let newIndex else {
            return
        }
        
        currentIndex = newIndex
        updateData()
    }
    
    func tapFavorite() {
        let id = items[currentIndex].id
        let isEmpty = AppData.favoritesItems[id] == nil
        AppData.favoritesItems[id] = isEmpty ? items[currentIndex] : nil
        
        onMain { [weak self] in
            guard let self else {
                return
            }
            self.updateItem?(self.items[currentIndex])
            self.updatePhotos?()
        }
    }
    
    func downloadFile() {
        let item = items[currentIndex]
        Perform { [weak self] in
            guard let self else {
                return
            }
            
            let fileName = item.titleName ?? "picture"
            
            let model = DownloadFileRequestModel(url: item.url, name: fileName)
            let responce = try await self.mainRepository.downlodFile(model: model)
            onMain { self.coordinator.share(items: [responce]) }
            
        } onError: { [weak self] serverError in
            onMain {
                self?.coordinator.showErrorAlert(
                    title: serverError.details.title,
                    message: serverError.details.message
                )
            }
        }
    }
    
    private func updateData() {
        let item = items[currentIndex]
        
        onMain { [weak self] in
            self?.updateItem?(item)
        }
    }
}
