//
//  ReactiveComponent+UITextField.swift
//  GoReactive
//
//  Created by Gal Orlanczyk on 25/12/2018.
//

import UIKit

extension ReactiveComponent where Component: UITextField {
    
    public var text: BidirectionalControlBinder<String?> {
        return self.editableBidirectionalControlBinder(getter: { (textField) in
            return textField.text
        }, setter: { (textField, value) in
            // make sure we only change the text if it was changed
            guard textField.text != value else { return }
            textField.text = value
        })
    }
    
    public var attributedText: BidirectionalControlBinder<NSAttributedString?> {
        return self.editableBidirectionalControlBinder(getter: { (textField) in
            return textField.attributedText
        }, setter: { (textField, value) in
            // make sure we only change the text if it was changed
            guard textField.attributedText != value else { return }
            textField.attributedText = value
        })
    }
}

