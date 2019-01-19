//
//  Cancelable.swift
//  GoReactive
//
//  Created by Gal Orlanczyk on 25/12/2018.
//

import Foundation

/// Defines a protocol for objects that can be canceled.
public protocol Cancelable {
    func cancel()
}

public extension Cancelable {
    
    /// Adds a cancelable to a `CancelableGroup` object.
    ///
    /// - Parameter cancelableGroup: The cancelable group to add the cancelable object.
    func add(to cancelableGroup: CancelableGroup) {
        cancelableGroup.add(self)
    }
}

/// Empty cancelable object.
/// can be used to return a cancelable object when creating observable or when nothing needs to happen on canceling.
final fileprivate class EmptyCancelable: Cancelable {
    public func cancel() {}
}

/// Utilities objects for cancelables.
public struct Cancelables {}

public extension Cancelables {
    /// produces an empty cancelable object
    static func create() -> Cancelable {
        return EmptyCancelable()
    }
}

/// `CancelableGroup` is an object that holds cancelable objects and is a cancelable object by himself.
/// allows returning a cancelable object with multiple items to cancel when need to dispose.
public class CancelableGroup: Cancelable {
    
    private var cancelables: [Cancelable]
    
    public init(_ cancelables: [Cancelable] = []) {
        self.cancelables = cancelables
    }
    
    deinit {
        self.cancelAll()
    }
    
    public func add(_ cancelable: Cancelable) {
        self.cancelables.append(cancelable)
    }
    
    public func cancel() {
        self.cancelAll()
    }
    
    private func cancelAll() {
        self.cancelables.forEach {
            $0.cancel()
        }
        self.cancelables.removeAll()
    }
}
