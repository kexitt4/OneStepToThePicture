import UIKit
import SnapKit

struct MainPhotoViewItem: Codable {
    let id: String
    let width: Int
    let height: Int
    let titleName: String?
    let description: String?
    let previewUrl: URL
    let url: URL
    
}

extension MainPhotoViewItem {
    var isFavorite: Bool {
        AppData.favoritesItems[id] != nil
    }
    
    var favoriteImage: UIImage? {
        let name = isFavorite ? "FavoriteFilled" : "FavoriteLite"
        
        return UIImage(named: name)
    }
}

final class MainPhotoViewView: BaseView {
    private lazy var imageView = UIImageView()
    private lazy var favoriteImageView = UIImageView()

    override func initSetup() {
        super.initSetup()

        setupViews()
        layoutViews()
    }
    
    func setup(with item: MainPhotoViewItem, cellWidth: CGFloat) {
        let imageSize = CGSize(width: cellWidth, height: cellWidth)
        imageView.setCropImage(with: item.previewUrl, imageSize: imageSize)
        favoriteImageView.isHidden = item.isFavorite == false
    }
    
    private func setupViews() {
        favoriteImageView.isHidden = true
        favoriteImageView.image = UIImage(named: "FavoriteFilled")?.withRenderingMode(.alwaysTemplate)
        favoriteImageView.tintColor = .red
    }

    private func layoutViews() {
        addSubviews(imageView, favoriteImageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        favoriteImageView.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(8)
            make.size.equalTo(24)
        }
    }
}
