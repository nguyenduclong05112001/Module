//
//  DynamicHeightCollectionView.swift
//  LS
//
//  Created by Long Han on 9/8/23.
//

import Foundation
import UIKit

public class DynamicHeightCollectionView: UICollectionView {
    public override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }

    public override func reloadData() {
        super.reloadData()
        
        self.layoutIfNeeded()
        self.invalidateIntrinsicContentSize()
        self.frame.size.height = self.collectionViewLayout.collectionViewContentSize.height
        
    }

    public override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
