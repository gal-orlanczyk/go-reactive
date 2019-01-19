//
//  ReactiveComponent+UILabel.swift
//  GoReactive
//
//  Created by Gal Orlanczyk on 25/12/2018.
//

import UIKit

extension ReactiveComponent where Component: UILabel {
    
    public var text: Binder<String?> {
        return binder { (label, value) in
            label.text = value
        }
    }
    
    public var attributedText: Binder<NSAttributedString?> {
        return binder { (label, value) in
            label.attributedText = value
        }
    }
}
