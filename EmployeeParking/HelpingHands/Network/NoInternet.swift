//
//  NoInternet.swift
//  MENiiT
//
//  Created by Lavaneesh Tyagi on 03/06/23.
//  Copyright © 2023 Made Easy. All rights reserved.
//


import UIKit

class MyButton: UIButton {

    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.layer.cornerRadius=self.frame.size.height/2
        //        self.backgroundColor = appColor
    }
}

protocol OppsDataRefreshProtocol {
    func oppsDataRefresh()
}

class NoInternet: UIViewController {
    var delegateRefreshData: OppsDataRefreshProtocol?
    @IBOutlet weak var btnTry: MyButton!
    
    @IBOutlet weak var lblNoInternetMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad();
        localizeString()
        // lblNoInternetMessage.text = "No internet connection found.\nCheck your connection."
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func localizeString() {
        
        let formattedString = NSMutableAttributedString()
        formattedString
            .medium32("O")
            .medium27("oops!")
        (self.view.viewWithTag(50) as! UILabel).attributedText = formattedString
        (self.view.viewWithTag(51) as! UILabel).text = "No internet connection found.\nCheck your connection."
        (self.view.viewWithTag(52) as! UIButton).setTitle("Try Again", for: .normal)
        
    }
    
    // override func viewDidLayoutSubviews() {
    //    btnTry.circle()
    // }
    
    @IBAction func actionButtons(_ sender: Any) {
        if Connectivity.isConnectedToInternet() {
            self.dismiss(animated: false)
        }
        if delegateRefreshData != nil{
            delegateRefreshData?.oppsDataRefresh()
        }
    }
}

//MARK: - CHECK CONNECTIVITY
class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return AppHelper.reachabilityCheck()
    }
}



