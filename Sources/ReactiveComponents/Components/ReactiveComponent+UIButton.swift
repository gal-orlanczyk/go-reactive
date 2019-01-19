//
//  ReactiveComponent+UIButton.swift
//  GoReactive
//
//  Created by Gal Orlanczyk on 25/12/2018.
//

import UIKit

extension ReactiveComponent where Component: UIButton {
    
    public var touchUpInside: Observable<Void> {
        return self.controlObservable(for: .touchUpInside)
    }
    
    public func title(for controlState: UIControl.State = []) -> Binder<String?> {
        return binder { (button, title) in
            button.setTitle(title, for: controlState)
        }
    }
    
    public func attributedTitle(for controlState: UIControl.State = []) -> Binder<NSAttributedString?> {
        return binder { (button, title) in
            button.setAttributedTitle(title, for: controlState)
        }
    }
}
