//
//  UIViewExtension.swift
//  LS
//
//  Created by macmini on 04/08/2023.
//

import UIKit

//MARK: Gradient
enum GradientOrientation {
    case topRightBottomLeft
    case topLeftBottomRight
    case horizontal
    case vertical

    var startPoint: CGPoint {
        return points.startPoint
    }

    var endPoint: CGPoint {
        return points.endPoint
    }

    var points: GradientPoints {
        switch self {
        case .topRightBottomLeft:
            return (CGPoint(x: 0.0, y: 1.0), CGPoint(x: 1.0, y: 0.0))
        case .topLeftBottomRight:
            return (CGPoint(x: 0.0, y: 0.0), CGPoint(x: 1, y: 1))
        case .horizontal:
            return (CGPoint(x: 0.0, y: 0.5), CGPoint(x: 1.0, y: 0.5))
        case .vertical:
            return (CGPoint(x: 0.0, y: 0.0), CGPoint(x: 0.0, y: 1.0))
        }
    }
}

typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

private var UIViewKeyAssociationKey: UInt8 = 0
var originalBackgroundColors = [UIView: UIColor]()
var originalParentBackgroundColors = [UIView: UIColor]()
var originalTextColors = [UILabel: UIColor]()
var originalTintColors = [UIImageView: UIColor]()

extension UIViewController {

    func presentInFullScreen(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        if #available(iOS 13.0, *) {
            viewController.isModalInPresentation = true
        } else {
            // Fallback on earlier versions
        }
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: animated, completion: completion)
    }
}

extension UIView {
    // MARK: Show/hide
    func hide(isImmediate: Bool = false) {
//        DispatchQueue.main.async {
//            UIView.animate(withDuration: 0.25, delay: 0, options: .transitionCrossDissolve, animations: {
//                self.isHidden = isImmediate
//                self.layer.opacity = 0
//            }, completion: { finished in
//                self.isHidden = true
//            })
//        }
        self.isHidden = true
    }

    func show() {
//        DispatchQueue.main.async {
//            UIView.animate(withDuration: 0.25, delay: 0, options: .showHideTransitionViews, animations: {
//                self.isHidden = false
//                self.layer.opacity = 1
//            })
//        }
        self.isHidden = false
    }
    // MARK: Tap Gesture Recognizer
    fileprivate struct AssociatedObjectKey {
        static var tapGestureRecognizer = "Affina_AssociatedObjectKey_Affina"
    }

    fileprivate typealias Action = (() -> Void)?

    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedObjectKey.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKey.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }

    public func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handlerTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc fileprivate func handlerTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        }
        else {
            Logger.shared.Logs(message: "No action!!")
        }
    }
    
    func addOverlay(color: UIColor = UIColor.white.withAlphaComponent(0.8)) {
        let overlayView = UIView(frame: self.bounds)
        overlayView.backgroundColor = color
        overlayView.tag = 999 // Use a tag to identify the overlay later if needed
        overlayView.isUserInteractionEnabled = false // Make sure the overlay doesn't block interactions
        self.addSubview(overlayView)
    }
    
    func removeOverlay() {
        if let overlayView = self.viewWithTag(999) {
            overlayView.removeFromSuperview()
        }
    }
    
    func applyDisabledStyle(disabledColor: UIColor = UIColor.lightGray, disableBackgroundImage: Bool = true, disableParentBackground: Bool = false) {
        if disableParentBackground {
            self.backgroundColor = disabledColor
        }
        for subview in self.subviews {
            if let label = subview as? UILabel {
                label.textColor = disabledColor
            } 
            else if let imageView = subview as? UIImageView, !disableBackgroundImage {
                imageView.changeToColor(disabledColor)
//                if let image = imageView.image {
//                    imageView.image = image.withRenderingMode(.alwaysTemplate)
//                }
            } 
            else {
                subview.backgroundColor = disabledColor
            }
        }
    }
    
    func removeDisabledStyle(originalBackgroundColors: [UIView: UIColor], originalTextColors: [UILabel: UIColor], originalTintColors: [UIImageView: UIColor], originalParentBackgroundColors: [UIView: UIColor], disableBackgroundImage: Bool = true, disableParentBackground: Bool = false) {
        if disableParentBackground {
            self.backgroundColor = originalParentBackgroundColors[self]
        }
        for subview in self.subviews {
            if let label = subview as? UILabel {
                if let originalColor = originalTextColors[label] {
                    label.textColor = originalColor
                }
            } 
            else if let imageView = subview as? UIImageView, !disableBackgroundImage {
                if let originalColor = originalTintColors[imageView] {
                    imageView.changeToColor(originalColor)
                }
//                if let image = imageView.image {
//                    imageView.image = image//.withRenderingMode(.alwaysOriginal)
//                }
            } 
            else {
                if let originalColor = originalBackgroundColors[subview] {
                    subview.backgroundColor = originalColor
                }
            }
        }
    }
    
    func disabledView(_ disableParentTap: Bool = true, disableBackgroundImage: Bool = true, disableParentBackground: Bool = false) {
        // Store original colors
        if disableParentBackground {
            originalParentBackgroundColors[self] = self.backgroundColor
        }
        for subview in self.subviews {
            if let label = subview as? UILabel {
                originalTextColors[label] = label.textColor
            }
            else if let imageView = subview as? UIImageView {
                originalTintColors[imageView] = imageView.tintColor
            }
            else {
                originalBackgroundColors[subview] = subview.backgroundColor
            }
        }
        // Apply disabled style
        self.applyDisabledStyle(disabledColor: .lightGray, disableBackgroundImage: disableBackgroundImage, disableParentBackground: disableParentBackground)
        if let superview = self.superview, disableParentTap {
            superview.isUserInteractionEnabled = false
        }
        self.isUserInteractionEnabled = false
    }
    
    func enabledView(disableBackgroundImage: Bool = true) {
        // Restore original colors
        self.removeDisabledStyle(originalBackgroundColors: originalBackgroundColors, originalTextColors: originalTextColors, originalTintColors: originalTintColors, originalParentBackgroundColors: originalParentBackgroundColors, disableBackgroundImage: disableBackgroundImage)
        if let superview = self.superview {
            superview.isUserInteractionEnabled = true
        }
        self.isUserInteractionEnabled = true
    }



    // MARK: Shadow
    func dropShadow(color: UIColor, opacity: Float = 0.1, offset: CGSize, radius: CGFloat = 2, scale: Bool = true) {
        layer.masksToBounds = false
        clipsToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }
    
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        //        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topRight, .topRight], cornerRadii: CGSize(width: radius, height: radius))
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func cornerRadius(_ radius: CGFloat = 10) {
        self.layer.cornerRadius = radius
    }
    
    func topCornerRadius(_ radius: CGFloat = 10) {
        cornerRadius(radius)
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func topLeftCornerRadius(_ radius: CGFloat = 10) {
        cornerRadius(radius)
        self.layer.maskedCorners = [.layerMinXMinYCorner]
    }
    
    func topRightCornerRadius(_ radius: CGFloat = 10) {
        cornerRadius(radius)
        self.layer.maskedCorners = [.layerMaxXMinYCorner]
    }
    
    func bottomCornerRadius(_ radius: CGFloat = 10) {
        cornerRadius(radius)
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func bottomRightCornerRadius(_ radius: CGFloat = 10) {
        cornerRadius(radius)
        self.layer.maskedCorners = [.layerMaxXMaxYCorner]
    }
    
    func bottomLeftCornerRadius(_ radius: CGFloat = 10) {
        cornerRadius(radius)
        self.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
    
    func leftCornerRadius(_ radius: CGFloat = 10) {
        cornerRadius(radius)
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    func rightCornerRadius(_ radius: CGFloat = 10) {
        cornerRadius(radius)
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    func topAndBottomLeftCornerRadius(_ radius: CGFloat = 10) {
        cornerRadius(radius)
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
    }
    
    func topAndBottomRightCornerRadius(_ radius: CGFloat = 10) {
        cornerRadius(radius)
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    func topLeftAndBottomRightCornerRadius(_ radius: CGFloat = 10) {
        cornerRadius(radius)
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    // gradient
    func applyGradientLayer(colors: [UIColor], locations: [NSNumber]?) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0.08))

//        layer.addSublayer(gradientLayer)
        layer.insertSublayer(gradientLayer, at: 0)
    }

    func applyGradientLayer(colors: [UIColor], orientation: GradientOrientation) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = orientation.startPoint
        gradientLayer.endPoint = orientation.endPoint

        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0.08))

//        layer.addSublayer(gradientLayer)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    class func initFromNib<T: UIView>() -> T {
        return UINib(nibName: String(describing: self), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! T
//        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?[0] as! T
    }
    
    func addSubviewForLayout(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func drawDashBorder(dashWidth: CGFloat = 1, dashColor: UIColor? = .red, dashLength: NSNumber = 6, betweenDashesSpace: NSNumber = 6, cornerRadius: CGFloat = 8.0) -> CAShapeLayer {
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = dashColor?.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [dashLength,betweenDashesSpace]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: cornerRadius).cgPath
        layer.addSublayer(shapeLayer)
        return shapeLayer
    }
    
    func createDottedLine(width: CGFloat, color: UIColor, lineDash: [NSNumber]) {
        let caShapeLayer = CAShapeLayer()
        caShapeLayer.strokeColor = color.cgColor
        caShapeLayer.lineWidth = width
        caShapeLayer.lineDashPattern = lineDash
        let cgPath = CGMutablePath()
        let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: self.frame.size.height)]
        cgPath.addLines(between: cgPoint)
        caShapeLayer.path = cgPath
        layer.addSublayer(caShapeLayer)
    }
    
    func addShapeLayer(_ strokeColor: UIColor,_ width: CGFloat,_ height: CGFloat,_ lineWidth: CGFloat = 1, _ x: CGFloat = 0, _ y: CGFloat = 0, radius: CGFloat = 10)  {
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        let shapeRect = CGRect(x: x, y: y, width: width, height: height)

        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: width / 2, y: height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6, 6]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: radius).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    var heightOfView: CGFloat {
        return self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    }
    
    var widthOfView: CGFloat {
        return self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width
    }
    
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }

    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        addSubview(border)
    }
    
    func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            responder = responder?.next
            if let viewController = responder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

extension UIView {
    var primaryKey: String? {
        get {
            return objc_getAssociatedObject(self, &UIViewKeyAssociationKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &UIViewKeyAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func isPrimaryKeyEqual(to key: String) -> Bool {
        print("---------------------- primaryKey: \(key) - \(self.primaryKey != key)")
        guard let primaryKey = self.primaryKey else { return false }
        return self.primaryKey != key
    }
    
    func captureAsImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
