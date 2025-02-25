//
//  ViewService.swift
//  LS
//
//  Created by macmini on 04/08/2023.
//

import UIKit


public class ViewService {
    public static let shared = ViewService()
    
//    class func renderShowHideView(isShow: Bool, zeroHeightConstraint: Constraint, bottomSpaceConstraint: Constraint) {
//        if isShow {
//            zeroHeightConstraint.deactivate()
//            bottomSpaceConstraint.activate()
//        }
//        else {
//            zeroHeightConstraint.activate()
//            bottomSpaceConstraint.deactivate()
//        }
//    }
    
    /**
     Method to find top most view controller
     - Returns: UIViewController?
     */
    public func findTopMostViewController() -> UIViewController?{
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    public func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    public func findParentPageViewController(_ viewController: UIViewController?) -> UIPageViewController? {
        var parentViewController = viewController?.parent
        while parentViewController != nil {
            if let pageViewController = parentViewController as? UIPageViewController {
                return pageViewController
            }
            parentViewController = parentViewController?.parent
        }
        return nil
    }
}

public class Debouncer {
    public var callback: (() -> Void)
    public var delay: Double
    public weak var timer: Timer?

    public init(delay: Double, callback: @escaping (() -> Void)) {
        self.delay = delay
        self.callback = callback
    }

    public func call() {
        timer?.invalidate()
        let nextTimer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(Debouncer.fireNow), userInfo: nil, repeats: false)
        timer = nextTimer
    }

    @objc func fireNow() {
        self.callback()
    }
}
