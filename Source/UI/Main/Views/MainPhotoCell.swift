import UIKit
import SnapKit

final class MainPhotoCell: CollectionCell<MainPhotoViewView> {
    override var customViewInsets: LayoutInsets { .insets(top: 0, left: 0, bottom: 0, right: 0) }
    
    override func initSetup() {
        super.initSetup()
        
        customView?.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setup(with item: MainPhotoViewItem, cellWidth: CGFloat) {
        customView?.setup(with: item, cellWidth: cellWidth)
    }
}
