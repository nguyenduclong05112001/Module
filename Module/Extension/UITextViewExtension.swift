//
//  UITextViewExtension.swift
//  LS
//
//  Created by macmini on 06/11/2023.
//

import Foundation
import UIKit

extension UITextView {
    func addDoneButton(title: String, target: Any, selector: Selector) {
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    func neededHeightWithWidth(_ width: CGFloat) -> CGFloat {
           let textWidth = self.frame.width -
           self.textContainerInset.left -
           self.textContainerInset.right -
           self.textContainer.lineFragmentPadding * 2.0 -
           self.contentInset.left -
           self.contentInset.right
           
           let maxSize = CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude)
           
           let attributedText: NSAttributedString
           if let text = self.attributedText, text.length > 0 {
               attributedText = text
           }
           else {
               attributedText = NSAttributedString(string: "XXX", attributes: typingAttributes)
           }
           
           var calculatedSize = attributedText.boundingRect(with: maxSize,
                                                                 options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                         context: nil).size
           calculatedSize.height += self.textContainerInset.top
           calculatedSize.height += self.textContainerInset.bottom
           
           return ceil(calculatedSize.height)
       }
}
