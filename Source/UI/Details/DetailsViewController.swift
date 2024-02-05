import UIKit

final class DetailsViewController: BaseViewController<DetailsViewModel> {
    // MARK: UI elements
    
    private lazy var scrollView = UIScrollView()
    
    private lazy var scrollContentView = UIView()
    private lazy var imageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var downloadButton = UIButton()
    private lazy var favoriteButton = UIButton()
    private lazy var titleView = UIView()
    private lazy var descriptiontLabel = UILabel()
    
    private lazy var swipeLeft = UISwipeGestureRecognizer()
    private lazy var swipeRight = UISwipeGestureRecognizer()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        layoutViews()
        bindViewModel()
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        view.backgroundColor = UIColor.black
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.bounces = false
        
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 0
        
        descriptiontLabel.textAlignment = .left
        descriptiontLabel.font = UIFont.systemFont(ofSize: 16)
        descriptiontLabel.textColor = UIColor.white
        descriptiontLabel.numberOfLines = 0
        
        favoriteButton.isHidden = true
        favoriteButton.addTarget(self, action:  #selector(didTapFavoriteButton), for: .touchUpInside)
        
        downloadButton.setTitle("Download file", for: .normal)
        downloadButton.setTitleColor(.white, for: .normal)
        downloadButton.setTitleColor(.gray, for: .highlighted)
        downloadButton.addTarget(self, action: #selector(didTapDowloadButton), for: .touchUpInside)
        
        swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
                
        swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        
    }
    
    @objc private func didTapDowloadButton() {
        viewModel.downloadFile()
    }
    
    @objc private func didTapFavoriteButton() {
        viewModel.tapFavorite()
    }
    
    @objc private func handleGesture(gesture: UISwipeGestureRecognizer) {
       if gesture.direction == .right {
           viewModel.swipeItem(on: -1)
       }
       else if gesture.direction == .left {
           viewModel.swipeItem(on: 1)
       }
    }
    
    // MARK: Layout Views
    
    private func layoutViews() {
        view.addSubview(scrollView)
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
        
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        
        scrollView.addSubview(scrollContentView)
        
        scrollContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        scrollContentView.addSubviews(imageView, downloadButton, titleView, descriptiontLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        downloadButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(downloadButton.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(16)
        }
        
        titleView.addSubviews(titleLabel, favoriteButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(titleLabel.snp.right).inset(16)
            make.right.equalToSuperview()
            make.size.equalTo(20)
        }
        
        descriptiontLabel.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview().inset(16)
        }
    }
    
    // MARK: Bind
    
    private func bindViewModel() {
        viewModel.updateItem = { [weak self] item in
            self?.favoriteButton.isHidden = false
            let image = item.favoriteImage?.withTintColor(.red, renderingMode: .alwaysTemplate)
            
            self?.favoriteButton.setImage(image, for: .normal)
            self?.favoriteButton.tintColor = .red
            
            self?.setImage(for: item)
            self?.titleLabel.text = item.titleName
            self?.descriptiontLabel.text = item.description
            
            self?.view.setNeedsLayout()
            self?.view.layoutIfNeeded()
        }
    }
    
    private func setImage(for item: MainPhotoViewItem) {
        let screenWidth = UIScreen.main.bounds.width
        let k = CGFloat(item.width) / CGFloat(item.height)
        let height = item.width < item.height ? screenWidth / k : screenWidth * k
        let imageSize = CGSize(width: screenWidth, height: height)
        
        imageView.setImage(with: item.previewUrl, imageSize:imageSize, contentMode: .aspectFit)
    }
}
