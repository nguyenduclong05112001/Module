//
//  LabelExtension.swift
//  LS
//
//  Created by macmini on 04/08/2023.
//

import UIKit

extension UILabel {
    func configSizeToFit() {
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        sizeToFit()
    }

    func redDot(colorTextPart: String = "*", color: UIColor? = .red) {
        guard let string = self.text, let color = color else {
            return
        }
        attributedText = nil
        let result = NSMutableAttributedString(string: string)
        result.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSString(string: string.lowercased()).range(of: colorTextPart.lowercased()))
        attributedText = result
    }


    
    func addUnderline() {
        DispatchQueue.main.async {
            self.removeUnderline()
            let attributedString = NSMutableAttributedString.init(string: self.text ?? "")
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length));
            self.attributedText = attributedString
        }
    }
    func removeUnderline() {
        let attributedString = NSMutableAttributedString.init(string: text ?? "")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 0, range: NSRange.init(location: 0, length: attributedString.length));
        attributedText = attributedString
    }
    
    func widthOfLabel() -> CGFloat {
        let textSize = CGSize.init(width: CGFloat(MAXFLOAT), height: 10)
        return sizeThatFits(textSize).width
    }
    
    func widthOfLabelV2(height: CGFloat) -> CGFloat {
        let textSize = CGSize.init(width: CGFloat(MAXFLOAT), height: height)
        return sizeThatFits(textSize).width
    }
    
    func heightOfLabel() -> CGFloat {
//        let textSize = CGSize.init(width: frame.size.width, height: CGFloat(MAXFLOAT))
//        return sizeThatFits(textSize).height
        
        guard let label = self as? UILabel else { return 0 }
        
        label.numberOfLines = 0
        let textSize = CGSize(width: label.frame.size.width, height: CGFloat(MAXFLOAT))
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        var boundingRect: CGRect = .zero
        
        if let attributedText = label.attributedText {
            boundingRect = attributedText.boundingRect(with: textSize, options: options, context: nil)
        } else if let text = label.text, let font = label.font {
            let attributes: [NSAttributedString.Key: Any] = [.font: font]
            boundingRect = text.boundingRect(with: textSize, options: options, attributes: attributes, context: nil)
        }
        
        return ceil(boundingRect.height)
    }
    
    func calculateVisibleLinesAndHeightAfterLayout() -> (visibleLines: Int, requiredHeight: CGFloat) {
        // Bắt buộc layout để đảm bảo UILabel có kích thước chính xác
        self.superview?.layoutIfNeeded()
        
        guard let text = self.text, let font = self.font else {
            return (0, 0)
        }
        
        // Kích thước tối đa (sử dụng chiều rộng hiện tại của UILabel)
        let maxSize = CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        
        // Tính boundingRect của văn bản
        let textHeight = text.boundingRect(
            with: maxSize,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        ).height
        
        // Chiều cao của một dòng văn bản
        let lineHeight = font.lineHeight
        
        // Tính số dòng thực tế
        let numberOfLines = Int(ceil(textHeight / lineHeight))
        
        // Nếu UILabel có `numberOfLines` giới hạn, tính số dòng hiển thị thực tế
        let visibleLines = self.numberOfLines > 0 ? min(numberOfLines, self.numberOfLines) : numberOfLines
        
        // Tính chiều cao cần thiết dựa trên số dòng hiển thị
        let requiredHeight = CGFloat(visibleLines) * lineHeight
        
        return (visibleLines, requiredHeight)
    }
    
    func heightForLabel() -> CGFloat {
        guard let text = self.text else {
            return 0
        }
        
        let maxSize = CGSize(width: self.frame.width, height: CGFloat.greatestFiniteMagnitude)
        let textAttributes: [NSAttributedString.Key: Any] = [.font: self.font as Any]
        
        let boundingRect = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: textAttributes, context: nil)
        
        return ceil(boundingRect.height)
    }
    
    func heightOfLabelV2(_ width: CGFloat,_ fontV2: UIFont?) -> CGFloat {
        guard let text = text else {
                return 0
        }
        return text.heightWithConstrainedWidth(width: width, font: self.font)
    }
    
    var numberOfVisibleLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let textHeight = sizeThatFits(maxSize).height
        let lineHeight = font.lineHeight
        return Int(Double(textHeight / lineHeight).customRound(.toNearestOrAwayFromZero, precision: .hundredths)) //Int(ceil(textHeight / lineHeight))
    }
    
    
    func getWith(height: CGFloat) -> CGFloat {
        let textSize = CGSize.init(width: CGFloat(MAXFLOAT), height: height)
        return sizeThatFits(textSize).width
    
    }
    
    /// calculate height using number of visible lines
    /// numberOfVisibleLines * heightPerRow
    func calculateHeight(_ heightPerRow: CGFloat = 18.height) -> CGFloat {
        return CGFloat(self.numberOfVisibleLines) * heightPerRow
    }
}

extension UITextField {
    func widthOfTextField() -> CGFloat {
        let textSize = CGSize.init(width: CGFloat(MAXFLOAT), height: 10)
        return sizeThatFits(textSize).width
    }
    
    func heightOfTextField() -> CGFloat {
        let textSize = CGSize.init(width: frame.size.width, height: CGFloat(MAXFLOAT))
        return sizeThatFits(textSize).height
    }
}




extension UILabel {

    public func requiredHeight(for text: String, width: CGFloat, mininumLine: Int) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines =  mininumLine
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        label.font = font
        label.text = text
        label.sizeToFit()
        return label
    }

    
}
