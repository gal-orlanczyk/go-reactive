//
//  Binder.swift
//  GoReactive
//
//  Created by Gal Orlanczyk on 25/12/2018.
//

import Foundation

public struct Binder<Element>: ObserverProtocol {
    
    public typealias Target = AnyObject
    
    private typealias BindingHandler = (Event<Element>) -> Void
    
    private let bindingHandler: BindingHandler
    
    public init<T: Target>(target: T, setter: @escaping (T, Element) -> Void) {
        weak var target = target
        self.bindingHandler = { event in
            switch event {
            case .next(let value):
                if let target = target {
                    setter(target, value)
                }
            case .error, .completed: break
            }
        }
    }
    
    public func on(_ event: Event<Element>) {
        self.bindingHandler(event)
    }
    
    public func asObserver() -> Observer<Element> {
        return Observer(eventHandler: self.on)
    }
}
