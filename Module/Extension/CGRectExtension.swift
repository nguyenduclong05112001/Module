//
//  CGRectExtension.swift
//  LS
//
//  Created by macmini on 31/08/2023.
//

import Foundation

extension CGRect {
    var topRight: CGPoint { CGPoint(x: maxX, y: minY) }
    var topLeft: CGPoint { CGPoint(x: minX, y: minY) }
    var bottomRight: CGPoint { CGPoint(x: maxX, y: maxY) }
    var bottomLeft: CGPoint { CGPoint(x: minX, y: maxY) }
}
