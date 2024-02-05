import UIKit

extension UIView {
    var rootView: UIView { getRootView() }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { view in
            self.addSubview(view)
        }
    }
    
    private func getRootView() -> UIView {
        var view: UIView = self
        while let superview = view.superview {
            view = superview
        }
        return view
    }
}
