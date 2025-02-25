//
//  UIViewControllerExtension.swift
//  LS
//
//  Created by macmini on 11/08/2023.
//

import Foundation
import UIKit

extension UIViewController {
    func presentOverContext(_ viewController: UIViewController, animated: Bool, transitionStyle: UIModalTransitionStyle = .crossDissolve, completion: (()->())?) {
        viewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        viewController.modalTransitionStyle = transitionStyle
        if let tabBarController = tabBarController {
            DispatchQueue.main.async {
                tabBarController.present(viewController, animated: animated, completion: completion)
            }
            
        }
        else if let navigationController = navigationController {
            DispatchQueue.main.async {
                navigationController.present(viewController, animated: animated, completion: completion)
            }
            
        }
        else {
            DispatchQueue.main.async {[weak self] in
                if let weakSelf = self {
                    weakSelf.present(viewController, animated: animated, completion: completion)
                }
                
                
            }
            
        }
        
    }
    func customPresent(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        present(viewControllerToPresent, animated: true, completion: completion)
    }
    
    func showAlert(title: String?,
                   message: String?,
                   actionTitles: [String?],
                   style: [UIAlertAction.Style],
                   actions: [((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           for (index, title) in actionTitles.enumerated() {
               let action = UIAlertAction(title: title, style: style[index], handler: actions[index])
               alert.addAction(action)
           }
           self.present(alert, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
//        if motion == .motionShake {
//            UIGraphicsBeginImageContextWithOptions(view.frame.size, true, 0.0)
//
//             // renders the view's layer into the current graphics context
//             if let context = UIGraphicsGetCurrentContext() { view.layer.render(in: context) }
//
//             // creates UIImage from what was drawn into graphics context
//             let screenshot: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
//
//             // clean up newly created context and return screenshot
//             UIGraphicsEndImageContext()
//
//            if ReportView.sharedInstance.superview == nil {
//                ReportView.sharedInstance.imageViewTest.image = screenshot
//                let window = UIApplication.shared.keyWindow!
//                window.addSubview(ReportView.sharedInstance)
//                ReportView.sharedInstance.animationIn()
//            }
//        }
    }
}
