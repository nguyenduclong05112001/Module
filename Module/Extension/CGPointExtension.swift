//
//  CGPointExtension.swift
//  LS
//
//  Created by macmini on 02/10/2023.
//

import Foundation

extension CGPoint {
    func scaled(to size: CGSize) -> CGPoint {
        return CGPoint(x: self.x * size.width,
                       y: self.y * size.height)
    }
}
