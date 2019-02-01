//
//  Bindable.swift
//  GoReactive
//
//  Created by Gal Orlanczyk on 25/12/2018.
//

import Foundation

/// Defines a bindable protocol. every object implementing this will be able to bind itself to an observer.
public protocol Bindable {
    associatedtype Element
    /// binds a bindable object to an observer.
    ///
    /// For example, when you want to bind property value changes to a ui element.
    func bind<O: ObserverProtocol>(to observer: O) -> Cancelable where O.Element == Element
}

public extension ObserverProtocol {
    /// binds an observer from bindable object.
    ///
    /// For example, when you want to bind ui element value to property value changes.
    func bind<B: Bindable>(from bindable: B) -> Cancelable where B.Element == Element {
        return bindable.bind(to: self)
    }
}
