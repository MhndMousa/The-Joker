//
//  SpinnerVeiw.swift
//  The Joker
//
//  Created by Muhannad Alnemer on 12/29/19.
//  Copyright © 2019 Muhannad Alnemer. All rights reserved.
//

import Foundation

import UIKit
var spinner : UIView?
extension UIView{
    func showSpinner(){
        let spinnerView = UIView.init(frame: bounds)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        ai.color = .gray
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            self.addSubview(spinnerView)
        }
        
        spinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            spinner?.removeFromSuperview()
            spinner = nil
        }
    }

}
