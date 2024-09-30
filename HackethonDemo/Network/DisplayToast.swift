//
//  DisplayToast.swift
//  MVVMModelDemo
//
//  Created by Pankaj Chauhan on 30/09/24.
//

import UIKit

class DisplayToast {
    static let shared = DisplayToast()
    var showToast = false
    
    private init() { }
    
    func fshowToastMsg(message : String) {
        
        if self.showToast {
            print("Toast ~~ Already in screen.")
        }
        else {
            self.showToast = true
            
            let toastView = UILabel()
            
            if message.contains("Online")
            { toastView.backgroundColor = UIColor.green.withAlphaComponent(0.7) }
            else
            { toastView.backgroundColor = UIColor.black.withAlphaComponent(0.7) }
            
            toastView.textColor = UIColor.white
            toastView.textAlignment = .center
            toastView.font = UIFont.preferredFont(forTextStyle: .subheadline)
            toastView.layer.cornerRadius = 8
            toastView.layer.masksToBounds = true
            toastView.text = message
            toastView.numberOfLines = 0
            toastView.alpha = 0
            toastView.translatesAutoresizingMaskIntoConstraints = false
            
            let window = UIApplication.shared.delegate?.window!
            window?.addSubview(toastView)
            
            let horizontalCenterContraint: NSLayoutConstraint = NSLayoutConstraint(item: toastView, attribute: .centerX, relatedBy: .equal, toItem: window, attribute: .centerX, multiplier: 1, constant: 0)
            
            let width = UIScreen.main.bounds.width * 0.75
            let widthContraint: NSLayoutConstraint = NSLayoutConstraint(item: toastView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: width)
            
            let verticalContraint: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=200)-[loginView(==50)]-68-|", options: [.alignAllCenterX, .alignAllCenterY], metrics: nil, views: ["loginView": toastView])
            
            NSLayoutConstraint.activate([horizontalCenterContraint, widthContraint])
            NSLayoutConstraint.activate(verticalContraint)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                toastView.alpha = 1
            }, completion: nil)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(2 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                    toastView.alpha = 0
                }, completion: { finished in
                    
                    self.showToast = false
                    toastView.removeFromSuperview()
                })
            })
        }
    }
    
    func openView_NoInternet<T: UIViewController>(controller: T, isOpen: Bool) {
        let noInternet_View = NoInternet()
        noInternet_View.modalPresentationStyle = .overCurrentContext
        
        
        if isOpen
        { controller.present(noInternet_View, animated: false, completion: nil) }
        else
        { controller.dismiss(animated: false) }
    }
}
