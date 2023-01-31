//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Kovs on 31.01.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        // UIView... - variadic parameters
        
        for view in views {
            addSubview(view)
        }
    }
}
