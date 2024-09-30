//
//  Extension+NSMutableString.swift
//  HackethonDemo
//
//  Created by Pankaj Chauhan on 30/09/24.
//

import UIKit


extension NSMutableAttributedString {
    
    @discardableResult func bold7(_ text:String) -> NSMutableAttributedString {
        let attrs:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.bold)]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    @discardableResult func bold(_ text:String) -> NSMutableAttributedString {
        let attrs:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.bold)]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    @discardableResult func bold1(_ text:String) -> NSMutableAttributedString {
        let attrs:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)]
        let boldString = NSMutableAttributedString(string:"\(text.capitalized)", attributes:attrs)
        self.append(boldString)
        return self
    }
    @discardableResult func bold2(_ text:String) -> NSMutableAttributedString {
        let attrs:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)]
        let boldString = NSMutableAttributedString(string:"\(text.capitalized)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    @discardableResult func medium(_ text:String) -> NSMutableAttributedString {
        let attrs:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    @discardableResult func medium1(_ text:String) -> NSMutableAttributedString {
        let attrs:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    @discardableResult func medium2(_ text:String) -> NSMutableAttributedString {
        let attrs:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    @discardableResult func normal7(_ text:String)->NSMutableAttributedString {
        let attrs:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 7, weight: UIFont.Weight.regular)]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    @discardableResult func normal(_ text:String)->NSMutableAttributedString {
        let attrs:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    @discardableResult func normal1(_ text:String)->NSMutableAttributedString {
        let attrs:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    @discardableResult func normal1ForiPad(_ text:String)->NSMutableAttributedString {
           let attrs:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.regular)]
           let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
           self.append(boldString)
           return self
       }
    
    @discardableResult func normal12(_ text:String)->NSMutableAttributedString {
        let attrs:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    @discardableResult func normal2(_ text:String)->NSMutableAttributedString {
        let attrs:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    
   
    @discardableResult func medium32(_ text:String) -> NSMutableAttributedString {
        let attrs:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.medium)]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    @discardableResult func medium27(_ text:String) -> NSMutableAttributedString {
        let attrs:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 27, weight: UIFont.Weight.medium)]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
   
   
    @discardableResult func font10(_ text:String) -> NSMutableAttributedString {
        let attrs:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)]
        let boldString = NSMutableAttributedString(string:"\(text.capitalized)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    @discardableResult func font8(_ text:String) -> NSMutableAttributedString {
        let attrs:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 8, weight: UIFont.Weight.regular)]
        let boldString = NSMutableAttributedString(string:"\(text.capitalized)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    
    @discardableResult func name(_ text:String) -> NSMutableAttributedString {
        let attrs:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    
    @discardableResult func cross(_ text:String)->NSMutableAttributedString {
        let attrs:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.bold), NSAttributedString.Key.foregroundColor : UIColor.red]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    //
    @discardableResult func whiteBold(_ text:String)->NSMutableAttributedString {
        let attrs:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular) , NSAttributedString.Key.foregroundColor : UIColor.white]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        
        self.append(boldString)
        return self
    }
    
    @discardableResult func whiteNormal(_ text:String)->NSMutableAttributedString {
        let attrs:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular) , NSAttributedString.Key.foregroundColor : UIColor.white]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        
        self.append(boldString)
        return self
    }
   
}
