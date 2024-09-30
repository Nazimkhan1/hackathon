//
//  HelperClass.swift
//  AllTopicDemo
//
//  Created by Sunil Singh on 26/09/24.
//

import Foundation
import UIKit

class AppHelper: NSObject {

    class  func reachabilityCheck()->Bool {
        let reachability = try! Reachability()
        
        if reachability.connection != .unavailable {
            return true
        } else {
            return false
        }
    }
    
}
extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
}


extension UIApplication {
    
    class func getTopViewController(base: UIViewController? = {
        // Get the key window in a multi-scene app
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?.rootViewController
    }()) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        
        return base
    }

}


open class AlertController {
    
    // MARK: - Singleton
    static let instance = AlertController()
    
    func topMostController() -> UIViewController? {
        // Get the active window's rootViewController
        if let keyWindow = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }),
           var topController = keyWindow.rootViewController {
            // Traverse through presented view controllers to find the top-most controller
            while let presentedVC = topController.presentedViewController {
                topController = presentedVC
            }
            return topController
        }
        return nil
    }

    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        AlertController.instance.topMostController()?.present(alert, animated: true, completion: nil)
    }
}
