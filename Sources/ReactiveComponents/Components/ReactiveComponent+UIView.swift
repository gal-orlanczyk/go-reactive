//
//  ReactiveComponent+UIView.swift
//  GoReactive
//
//  Created by Gal Orlanczyk on 25/12/2018.
//

import UIKit

extension ReactiveComponent where Component: UIView {
    
    public var isHidden: Binder<Bool> {
        return binder { (view, value) in
            view.isHidden = value
        }
    }
    
    public var alpha: Binder<CGFloat> {
        return binder { (view, value) in
            view.alpha = value
        }
    }
}
