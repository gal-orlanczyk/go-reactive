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
    func bind<O: ObserverProtocol>(to observer: O) -> Cancelable where O.Element == Element
}

/// Defines comformance of `Observable` object to bindable by subscribe to the observer.
public extension ObservableProtocol {
    
    func bind<O: ObserverProtocol>(to observer: O) -> Cancelable where O.Element == Element {
        return self.subscribe(observer)
    }
}
