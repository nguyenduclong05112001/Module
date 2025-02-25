//
//  UIRelativeScalingExtensions.swift
//  LS
//
//  Created by macmini on 04/08/2023.
//

import UIKit

//Adjust these when the design is provided
let screenDesignHeight: CGFloat = 729 + 83
let screenDesignWidth: CGFloat = 375

let screenWidth: CGFloat = UIScreen.main.bounds.width
let screenHeigh: CGFloat = UIScreen.main.bounds.height

extension CGFloat {
    var width: CGFloat {
        return floor(self * screenWidth / screenDesignWidth)
    }
    
    var height: CGFloat {
        return floor(self * screenHeigh / screenDesignHeight)
    }
}

extension Int {
    var width: CGFloat {
        return floor(CGFloat(self) * screenWidth / screenDesignWidth)
    }
    
    var height: CGFloat {
        return floor(CGFloat(self) * screenHeigh / screenDesignHeight)
    }
}

extension Double {
    var width: CGFloat {
        return floor(CGFloat(self) * screenWidth / screenDesignWidth)
    }
    
    var height: CGFloat {
        return floor(CGFloat(self) * screenHeigh / screenDesignHeight)
    }
}

