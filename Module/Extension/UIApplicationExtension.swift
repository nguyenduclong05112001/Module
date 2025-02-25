//
//  UIApplication.swift
//  LS
//
//  Created by macmini on 22/08/2023.
//

import Foundation
import UIKit

extension UIApplication {
    
    var statusBarView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 987654321

            if let statusBar = UIApplication.shared.keyWindow?.viewWithTag(tag) {
                return statusBar
            }
            else {
                let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
                statusBarView.tag = tag

                UIApplication.shared.keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
        } else {
             if responds(to: Selector(("statusBar"))) {
                 return value(forKey: "statusBar") as? UIView
             }
        }
        return nil
    }
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
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
    
    class func topTabBarController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topTabBarController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            return tabController
        }
        if let presented = controller?.presentedViewController {
            return topTabBarController(controller: presented)
        }
        return controller
    }
}
