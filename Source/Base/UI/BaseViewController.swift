import UIKit

class BaseView: Utils.BaseView, CodeInitable {}

class BaseViewController<ViewModel>: UIViewController {
    let viewModel: ViewModel
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
