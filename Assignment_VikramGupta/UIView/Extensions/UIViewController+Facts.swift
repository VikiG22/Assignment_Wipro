//
//  Extensions.swift
//  Assignment_VikramGupta
//
//  Created by Vikram Gupta on 7/24/20.
//  Copyright © 2020 Vikram Gupta. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    //Method for show Alert
    func showAlert(message: String?, title: String = Message.header.rawValue, delay: Double = 0.0) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            let alertController = UIAlertController(title: title, message: message ?? "", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    //Method for show Activity indicator when data api call
    func activityStartAnimating(activityColor: UIColor, backgroundColor: UIColor) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 475647
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        if #available(iOS 13.0, *) {
            activityIndicator.style = UIActivityIndicatorView.Style.large
        } else {
            activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        }
        activityIndicator.color = activityColor
        activityIndicator.startAnimating()
        activityIndicator.backgroundColor = .lightGray
        self.view.isUserInteractionEnabled = false
        
        backgroundView.addSubview(activityIndicator)
        self.view.addSubview(backgroundView)
    }
    
    //Method for hide Activity indicator
    func activityStopAnimating() {
        if let background = self.view.viewWithTag(475647){
            background.removeFromSuperview()
        }
        self.view.isUserInteractionEnabled = true
    }
}

