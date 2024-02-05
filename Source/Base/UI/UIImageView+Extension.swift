import UIKit
import Kingfisher

extension UIImageView {
    func setImage(
        with url: URL?,
        placeholder: UIImage? = nil,
        imageSize: CGSize? = nil,
        contentMode: Kingfisher.ContentMode = .aspectFill
    ) {
        kf.setImage(
            with: url,
            placeholder: placeholder,
            options: getOptions(imageSize: imageSize, contentMode: contentMode)
        )
    }
    
    func setCropImage(
        with url: URL?,
        placeholder: UIImage? = nil,
        imageSize: CGSize? = nil
    ) {
        kf.setImage(
            with: url,
            placeholder: placeholder,
            options: getCropOptions(imageSize: imageSize)
        )
    }

    private func getOptions(
        imageSize: CGSize? = nil,
        contentMode: Kingfisher.ContentMode = .aspectFill
    ) -> KingfisherOptionsInfo? {
        if let imageSize = imageSize {
            let processor = ResizingImageProcessor(referenceSize: imageSize, mode: contentMode)
            return [
                .scaleFactor(UIScreen.main.scale),
                .processor(processor),
                .transition(.fade(0.3)),
                .cacheOriginalImage
            ]
        }
        return nil
    }
    
    private func getCropOptions(imageSize: CGSize? = nil) -> KingfisherOptionsInfo? {
        if let imageSize = imageSize {
            let processor = CroppingImageProcessor(size: imageSize)
            return [
                .scaleFactor(UIScreen.main.scale),
                .processor(processor),
                .transition(.fade(0.3)),
                .cacheOriginalImage
            ]
        }
        return nil
    }
}
