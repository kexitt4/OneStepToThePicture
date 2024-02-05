import UIKit
import SnapKit

final class MainViewController: BaseViewController<MainViewModel> {
    // MARK: Constants
    
    private enum Constants {
        static let columSpacing: CGFloat = 16
    }
    
    // MARK: UI elements
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
    
    private let sizingCell = MainPhotoCell()
    private var cellWidth: CGFloat = .zero
    
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
        
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.backgroundColor = UIColor.black
        collectionView.register(MainPhotoCell.self, forCellWithReuseIdentifier: MainPhotoCell.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: Layout Views
    
    private func layoutViews() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
    }
    
    // MARK: Bind
    
    private func bindViewModel() {
        viewModel.updateCollectionView = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
}

// MARK: UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.handleCardCellTap(index: indexPath.row)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        if indexPath.row == viewModel.datasource.count - 1 {
            viewModel.loadNext()
        }
    }
}

// MARK: UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView, 
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.datasource.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainPhotoCell.reuseId, 
            for: indexPath
        ) as? MainPhotoCell
        
        guard let cell, indexPath.row < viewModel.datasource.count else {
            return UICollectionViewCell(frame: .zero)
        }
        
        let item = viewModel.datasource[indexPath.row]
        cell.setup(with: item, cellWidth: cellWidth)
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        let spacing = Constants.columSpacing
        
        return UIEdgeInsets(top: 0, left: spacing, bottom: spacing, right: spacing)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if cellWidth == .zero {
            let spacing = Constants.columSpacing * 3
            let frameSizeWidth = collectionView.frame.size.width
            cellWidth = (frameSizeWidth - spacing) / 2
        }
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
