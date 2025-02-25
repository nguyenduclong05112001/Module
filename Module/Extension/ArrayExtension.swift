//
//  ArrayExtension.swift
//  LS
//
//  Created by Tinh Nguyen on 1/10/24.
//

import UIKit

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
