//
//  HelperClass.swift
//  AllTopicDemo
//
//  Created by Sunil Singh on 26/09/24.
//

import Foundation
import UIKit
import Toaster
import SwiftUI

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


class CommonUtils {
    // MARK: - Toast Popup Methods
    // To show toast popup with message.
    static func showToast(message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            Toast(text: (message.count > 0) ? message : AlertMsg.kDefaultErrorMsg).show()
        }
    }
}


struct AlertMsg {
    
    static let pleaseEnterEmailId = "Please enter email id."
    static let pleaseEnterName = "Please enter name."
    static let pleaseEnterValidName = "Please enter a valid name."
    static let pleaseEnterValidEmailId = "Please enter valid email id."
    static let pleaseEnterMobileNumber = "Please enter Email ID / Mobile number."
    static let pleaseEnterValidMobileNumber = "Please enter valid mobile number."
    static let pleaseEnterValidMobileNumbervalid = "Please enter valid Email ID / mobile number."
    static let pleaseEnterPassword = "Please enter password."
    static let pleaseEnterNewPassword = "Please enter new password."
    static let validPasswordLengthLogin = "Password must vary from 8 to 13 characters"
    static let validComfirmPasswordLength = "Confirm Password must vary from 8 to 13 characters"
    static let validPasswordLengthSignup = "Password should be contain 1 Special character 1 UpperCase 1 LowerCase 1 Number & Minimum 8 characters"
    static let pleaseEnterConfirmPassword = "Please enter confirm password."
    static let passwordDoesNotMatch = "Password does not match."
    static let pleaseEnterValidPassword = "Please enter valid password."
    static let pleaseEnterValidConfirmPassword = "Please enter valid confirm password."
    static let passwordAndConfirmPasswordNotMatched = "Password and confirm password not matched."
    static let kDefaultErrorMsg    = "Something went wrong. Please try again."
}

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
