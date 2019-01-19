//
//  ReactiveComponent+UISwitch.swift
//  GoReactive
//
//  Created by Gal Orlanczyk on 25/12/2018.
//

import UIKit

extension ReactiveComponent where Component: UISwitch {
    
    public var isOn: BidirectionalControlBinder<Bool> {
        return self.isOnBidirectionalControlBinder(animated: false)
    }
    
    public var isOnAnimated: BidirectionalControlBinder<Bool> {
        return self.isOnBidirectionalControlBinder(animated: true)
    }
    
    private func isOnBidirectionalControlBinder(animated: Bool) -> BidirectionalControlBinder<Bool> {
        return self.editableBidirectionalControlBinder(getter: { (uiSwitch) in
            return uiSwitch.isOn
        }, setter: { (uiSwitch, isOn) in
            uiSwitch.setOn(isOn, animated: animated)
        })
    }
}
