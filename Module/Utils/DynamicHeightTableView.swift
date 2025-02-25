//
//  DynamicHeightTableView.swift
//  iHP
//
//  Created by Long Han on 07/21/23.
//  Copyright © 2022 Lozi. All rights reserved.
//

import UIKit

public class DynamicHeightTableView: UITableView {
    public override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }
    
    public override var contentSize: CGSize {
        didSet{
            self.invalidateIntrinsicContentSize()
        }
    }
    
    public override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.frame.size.height = self.contentSize.height
    }
}
