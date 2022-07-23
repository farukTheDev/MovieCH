//
//  UIImageView+Extension.swift
//  MovieChallange
//
//  Created by Ömer Faruk KISIK on 23.07.2022.
//

import UIKit


extension UIImageView {
    
    func applyVerticalGradient(){
        let view = UIView(frame: self.frame)
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradient, at: 0)
        self.addSubview(view)
        self.bringSubviewToFront(view)
    }
    
}
