//
//  CollectionExtension.swift
//  LS
//
//  Created by macmini on 27/8/24.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
