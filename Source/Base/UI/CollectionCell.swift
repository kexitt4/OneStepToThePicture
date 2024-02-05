//
//  CollectionCell.swift
//  OneStepToThePicture
//
//  Created by Ilya Hryshuk on 5.02.24.
//

import UIKit

class CollectionCell<T: Initable & BaseView>: UICollectionViewCell, CodeInitable {
    weak var customView: T?
    var customViewInsets: LayoutInsets { .zero }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initSetup()
    }
        
    func initSetup() {
        let view = T.initiate()
        
        contentView.layoutSubview(view, with: customViewInsets)
        customView = view
    }
}
