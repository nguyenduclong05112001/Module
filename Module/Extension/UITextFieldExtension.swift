//
//  UITextFieldExtension.swift
//  LS
//
//  Created by macmini on 08/11/2023.
//

import Foundation
import UIKit

extension UITextField {
    func addDoneButton(title: String, target: Any, selector: Selector) {
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: false)
        toolBar.sizeToFit()
        self.inputAccessoryView = toolBar
    }
}
