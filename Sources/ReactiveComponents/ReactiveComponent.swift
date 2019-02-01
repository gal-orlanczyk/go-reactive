//
//  ReactiveComponent.swift
//  GoReactive
//
//  Created by Gal Orlanczyk on 25/12/2018.
//

import Foundation

public protocol ReactiveComponentProtocol {
    associatedtype Component
    var component: Component { get }
}

public struct ReactiveComponent<Component>: ReactiveComponentProtocol {
    public let component: Component
    
    public init(_ component: Component) {
        self.component = component
    }
}

extension ReactiveComponent where Component: AnyObject {
    
    func binder<E>(setter: @escaping (Component, E) -> Void) -> Binder<E> {
        return Binder<E>(target: self.component, setter: setter)
    }
}

public protocol ReactiveComponentProvider {
    associatedtype Component
    static var reactiveComponent: ReactiveComponent<Component>.Type { get }
    var reactiveComponent: ReactiveComponent<Component> { get }
}

public extension ReactiveComponentProvider {
    
    static var reactiveComponent: ReactiveComponent<Self>.Type {
        return ReactiveComponent<Self>.self
    }
    
    var reactiveComponent: ReactiveComponent<Self> {
        return ReactiveComponent(self)
    }
}

extension NSObject: ReactiveComponentProvider {}
